//
//  MainViewController.h
//  DRDynamicSlideShow
//
//  Created by David Román Aguirre on 17/09/13.
//  Copyright (c) 2013 David Román Aguirre. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DRDynamicSlideShow.h"

@interface MainViewController : UIViewController

@property (strong, nonatomic) UINavigationBar * navigationBar;
@property (strong, nonatomic) DRDynamicSlideShow * slideShow;

@end