//
//  Interpolable.swift
//  Popsicle
//
//  Created by David Román Aguirre on 01/11/15.
//  Copyright © 2015 David Román Aguirre. All rights reserved.
//

/// A value from 0 to 1 defining the progress of a certain interpolation between two `Interpolable` values.
public typealias Progress = Double

/// Defines a common protocol for all interpolable values.
///
/// Types conforming to this protocol are available to use as a `Interpolation` generic type.
public protocol Interpolable {
	typealias ValueType

	/// Defines how an interpolation should be performed between two given values of the type conforming to this protocol.
	static func interpolate(from fromValue: ValueType, to toValue: ValueType, withProgress: Progress) -> ValueType

	/// Converts a value to a valid `Foundation` object, if necessary.
	static func objectify(value: ValueType) -> AnyObject
}

extension Bool: Interpolable {
	public static func interpolate(from fromValue: Bool, to toValue: Bool, withProgress progress: Progress) -> Bool {
		return progress >= 0.5 ? toValue : fromValue
	}

	public static func objectify(value: Bool) -> AnyObject {
		return NSNumber(bool: value)
	}
}

extension CGFloat: Interpolable {
	public static func interpolate(from fromValue: CGFloat, to toValue: CGFloat, withProgress progress: Progress) -> CGFloat {
		return fromValue+(toValue-fromValue)*CGFloat(progress)
	}

	public static func objectify(value: CGFloat) -> AnyObject {
		return NSNumber(double: Double(value))
	}
}

extension CGPoint: Interpolable {
	public static func interpolate(from fromValue: CGPoint, to toValue: CGPoint, withProgress progress: Progress) -> CGPoint {
		let x = CGFloat.interpolate(from: fromValue.x, to: toValue.x, withProgress: progress)
		let y = CGFloat.interpolate(from: fromValue.y, to: toValue.y, withProgress: progress)

		return CGPointMake(x, y)
	}

	public static func objectify(value: CGPoint) -> AnyObject {
		return NSValue(CGPoint: value)
	}
}

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

extension CGRect: Interpolable {
	public static func interpolate(from fromValue: CGRect, to toValue: CGRect, withProgress progress: Progress) -> CGRect {
		let origin = CGPoint.interpolate(from: fromValue.origin, to: toValue.origin, withProgress: progress)
		let size = CGSize.interpolate(from: fromValue.size, to: toValue.size, withProgress: progress)

		return CGRectMake(origin.x, origin.y, size.width, size.height)
	}

	public static func objectify(value: CGRect) -> AnyObject {
		return NSValue(CGRect: value)
	}
}

extension CGAffineTransform: Interpolable {
	public static func interpolate(from fromValue: CGAffineTransform, to toValue: CGAffineTransform, withProgress progress: Progress) -> CGAffineTransform {
		let tx1 = CGAffineTransformGetTranslationX(fromValue)
		let tx2 = CGAffineTransformGetTranslationX(toValue)
		let tx = CGFloat.interpolate(from: tx1, to: tx2, withProgress: progress)

		let ty1 = CGAffineTransformGetTranslationY(fromValue)
		let ty2 = CGAffineTransformGetTranslationY(toValue)
		let ty = CGFloat.interpolate(from: ty1, to: ty2, withProgress: progress)

		let sx1 = CGAffineTransformGetScaleX(fromValue)
		let sx2 = CGAffineTransformGetScaleX(toValue)
		let sx = CGFloat.interpolate(from: sx1, to: sx2, withProgress: progress)

		let sy1 = CGAffineTransformGetScaleY(fromValue)
		let sy2 = CGAffineTransformGetScaleY(toValue)
		let sy = CGFloat.interpolate(from: sy1, to: sy2, withProgress: progress)

		let deg1 = CGAffineTransformGetRotation(fromValue)
		let deg2 = CGAffineTransformGetRotation(toValue)
		let deg = CGFloat.interpolate(from: deg1, to: deg2, withProgress: progress)

		return CGAffineTransformMake(tx, ty, sx, sy, deg)
	}

	public static func objectify(value: CGAffineTransform) -> AnyObject {
		return NSValue(CGAffineTransform: value)
	}
}

/// `CGAffineTransformMake()`, The Right Way™
///
/// - parameter tx:  translation on x axis.
/// - parameter ty:  translation on y axis.
/// - parameter sx:  scale factor for width.
/// - parameter sy:  scale factor for height.
/// - parameter deg: degrees.
public func CGAffineTransformMake(tx: CGFloat, _ ty: CGFloat, _ sx: CGFloat, _ sy: CGFloat, _ deg: CGFloat) -> CGAffineTransform {
	let translationTransform = CGAffineTransformMakeTranslation(tx, ty)
	let scaleTransform = CGAffineTransformMakeScale(sx, sy)
	let rotationTransform = CGAffineTransformMakeRotation(deg*CGFloat(M_PI_2)/180)

	return CGAffineTransformConcat(CGAffineTransformConcat(translationTransform, scaleTransform), rotationTransform)
}

func CGAffineTransformGetTranslationX(t: CGAffineTransform) -> CGFloat { return t.tx }
func CGAffineTransformGetTranslationY(t: CGAffineTransform) -> CGFloat { return t.ty }
func CGAffineTransformGetScaleX(t: CGAffineTransform) -> CGFloat { return sqrt(t.a * t.a + t.c * t.c) }
func CGAffineTransformGetScaleY(t: CGAffineTransform) -> CGFloat { return sqrt(t.b * t.b + t.d * t.d) }
func CGAffineTransformGetRotation(t: CGAffineTransform) -> CGFloat { return (atan2(t.b, t.a)*180)/CGFloat(M_PI_2) }

extension UIColor: Interpolable {
	public static func interpolate(from fromValue: UIColor, to toValue: UIColor, withProgress progress: Progress) -> UIColor {
		var fromRed: CGFloat = 0
		var fromGreen: CGFloat = 0
		var fromBlue: CGFloat = 0
		var fromAlpha: CGFloat = 0

		var toRed: CGFloat = 0
		var toGreen: CGFloat = 0
		var toBlue: CGFloat = 0
		var toAlpha: CGFloat = 0

		fromValue.getRed(&fromRed, green: &fromGreen, blue: &fromBlue, alpha: &fromAlpha)
		toValue.getRed(&toRed, green: &toGreen, blue: &toBlue, alpha: &toAlpha)

		let red = CGFloat.interpolate(from: fromRed, to: toRed, withProgress: progress)
		let green = CGFloat.interpolate(from: fromGreen, to: toGreen, withProgress: progress)
		let blue = CGFloat.interpolate(from: fromBlue, to: toBlue, withProgress: progress)
		let alpha = CGFloat.interpolate(from: fromAlpha, to: toAlpha, withProgress: progress)

		return UIColor(red: red, green: green, blue: blue, alpha: alpha)
	}

	public static func objectify(value: UIColor) -> AnyObject {
		return value
	}
}