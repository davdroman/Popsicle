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
		let views = UIView.viewsByClassInNib(named: "PageViews")
		firstPageView = views["PopsicleDemo.FirstPageView"] as! FirstPageView
		secondPageView = views["PopsicleDemo.SecondPageView"] as! SecondPageView
		thirdPageView = views["PopsicleDemo.ThirdPageView"] as! ThirdPageView
		fourthPageView = views["PopsicleDemo.FourthPageView"] as! FourthPageView
		super.init(frame: frame)
	}

	override func didMoveToSuperview() {
		if superview != nil {
			[firstPageView, secondPageView, thirdPageView, fourthPageView].forEach { pv in
				addPage { pageView in
					pageView?.addSubview(pv)
					pv.pinToSuperviewEdges()
				}
			}
		}
	}

	@available(*, unavailable) required init?(coder aDecoder: NSCoder) { fatalError() }
}
