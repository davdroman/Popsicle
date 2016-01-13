//
//  UIView+Utils.swift
//  Popsicle
//
//  Created by David Román Aguirre on 04/11/15.
//  Copyright © 2015 David Román Aguirre. All rights reserved.
//

extension UIView {
	static func viewsByClassInNibNamed(name: String) -> [String: UIView] {
		var viewsByClass = [String: UIView]()

		let nibViews = NSBundle.mainBundle().loadNibNamed(name, owner: self, options: nil)

		for view in nibViews {
			if let v = view as? UIView {
				viewsByClass[NSStringFromClass(v.dynamicType)] = v
			}
		}

		return viewsByClass
	}

	func pinToSuperviewEdges() {
		self.translatesAutoresizingMaskIntoConstraints = false

		for attribute in [.Top, .Left, .Bottom, .Right] as [NSLayoutAttribute] {
			let constraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .Equal, toItem: self.superview, attribute: attribute, multiplier: 1, constant: 0)

			self.superview?.addConstraint(constraint)
		}
	}
}