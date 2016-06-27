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
	associatedtype ValueType

	/// Defines how an interpolation should be performed between two given values of the type conforming to this protocol.
	static func interpolate(from fromValue: ValueType, to toValue: ValueType, withProgress: Progress) -> ValueType

	/// Converts a value to a valid `Foundation` object, if necessary.
	static func objectify(_ value: ValueType) -> AnyObject
}

extension Bool: Interpolable {
	public static func interpolate(from fromValue: Bool, to toValue: Bool, withProgress progress: Progress) -> Bool {
		return progress >= 0.5 ? toValue : fromValue
	}

	public static func objectify(_ value: Bool) -> AnyObject {
		return NSNumber(value: value)
	}
}

extension CGFloat: Interpolable {
	public static func interpolate(from fromValue: CGFloat, to toValue: CGFloat, withProgress progress: Progress) -> CGFloat {
		return fromValue+(toValue-fromValue)*CGFloat(progress)
	}

	public static func objectify(_ value: CGFloat) -> AnyObject {
		return NSNumber(value: Double(value))
	}
}

extension CGPoint: Interpolable {
	public static func interpolate(from fromValue: CGPoint, to toValue: CGPoint, withProgress progress: Progress) -> CGPoint {
		let x = CGFloat.interpolate(from: fromValue.x, to: toValue.x, withProgress: progress)
		let y = CGFloat.interpolate(from: fromValue.y, to: toValue.y, withProgress: progress)

		return CGPoint(x: x, y: y)
	}

	public static func objectify(_ value: CGPoint) -> AnyObject {
		return NSValue(cgPoint: value)
	}
}

extension CGSize: Interpolable {
	public static func interpolate(from fromValue: CGSize, to toValue: CGSize, withProgress progress: Progress) -> CGSize {
		let width = CGFloat.interpolate(from: fromValue.width, to: toValue.width, withProgress: progress)
		let height = CGFloat.interpolate(from: fromValue.height, to: toValue.height, withProgress: progress)

		return CGSize(width: width, height: height)
	}

	public static func objectify(_ value: CGSize) -> AnyObject {
		return NSValue(cgSize: value)
	}
}

extension CGRect: Interpolable {
	public static func interpolate(from fromValue: CGRect, to toValue: CGRect, withProgress progress: Progress) -> CGRect {
		let origin = CGPoint.interpolate(from: fromValue.origin, to: toValue.origin, withProgress: progress)
		let size = CGSize.interpolate(from: fromValue.size, to: toValue.size, withProgress: progress)

		return CGRect(x: origin.x, y: origin.y, width: size.width, height: size.height)
	}

	public static func objectify(_ value: CGRect) -> AnyObject {
		return NSValue(cgRect: value)
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

	public static func objectify(_ value: CGAffineTransform) -> AnyObject {
		return NSValue(cgAffineTransform: value)
	}
}

/// `CGAffineTransformMake()`, The Right Way™
///
/// - parameter tx:  translation on x axis.
/// - parameter ty:  translation on y axis.
/// - parameter sx:  scale factor for width.
/// - parameter sy:  scale factor for height.
/// - parameter deg: degrees.
public func CGAffineTransformMake(_ tx: CGFloat, _ ty: CGFloat, _ sx: CGFloat, _ sy: CGFloat, _ deg: CGFloat) -> CGAffineTransform {
	let translationTransform = CGAffineTransform(translationX: tx, y: ty)
	let scaleTransform = CGAffineTransform(scaleX: sx, y: sy)
	let rotationTransform = CGAffineTransform(rotationAngle: deg*CGFloat(M_PI_2)/180)

	return translationTransform.concat(scaleTransform).concat(rotationTransform)
}

func CGAffineTransformGetTranslationX(_ t: CGAffineTransform) -> CGFloat { return t.tx }
func CGAffineTransformGetTranslationY(_ t: CGAffineTransform) -> CGFloat { return t.ty }
func CGAffineTransformGetScaleX(_ t: CGAffineTransform) -> CGFloat { return sqrt(t.a * t.a + t.c * t.c) }
func CGAffineTransformGetScaleY(_ t: CGAffineTransform) -> CGFloat { return sqrt(t.b * t.b + t.d * t.d) }
func CGAffineTransformGetRotation(_ t: CGAffineTransform) -> CGFloat { return (atan2(t.b, t.a)*180)/CGFloat(M_PI_2) }

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

	public static func objectify(_ value: UIColor) -> AnyObject {
		return value
	}
}
