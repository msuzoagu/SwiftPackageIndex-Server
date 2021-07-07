import Plot


enum KeywordShow {

    class View: PublicPage {

        let model: Model

        init(path: String, model: Model) {
            self.model = model
            super.init(path: path)
        }

        override func pageTitle() -> String? {
            "Packages for keyword \(model.keyword)"
        }

        override func pageDescription() -> String? {
            let packagesClause = model.packages.count > 1 ? "1 package" : "\(model.packages.count) packages"
            return "The Swift Package Index is indexing \(packagesClause) for \(model.keyword)."
        }

        override func content() -> Node<HTML.BodyContext> {
            .group(
                .h2(
                    .class("trimmed"),
                    .text("Packages for keyword “\(model.keyword)”")
                ),
                .ul(
                    .id("package_list"),
                    .group(
                        model.packages.map { package -> Node<HTML.ListContext> in
                            .li(
                                .a(
                                    .href(package.url),
                                    .h4(.text(package.title)),
                                    .p(.text(package.description))
                                )
                            )
                        }
                    )
                ),
                .if(model.page == 1 && !model.hasMoreResults,
                    .p(
                        .strong("\(model.packages.count) \("package".pluralized(for: model.packages.count)).")
                    )
                ),
                .ul(
                    .class("pagination"),
                    .if(model.page > 1, .previousPage(model: model)),
                    .if(model.hasMoreResults, .nextPage(model: model))
                )
            )
        }
    }

}


fileprivate extension Node where Context == HTML.ListContext {
    static func previousPage(model: KeywordShow.Model) -> Node<HTML.ListContext> {
        let parameters = [
            QueryParameter(key: "page", value: model.page - 1)
        ]
        return .li(
            .class("previous"),
            .a(
                .href(SiteURL.keywords(.value(model.keyword))
                        .relativeURL(parameters: parameters)),
                "Previous Page"
            )
        )
    }

    static func nextPage(model: KeywordShow.Model) -> Node<HTML.ListContext> {
        let parameters = [
            QueryParameter(key: "page", value: model.page + 1)
        ]
        return .li(
            .class("next"),
            .a(
                .href(SiteURL.keywords(.value(model.keyword))
                        .relativeURL(parameters: parameters)),
                "Next Page"
            )
        )
    }
}
