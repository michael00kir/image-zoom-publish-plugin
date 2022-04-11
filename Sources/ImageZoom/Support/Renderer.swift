//
//  Created by Mark Battistella
//	markbattistella.com
//

import Foundation
import Publish
import Ink

final class Renderer {

	let parser = MarkdownParser()

	private enum Signifier: String {
		case noZoom = "noZoom"
	}

	func addZoomEffect(showCaption: Bool, html: String, markdown: Substring) -> String {

		// -- get the text component
		guard let text = markdown.content(delimitedBy: .squareBrackets) else { return html }

		// -- get the link component
		guard let link = markdown.content(delimitedBy: .parentheses) else { return html }

		// -- get the attributes
		let parts: [String] = link
			.components(separatedBy: CharacterSet.whitespaces)

		// -- get the url
		var imageUrl: String { parts[0] }

		// -- get the no zoom
		var attribute: String {
			if( parts.count > 1 && parts[1].lowercased() == Signifier.noZoom.rawValue.lowercased() ) {
				return " data-no-zoom"
			} else {
				return ""
			}
		}

		// -- what to return
		return """
		<figure>
			\("<img src='" + imageUrl + "' alt='" + text + "'" + attribute + ">")
			\(showCaption ? "<figcaption>" + text + "</figcaption>" : "")
		</figure>
		"""
	}
}
