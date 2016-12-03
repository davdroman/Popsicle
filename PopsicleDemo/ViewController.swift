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

	let pageScrollView = PageScrollView(frame: .zero)
	var interpolations = InterpolationSet()

	override func viewDidLoad() {
		super.viewDidLoad()

		self.title = "Popsicle"
		self.view.backgroundColor = .white

		self.pageScrollView.delegate = self
		self.view.addSubview(self.pageScrollView)
		self.pageScrollView.pinToSuperviewEdges()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		interpolations.removeAll()

		let backgroundColorInterpolation = Interpolation(view, backgroundColor)
		backgroundColorInterpolation[1, 3] = UIColor.white
		backgroundColorInterpolation[1.7, 2] = UIColor(red: 254/255, green: 134/255, blue: 44/255, alpha: 1)
		interpolations.append(backgroundColorInterpolation)

		let barTintColorInterpolation = Interpolation(navigationController!.navigationBar, barTintColor)
		barTintColorInterpolation[1, 3] = UIColor.white
		barTintColorInterpolation[1.7, 2] = UIColor(red: 244/255, green: 219/255, blue: 165/255, alpha: 1)
		interpolations.append(barTintColorInterpolation)

		if let imageView = self.pageScrollView.firstPageView.imageView {
			let xInterpolation = Interpolation(imageView, centerXConstraint)
			xInterpolation[f: 0] = (0, easeInQuad)
			xInterpolation[1] = -self.pageScrollView.frame.width
			xInterpolation[2] = -self.pageScrollView.frame.width*2
			xInterpolation[3] = -self.pageScrollView.frame.width*3
			interpolations.append(xInterpolation)

			let yInterpolation = Interpolation(imageView, centerYConstraint)
			yInterpolation[0] = 0
			yInterpolation[1, 2] = -self.pageScrollView.frame.height/2+80
			yInterpolation[3] = 0
			interpolations.append(yInterpolation)

			let alphaInterpolation = Interpolation(imageView, alpha)
			alphaInterpolation[1] = 1
			alphaInterpolation[2] = 0
			alphaInterpolation[3] = 0.25
			interpolations.append(alphaInterpolation)

			let transformInterpolation = Interpolation(imageView, transform)
			transformInterpolation[0, 1, 2] = .identity
			transformInterpolation[0.25] = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
			transformInterpolation[3] = CGAffineTransform.identity.scaledBy(x: 1.4, y: 1.4).rotated(by: .pi)
			interpolations.append(transformInterpolation)
		}

		if let label1 = self.pageScrollView.firstPageView.label {
			let alphaInterpolation = Interpolation(label1, alpha)
			alphaInterpolation[0] = 1
			alphaInterpolation[0.4] = 0
			interpolations.append(alphaInterpolation)
		}

		if let label2 = self.pageScrollView.secondPageView.label {
			let scaleInterpolation = Interpolation(label2, transform)
			scaleInterpolation[0] = CGAffineTransform.identity.scaledBy(x: 0.6, y: 0.6)
			scaleInterpolation[1] = .identity
			interpolations.append(scaleInterpolation)

			let alphaInterpolation = Interpolation(label2, alpha)
			alphaInterpolation[1] = 1
			alphaInterpolation[1.7] = 0
			interpolations.append(alphaInterpolation)
		}

		if let label3 = self.pageScrollView.thirdPageView.label1, let label4 = self.pageScrollView.thirdPageView.label2 {
			let translateInterpolation1 = Interpolation(label3, transform)
			translateInterpolation1[1] = CGAffineTransform.identity.translatedBy(x: 100, y: 0)
			translateInterpolation1[2] = .identity
			translateInterpolation1[3] = CGAffineTransform.identity.translatedBy(x: -100, y: 0)
			interpolations.append(translateInterpolation1)

			let translateInterpolation2 = Interpolation(label4, transform)
			translateInterpolation2[1] = CGAffineTransform.identity.translatedBy(x: 300, y: 0)
			translateInterpolation2[2] = .identity
			translateInterpolation2[3] = CGAffineTransform.identity.translatedBy(x: -300, y: 0)
			interpolations.append(translateInterpolation2)
		}
	}

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		interpolations.time = Double(scrollView.contentOffset.x/scrollView.frame.size.width)
	}
}
