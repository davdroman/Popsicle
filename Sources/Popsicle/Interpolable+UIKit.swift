//
//  Interpolable+UIKit.swift
//  Popsicle
//
//  Created by David Roman on 07/07/2017.
//

#if canImport(UIKit)

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
		let fromComponents = fromValue.components
		let toComponents = toValue.components

		return self.init(
			red: CGFloat.interpolate(from: fromComponents.red, to: toComponents.red, at: time),
			green: CGFloat.interpolate(from: fromComponents.green, to: toComponents.green, at: time),
			blue: CGFloat.interpolate(from: fromComponents.blue, to: toComponents.blue, at: time),
			alpha: CGFloat.interpolate(from: fromComponents.alpha, to: toComponents.alpha, at: time)
		)
	}
}

#endif
