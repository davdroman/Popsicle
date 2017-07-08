//
//  Interpolable+UIKit.swift
//  Popsicle
//
//  Created by David Roman on 07/07/2017.
//

#if os(iOS) || os(watchOS) || os(tvOS)

import UIKit

extension UIColor {
	var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
		var (red, green, blue, alpha) = (CGFloat(), CGFloat(), CGFloat(), CGFloat())
		getRed(&red, green: &green, blue: &blue, alpha: &alpha)
		return (red, green, blue, alpha)
	}
}

extension UIColor: Interpolable {
	public static func interpolate(from fromValue: UIColor, to toValue: UIColor, at time: Time) -> UIColor {
		return UIColor(
			red: CGFloat.interpolate(from: fromValue.components.red, to: toValue.components.red, at: time),
			green: CGFloat.interpolate(from: fromValue.components.green, to: toValue.components.green, at: time),
			blue: CGFloat.interpolate(from: fromValue.components.blue, to: toValue.components.blue, at: time),
			alpha: CGFloat.interpolate(from: fromValue.components.alpha, to: toValue.components.alpha, at: time)
		)
	}
}

#endif
