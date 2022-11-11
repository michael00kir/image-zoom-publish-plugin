//
//  Created by Mark Battistella
//	markbattistella.com
//

import Foundation
import Publish
import Ink
import Plot

// MARK: - the magic
final class Builder {

	func zoom(showCaption: Bool, html: String, markdown: Substring) -> String {

		// -- get the text component
		guard let text = markdown.content(delimitedBy: .squareBrackets) else { return html }

		// -- get the link component
		guard let link = markdown.content(delimitedBy: .parentheses) else { return html }

		// -- get the attributes
		let parts: [String] = link
			.components(separatedBy: CharacterSet.whitespaces)

		// -- get the url
		var imageUrl: String { parts[0] }

		// -- is the zoomable functionality allowed
		var isZoomable: Bool {
			if parts.count > 1 {
				if parts[1].lowercased() == "nozoom" {
					return false
				}
				return true
			}
			return false
		}

		// -- build the node
		var node: Node<HTML.BodyContext> {
			.figure(
				.img(.src(imageUrl),
					 .alt(String(text)),
					 .title(String(text)),
					 .data(named: "zoomable", value: "\(isZoomable)")
				),
				.if(showCaption && !text.isEmpty, .figcaption(.title(String(text))))
			)
		}

		// -- render the output
		return node.render()
	}
}
