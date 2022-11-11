# Image Zoom for Publish

Add a `medium.com` style image zoom for images within your document.

The script allows images to be zoomed to the full width of the view port so the user can expand images beyond the container width.

Users can continue scrolling and theimage will resign into its original place.

![demo video](demo.gif)

## Installation

To install it into your Publish package, add it as a dependency within your `Package.swift` manifest:

```swift
let package = Package(
  dependencies: [
    .package(
      name: "ImageZoom",
      url: "https://github.com/markbattistella/image-zoom-publish-plugin",
      from: "1.1.0"
	)
  ],
  targets: [
    .target(dependencies: ["ImageZoom"])
  ]
)
```

You will need to add two javascript items into your `<footer>`.

The best way to inject the script is to add it to your `.footer` element:

```swift
extension Node where Context == HTML.BodyContext {
  static func footer(for site: Website) -> Node {
    return .footer(
      ...
      .raw("<script src='zoom-image.js'></script>"),
      .raw("<script>mediumZoom('[data-zoomable="true"]', { margin: 20, background: '#FFF' });</script>")
      ...
    )
  }
}
```

## Configuration

In the script configuration is where you can set up the medium.com style zooming.

```javascript
mediumZoom('[data-zoomable="true"]', {
	margin: 20,
	background: '#FFF'
})
```

The first line is **mandatory** otherwise the images won't register the script.

You can change the `margin` and the `background`.

The `margin` is how much you want the image to be inset when enlarged into full view. It is in pixels.

The `background` is the colour of the overlay which the image sits on top of. The best way to handle it is to use a CSS variable and trigger it for light and dark mode.

For example:

```css
::root {
  --background-colour: rgb( 255, 255, 255 );
}

@media all and (prefers-color-scheme: dark) {
	::root {
	  --background-colour: rgb( 0, 0, 0 );
	}
}
```

```javascript
mediumZoom('[data-zoomable="true"]', {
	margin: 20,
	background: 'var(--background-colour)'
})
```

## Usage

### Pipeline

The plugin can then be used within any publishing pipeline like this:

```swift
import ImageZoom

try DeliciousRecipes().publish(using: [
  .installPlugin(.zoomImage())
])
```

By default it will show the image captions, however if you wish to hide them under the image do so by installing the plugin as:

```swift
import ExtraComponents

try DeliciousRecipes().publish(using: [
  .installPlugin(.zoomImage(showCaption: false))
])
```

### Markdown

When writing your markdown documents you add an image as you normally would. This will automatically be transformed into accepting the zooming attributes.

```markdown
![My image](/my-awesome-image.jpg)
```

If you want to disable the zooming on a specific image add the `nozoom` attribute after the image url:

```markdown
![My image - this wont zoom](/my-awesome-image.jpg nozoom)
```

It is case insensitive, so any variation should work: `NOZOOM`, `noZoom`, `NoZoom`, or even `nOZooM`

## Contributing

I've turned off Issues and if you wish to add/change the codebase please create a Pull Request.

This way everyone can allow these components to grow, and be the best rather than waiting on me to write it.

### How to help

1. Clone the repo: `git clone https://github.com/markbattistella/image-zoom-publish-plugin.git`
1. Create your feature branch: `git checkout -b my-feature`
1. Commit your changes: `git commit -am 'Add some feature'`
1. Push to the branch: `git push origin my-new-feature`
1. Submit the pull request
