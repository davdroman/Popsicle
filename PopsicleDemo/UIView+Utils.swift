//
//  UIView+Utils.swift
//  Popsicle
//
//  Created by David Román Aguirre on 04/11/15.
//  Copyright © 2015 David Román Aguirre. All rights reserved.
//

extension UIView {
	static func viewsByClassInNibNamed(_ name: String) -> [String: UIView] {
		var viewsByClass = [String: UIView]()

		let nibViews = Bundle.main().loadNibNamed(name, owner: self, options: nil)

		for view in nibViews {
			if let v = view as? UIView {
				viewsByClass[NSStringFromClass(v.dynamicType)] = v
			}
		}

		return viewsByClass
	}

	func pinToSuperviewEdges() {
		self.translatesAutoresizingMaskIntoConstraints = false

		for attribute in [.top, .left, .bottom, .right] as [NSLayoutAttribute] {
			let constraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: self.superview, attribute: attribute, multiplier: 1, constant: 0)

			self.superview?.addConstraint(constraint)
		}
	}
}
