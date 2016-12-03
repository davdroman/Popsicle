<p align="center">
	<img src="https://www.dropbox.com/s/tf8dsdegfl5pcr4/header.png?raw=1" alt="Popsicle header" width="520px" />
</p>

<p align="center">
	<a href="https://github.com/Carthage/Carthage"><img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg" alt="Carthage compatible" /></a>
	<a href="https://cocoapods.org/pods/Popsicle"><img src="https://img.shields.io/cocoapods/v/Popsicle.svg" alt="CocoaPods compatible" /></a>
	<img src="https://img.shields.io/badge/Swift-3.0-orange.svg" alt="Swift version" />
	<a href="https://travis-ci.org/DavdRoman/Popsicle"><img src="https://img.shields.io/travis/DavdRoman/Popsicle/swift-3.0.svg" alt="Travis status" /></a>
</p>

<p align="center">
	<img src="https://www.dropbox.com/s/xm8vzq16eg7f95a/1.gif?raw=1" alt="GIF 1" width="320px" />
</p>

## Installation

#### Carthage

```
github "DavdRoman/Popsicle"
```

#### CocoaPods

```ruby
pod 'Popsicle'
```

#### Manual

Drag and copy all files in the [__Popsicle__](Popsicle) folder into your project.

## At a glance

#### Interpolating UIView values

First, you need an `InterpolationSet` (think of it as `[Interpolation]`, which hopefully will be the case with Swift 4):

```swift
let interpolations = InterpolationSet()
```

Next, you need to add some `Interpolation` instances to your set. In the example below, we are going to interpolate the alpha value of a UIView for times between 0 and 150:

```swift
let interpolation = Interpolation(yourView, alpha)
interpolation[0] = 0
interpolation[150] = 1
interpolations.append(interpolation)
```

Note `alpha` is a `KeyPath` constant. Popsicle offers a built-in set of [__UIKit KeyPaths__](Popsicle/KeyPath+UIKit.swift) ready to be used. You may also use your own custom key paths.

You can also modify the easing function used at a given time:

```swift
interpolation[f: 0] = (0, easeOutQuad)
```

There's a bunch of [__built-in easing functions__](Popsicle/EasingFunction.swift) to choose from.

Finally, just make your `interpolations` vary their `time` depending on any parameter you consider appropriate. For example, the content offset of a `UITableView`:

```swift
func scrollViewDidScroll(scrollView: UIScrollView) {
	interpolations.time = Time(scrollView.contentOffset.y)
}
```

#### Interpolating custom values

You can declare a value type as interpolable by making it conform to the `Interpolable` protocol.

As an example, check out how `CGPoint` conforms to `Interpolable`:

```swift
extension CGPoint: Interpolable {
	static func interpolate(from fromValue: CGPoint, to toValue: CGPoint, at time: Time) -> CGPoint {
		let x = CGFloat.interpolate(from: fromValue.x, to: toValue.x, at: time)
		let y = CGFloat.interpolate(from: fromValue.y, to: toValue.y, at: time)

		return CGPoint(x: x, y: y)
	}
}
```

## License

Popsicle is available under the MIT license.
