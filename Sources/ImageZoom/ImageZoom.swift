//
//  Created by Mark Battistella
//	@markbattistella
//

import Ink
import Plot
import Files
import Publish


// MARK: - create the plugin
public extension Plugin {
	static func zoomImage(showCaption: Bool = true) -> Self {
		Plugin(name: "ImageZoom") { context in

			// -- add the script
			let jsFile = try context.createOutputFile(at: "zoom-image.js")
			try jsFile.write(zoomImageJavascriptFile())

			context.markdownParser.addModifier(
				.zoomImage(showCaption: showCaption)
			)
		}
	}
}

// MARK: - create the modifiers
public extension Modifier {
	internal static func zoomImage(showCaption: Bool) -> Self {
		Modifier(target: .images) { html, markdown in
			return Builder()
				.zoom(showCaption: showCaption, html: html, markdown: markdown)
		}
	}
}

// MARK: - custom JS file
fileprivate func zoomImageJavascriptFile() -> String {
	return try! File(path: #filePath)
		.parent?
		.file(named: "Support/Utilities/zoom-image.js")
		.readAsString() as! String
}
