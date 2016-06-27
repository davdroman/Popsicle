//
//  ViewController.swift
//  PopsicleDemo
//
//  Created by David Román Aguirre on 04/11/15.
//  Copyright © 2015 David Román Aguirre. All rights reserved.
//

import UIKit
import Popsicle

class ViewController: UIViewController, UIScrollViewDelegate {

	let pageScrollView: PageScrollView
	let interpolator: Interpolator

	init() {
		self.pageScrollView = PageScrollView(frame: .zero)
		self.interpolator = Interpolator()
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		self.title = "Popsicle"
		self.view.backgroundColor = UIColor.white()

		self.pageScrollView.delegate = self
		self.view.addSubview(self.pageScrollView)
		self.pageScrollView.pinToSuperviewEdges()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		self.interpolator.removeAllInterpolations()

		let backgroundColorInterpolation = Interpolation(self.view, backgroundColor)
		backgroundColorInterpolation[1, 3] = UIColor.white()
		backgroundColorInterpolation[1.7, 2] = UIColor(red: 254/255, green: 134/255, blue: 44/255, alpha: 1)
		self.interpolator.addInterpolation(backgroundColorInterpolation)

		let barTintColorInterpolation = Interpolation(self.navigationController!.navigationBar, barTintColor)
		barTintColorInterpolation[1, 3] = UIColor.white()
		barTintColorInterpolation[1.7, 2] = UIColor(red: 244/255, green: 219/255, blue: 165/255, alpha: 1)
		self.interpolator.addInterpolation(barTintColorInterpolation)

		if let imageView = self.pageScrollView.firstPageView.imageView {
			let xInterpolation = Interpolation(imageView, centerXConstraint)
			xInterpolation[0] = 0
			xInterpolation.setEasingFunction(EasingFunctionEaseInQuad, forTime: 0)
			xInterpolation[1] = -self.pageScrollView.frame.width
			xInterpolation[2] = -self.pageScrollView.frame.width*2
			xInterpolation[3] = -self.pageScrollView.frame.width*3
			self.interpolator.addInterpolation(xInterpolation)

			let yInterpolation = Interpolation(imageView, centerYConstraint)
			yInterpolation[0] = 0
			yInterpolation[1, 2] = -self.pageScrollView.frame.height/2+80
			yInterpolation[3] = 0
			self.interpolator.addInterpolation(yInterpolation)

			let alphaInterpolation = Interpolation(imageView, alpha)
			alphaInterpolation[1] = 1
			alphaInterpolation[2] = 0
			alphaInterpolation[3] = 0.25
			self.interpolator.addInterpolation(alphaInterpolation)

			let transformInterpolation = Interpolation(imageView, transform)
			transformInterpolation[0, 1, 2] = CGAffineTransform.identity
			transformInterpolation[0.25] = CGAffineTransformMake(0, 0, 1.1, 1.1, 0)
			transformInterpolation[3] = CGAffineTransformMake(0, 0, 1.4, 1.4, 60)
			self.interpolator.addInterpolation(transformInterpolation)
		}

		if let label1 = self.pageScrollView.firstPageView.label {
			let alphaInterpolation = Interpolation(label1, alpha)
			alphaInterpolation[0] = 1
			alphaInterpolation[0.4] = 0
			self.interpolator.addInterpolation(alphaInterpolation)
		}

		if let label2 = self.pageScrollView.secondPageView.label {
			let scaleInterpolation = Interpolation(label2, transform)
			scaleInterpolation[0] = CGAffineTransformMake(0, 0, 0.6, 0.6, 0)
			scaleInterpolation[1] = CGAffineTransformMake(0, 0, 1, 1, 0)
			self.interpolator.addInterpolation(scaleInterpolation)

			let alphaInterpolation = Interpolation(label2, alpha)
			alphaInterpolation[1] = 1
			alphaInterpolation[1.7] = 0
			self.interpolator.addInterpolation(alphaInterpolation)
		}

		if let label3 = self.pageScrollView.thirdPageView.label1, let label4 = self.pageScrollView.thirdPageView.label2 {
			let translateInterpolation1 = Interpolation(label3, transform)
			translateInterpolation1[1] = CGAffineTransformMake(100, 0, 1, 1, 0)
			translateInterpolation1[2] = CGAffineTransform.identity
			translateInterpolation1[3] = CGAffineTransformMake(-100, 0, 1, 1, 0)
			self.interpolator.addInterpolation(translateInterpolation1)

			let translateInterpolation2 = Interpolation(label4, transform)
			translateInterpolation2[1] = CGAffineTransformMake(300, 0, 1, 1, 0)
			translateInterpolation2[2] = CGAffineTransform.identity
			translateInterpolation2[3] = CGAffineTransformMake(-300, 0, 1, 1, 0)
			self.interpolator.addInterpolation(translateInterpolation2)
		}
	}

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		self.interpolator.time = Double(scrollView.contentOffset.x/scrollView.frame.size.width)
	}
}
