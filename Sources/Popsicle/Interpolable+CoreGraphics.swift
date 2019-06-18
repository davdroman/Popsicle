//
//  Interpolable+UIKit.swift
//  Popsicle
//
//  Created by David Román Aguirre on 30/06/16.
//

#if canImport(CoreGraphics)

import CoreGraphics

extension CGFloat: Interpolable {
	public static func interpolate(from fromValue: CGFloat, to toValue: CGFloat, at time: Time) -> CGFloat {
		fromValue + (toValue-fromValue) * CGFloat(time)
	}
}

extension CGPoint: Interpolable {
	public static func interpolate(from fromValue: CGPoint, to toValue: CGPoint, at time: Time) -> CGPoint {
		CGPoint(
			x: CGFloat.interpolate(from: fromValue.x, to: toValue.x, at: time),
			y: CGFloat.interpolate(from: fromValue.y, to: toValue.y, at: time)
		)
	}
}

extension CGSize: Interpolable {
	public static func interpolate(from fromValue: CGSize, to toValue: CGSize, at time: Time) -> CGSize {
		CGSize(
			width: CGFloat.interpolate(from: fromValue.width, to: toValue.width, at: time),
			height: CGFloat.interpolate(from: fromValue.height, to: toValue.height, at: time)
		)
	}
}

extension CGRect: Interpolable {
	public static func interpolate(from fromValue: CGRect, to toValue: CGRect, at time: Time) -> CGRect {
		CGRect(
			origin: CGPoint.interpolate(from: fromValue.origin, to: toValue.origin, at: time),
			size: CGSize.interpolate(from: fromValue.size, to: toValue.size, at: time)
		)
	}
}

extension CGAffineTransform: Interpolable {
	public static func interpolate(from fromValue: CGAffineTransform, to toValue: CGAffineTransform, at time: Time) -> CGAffineTransform {
		CGAffineTransform.identity
			.translatedBy(
				x: CGFloat.interpolate(from: fromValue.translationX, to: toValue.translationX, at: time),
				y: CGFloat.interpolate(from: fromValue.translationY, to: toValue.translationY, at: time)
			)
			.scaledBy(
				x: CGFloat.interpolate(from: fromValue.scaleX, to: toValue.scaleX, at: time),
				y: CGFloat.interpolate(from: fromValue.scaleY, to: toValue.scaleY, at: time)
			)
			.rotated(
				by: CGFloat.interpolate(from: fromValue.angle, to: toValue.angle, at: time)
			)
	}
}

extension CGAffineTransform {
	var translationX: CGFloat { tx }
	var translationY: CGFloat { ty }
	var scaleX: CGFloat { sqrt(a * a + c * c) }
	var scaleY: CGFloat { sqrt(b * b + d * d) }
	var angle: CGFloat { atan2(b, d) }
}

#endif
