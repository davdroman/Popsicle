//
//  PageScrollView.swift
//  Popsicle
//
//  Created by David Román Aguirre on 04/11/15.
//  Copyright © 2015 David Román Aguirre. All rights reserved.
//

import UIKit

class FirstPageView: UIView {
	@IBOutlet weak var label: UILabel?
	@IBOutlet weak var imageView: UIImageView?
}

class SecondPageView: UIView {
	@IBOutlet weak var label: UILabel?
}

class ThirdPageView: UIView {
	@IBOutlet weak var label1: UILabel?
	@IBOutlet weak var label2: UILabel?
}

class FourthPageView: UIView {
	@IBOutlet weak var label: UILabel?
}

class PageScrollView: DRPageScrollView {
	let firstPageView: FirstPageView
	let secondPageView: SecondPageView
	let thirdPageView: ThirdPageView
	let fourthPageView: FourthPageView

	override init(frame: CGRect) {
		let views = UIView.viewsByClassInNibNamed("PageViews")
		self.firstPageView = views["PopsicleDemo.FirstPageView"] as! FirstPageView
		self.secondPageView = views["PopsicleDemo.SecondPageView"] as! SecondPageView
		self.thirdPageView = views["PopsicleDemo.ThirdPageView"] as! ThirdPageView
		self.fourthPageView = views["PopsicleDemo.FourthPageView"] as! FourthPageView
		super.init(frame: frame)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func didMoveToSuperview() {
		if self.superview != nil {
			for pv in [firstPageView, secondPageView, thirdPageView, fourthPageView] {
				self.addPage { pageView in
					pageView?.addSubview(pv)
					pv.pinToSuperviewEdges()
				}
			}
		}
	}
}
