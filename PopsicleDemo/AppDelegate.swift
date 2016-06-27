//
//  AppDelegate.swift
//  PopsicleDemo
//
//  Created by David Román Aguirre on 04/11/15.
//  Copyright © 2015 David Román Aguirre. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

		self.window = UIWindow(frame: UIScreen.main().bounds)
		self.window?.rootViewController = UINavigationController(rootViewController: ViewController())
		self.window?.makeKeyAndVisible()

		return true
	}
}

