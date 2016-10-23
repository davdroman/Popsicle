//
//  Interpolable+UIKit.swift
//  Popsicle
//
//  Created by David Román Aguirre on 30/06/16.
//  Copyright © 2016 David Román Aguirre. All rights reserved.
//

import UIKit

extension CGFloat: Interpolable {
	public static func interpolate(from fromValue: CGFloat, to toValue: CGFloat, at time: Time) -> CGFloat {
		return fromValue + (toValue-fromValue) * CGFloat(time)
	}
}

extension CGPoint: Interpolable {
	public static func interpolate(from fromValue: CGPoint, to toValue: CGPoint, at time: Time) -> CGPoint {
		let x = CGFloat.interpolate(from: fromValue.x, to: toValue.x, at: time)
		let y = CGFloat.interpolate(from: fromValue.y, to: toValue.y, at: time)

		return CGPoint(x: x, y: y)
	}
}

extension CGSize: Interpolable {
	public static func interpolate(from fromValue: CGSize, to toValue: CGSize, at time: Time) -> CGSize {
		let width = CGFloat.interpolate(from: fromValue.width, to: toValue.width, at: time)
		let height = CGFloat.interpolate(from: fromValue.height, to: toValue.height, at: time)

		return CGSize(width: width, height: height)
	}
}

extension CGRect: Interpolable {
	public static func interpolate(from fromValue: CGRect, to toValue: CGRect, at time: Time) -> CGRect {
		let origin = CGPoint.interpolate(from: fromValue.origin, to: toValue.origin, at: time)
		let size = CGSize.interpolate(from: fromValue.size, to: toValue.size, at: time)

		return CGRect(x: origin.x, y: origin.y, width: size.width, height: size.height)
	}
}

extension CGAffineTransform {
	var translationX: CGFloat { return tx }
	var translationY: CGFloat { return ty }
	var scaleX: CGFloat { return sqrt(a * a + c * c) }
	var scaleY: CGFloat { return sqrt(b * b + d * d) }
	var angle: CGFloat { return atan2(b, d) }
}

extension CGAffineTransform: Interpolable {
	public static func interpolate(from fromValue: CGAffineTransform, to toValue: CGAffineTransform, at time: Time) -> CGAffineTransform {
		let tx = CGFloat.interpolate(from: fromValue.translationX, to: toValue.translationX, at: time)
		let ty = CGFloat.interpolate(from: fromValue.translationY, to: toValue.translationY, at: time)

		let sx = CGFloat.interpolate(from: fromValue.scaleX, to: toValue.scaleX, at: time)
		let sy = CGFloat.interpolate(from: fromValue.scaleY, to: toValue.scaleY, at: time)

		let angle = CGFloat.interpolate(from: fromValue.angle, to: toValue.angle, at: time)

		return CGAffineTransform.identity.translatedBy(x: tx, y: ty).scaledBy(x: sx, y: sy).rotated(by: angle)
	}
}

extension UIColor: Interpolable {
	public static func interpolate(from fromValue: UIColor, to toValue: UIColor, at time: Time) -> UIColor {
		var fromRed = CGFloat()
		var fromGreen = CGFloat()
		var fromBlue = CGFloat()
		var fromAlpha = CGFloat()

		var toRed = CGFloat()
		var toGreen = CGFloat()
		var toBlue = CGFloat()
		var toAlpha = CGFloat()

		fromValue.getRed(&fromRed, green: &fromGreen, blue: &fromBlue, alpha: &fromAlpha)
		toValue.getRed(&toRed, green: &toGreen, blue: &toBlue, alpha: &toAlpha)

		let red = CGFloat.interpolate(from: fromRed, to: toRed, at: time)
		let green = CGFloat.interpolate(from: fromGreen, to: toGreen, at: time)
		let blue = CGFloat.interpolate(from: fromBlue, to: toBlue, at: time)
		let alpha = CGFloat.interpolate(from: fromAlpha, to: toAlpha, at: time)

		return UIColor(red: red, green: green, blue: blue, alpha: alpha)
	}
}
