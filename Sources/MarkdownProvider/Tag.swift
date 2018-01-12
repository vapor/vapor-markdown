import Leaf
import SwiftMarkdown
import Async

public final class Markdown: TagRenderer {

    public enum Error: Swift.Error {
        case invalidArgument(TemplateData?)
    }

    public let name = "markdown"

    public func render(tag: TagContext) throws -> Future<TemplateData> {

        var markdown = ""

        if let markdownArgument = tag.parameters.first, !markdownArgument.isNull {
            guard let markdownArgumentValue = markdownArgument.string else {
                throw Error.invalidArgument(tag.parameters.first)
            }
            markdown = markdownArgumentValue
        }

        let markdownHtml = try markdownToHTML(markdown)
        return Future(.string(markdownHtml))
    }

}
