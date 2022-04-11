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
	static func zoomImage(showCaption: Bool = false) -> Self {
		Plugin(name: "ImageZoom") { context in

			// -- add the script
			let jsFile = try context.createOutputFile(at: "assets/js/zoom-image.js")
			try jsFile.write(zoomImageJavascriptFile())

			context.markdownParser.addModifier(
				.zoomImageModifier(caption: showCaption)
			)
		}
	}
}


// MARK: - create the modifiers
public extension Modifier {
	internal static func zoomImageModifier(caption: Bool) -> Self {
		Modifier(target: .images) { html, markdown in
			return Renderer()
				.addZoomEffect(showCaption: caption, html: html, markdown: markdown)
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
