//
//	markbattistella.com
//  Created by Mark Battistella
//

import Plot
import Foundation

extension Node where Context: HTML.BodyContext {

	// -- create the <figure> elements
	static func figure(_ nodes: Node<Context>...) -> Node {
		return .element(named: "figure", nodes: nodes)
	}

	static func figcaption(_ nodes: Node<Context>...) -> Node {
		return .element(named: "figcaption", nodes: nodes)
	}
}
