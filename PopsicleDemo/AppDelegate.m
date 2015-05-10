//
//  AppDelegate.m
//  PopsicleDemo
//
//  Created by David Román Aguirre on 31/3/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	self.window.backgroundColor = [UIColor whiteColor];
	self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[MainViewController new]];
	[self.window makeKeyAndVisible];
	
	return YES;
}

@end
