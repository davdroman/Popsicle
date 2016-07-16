<p align="center">
	<img src="https://www.dropbox.com/s/26i17fvh2ersrcs/header.png?raw=1" alt="Popsicle header" width="520px" />
</p>

<p align="center">
	<a href="https://github.com/Carthage/Carthage"><img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg" alt="Carthage compatible" /></a>
	<a href="https://cocoapods.org/pods/Popsicle"><img src="https://img.shields.io/cocoapods/v/Popsicle.svg" alt="CocoaPods compatible" /></a>
	<img src="https://img.shields.io/badge/Swift-3.0-orange.svg" alt="Swift version" />
	<a href="https://travis-ci.org/DavdRoman/Popsicle"><img src="https://img.shields.io/travis/DavdRoman/Popsicle/swift-3.0.svg" alt="Travis status" /></a>
</p>

<p align="center">
	<img src="https://www.dropbox.com/s/fgonke0ro98o1ge/1.gif?raw=1" alt="GIF 1" width="320px" />
</p>

Popsicle is a Swift framework for creating and managing interpolations of different value types with built-in UIKit support.

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

#### Interpolating UIView (or any other NSObject) values

First, you need an `Interpolator` instance:

```swift
let interpolator = Interpolator()
```

Next, you need to add some `Interpolation<T>` instances to your interpolator. In the example below, we are going to interpolate the alpha value of a UIView for times between 0 and 150:

```swift
let interpolation = Interpolation(yourView, alpha)
interpolation[0] = 0
interpolation[150] = 1
self.interpolator.addInterpolation(interpolation)
```

Note `alpha` is a built-in `KeyPath<T, U>` constant. Popsicle offers a nice set of [__UIKit-related KeyPaths__](Popsicle/KeyPath.swift) ready to be used. You may also use a completely custom key path.

You can also modify the easing function used at a given time:

```swift
interpolation.setEasingFunction(EasingFunctionEaseOutQuad, forTime: 0)
```

There's a bunch of [__built-in easing functions__](Popsicle/EasingFunction.swift) to choose from.

Finally, just make your `interpolator` vary its `time` depending on whatever you want. For example, the content offset of a `UITableView`:

```swift
func scrollViewDidScroll(scrollView: UIScrollView) {
	interpolator.time = Double(scrollView.contentOffset.y)
}
```

#### Interpolating custom values

You can declare a value type as interpolable by making it conform to the `Interpolable` protocol.

As an example, check out how `CGPoint` conforms to `Interpolable`:

```swift
extension CGSize: Interpolable {
	public static func interpolate(from fromValue: CGSize, to toValue: CGSize, withProgress progress: Progress) -> CGSize {
		let width = CGFloat.interpolate(from: fromValue.width, to: toValue.width, withProgress: progress)
		let height = CGFloat.interpolate(from: fromValue.height, to: toValue.height, withProgress: progress)

		return CGSizeMake(width, height)
	}

	public static func objectify(value: CGSize) -> AnyObject {
		return NSValue(CGSize: value)
	}
}
```

## License

Popsicle is available under the MIT license.
