import NIO


extension Array {

    /// Map `Result<T, Error>` elements with the given `transform` to `EventLoopFuture<U>`by transforming the sucess case and passing through the `Error` in case of failures.
    /// - Parameters:
    ///   - eventLoop: event loop
    ///   - transform: transformation
    /// - Returns: array of futures
    func map<T, U>(on eventLoop: EventLoop,
                   transform: (T) -> EventLoopFuture<U>) -> [EventLoopFuture<U>] where Element == Result<T, Error> {
        map { result in
            switch result {
                case .success(let v): return transform(v)
                case .failure(let e): return eventLoop.future(error: e)
            }
        }
    }

    func whenAllComplete<T, U>(on eventLoop: EventLoop,
                               transform: (T) -> EventLoopFuture<U>) -> EventLoopFuture<[Result<U, Error>]> where Element == Result<T, Error> {
        EventLoopFuture.whenAllComplete(
            map(on: eventLoop, transform: transform),
            on: eventLoop
        )
    }
}
