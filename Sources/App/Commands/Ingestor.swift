import Vapor
import Fluent


struct IngestorCommand: Command {
    let defaultLimit = 2

    struct Signature: CommandSignature {
        @Option(name: "limit", short: "l")
        var limit: Int?
    }

    var help: String {
        "Ingests packages"
    }

    func run(using context: CommandContext, signature: Signature) throws {
        let limit = signature.limit ?? defaultLimit
        context.console.print("Ingesting (limit: \(limit)) ...")
        let request = try ingest(client: context.application.client,
                                 database: context.application.db,
                                 limit: limit)
        try request.wait()
    }

}


func ingest(client: Client, database: Database, limit: Int) throws -> EventLoopFuture<Void> {
    fetchMetadata(client: client, database: database, limit: limit)
        .flatMapEachThrowing { result in
            switch result {
                case let .success((pkg, md)):
                    // TODO: report and absorb error
                    return try insertOrUpdateRepository(on: database, for: pkg, metadata: md)
                        .flatMap { pkg.update(on: database) }  // mark package as updated
                case let .failure(error):
                    // TODO: report and absorb error
                    throw error
            }
        }
        .flatMap { $0.flatten(on: database.eventLoop) }
}


func fetchMetadata(client: Client, database: Database, limit: Int) -> EventLoopFuture<[Result<(Package, Github.Metadata), Error>]> {
    Package.query(on: database)
        .ingestionBatch(limit: limit)
        .flatMapEach(on: database.eventLoop) { pkg in
            do {
                return try
                    database.eventLoop.makeSucceededFuture(pkg)
                        .and(Current.fetchMetadata(client, pkg))
                        .map {
                            Result<(Package, Github.Metadata), Error>.success($0)}
            }
            catch { return database.eventLoop.makeSucceededFuture(Result.failure(error)) }
    }
}


func insertOrUpdateRepository(on db: Database, for package: Package, metadata: Github.Metadata) throws -> EventLoopFuture<Void> {
    Repository.query(on: db)
        .filter(try \.$package.$id == package.requireID())
        .first()
        .flatMap { repo -> EventLoopFuture<Void> in
            if let repo = repo {
                repo.defaultBranch = metadata.defaultBranch
                repo.description = metadata.description
                repo.forks = metadata.forksCount
                repo.license = metadata.license?.key
                repo.stars = metadata.stargazersCount
                // TODO: find and assign parent repo
                return repo.save(on: db)
            } else {
                do {
                    return try Repository(package: package, metadata: metadata)
                        .save(on: db)
                } catch {
                    return db.eventLoop.makeFailedFuture(
                        AppError.genericError("Failed to create Repository for \(package.url)")
                    )
                }
            }
        }
}


