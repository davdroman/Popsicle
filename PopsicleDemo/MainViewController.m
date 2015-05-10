//
//  MainViewController.m
//  Popsicle
//
//  Created by David Román Aguirre on 1/4/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "MainViewController.h"

#import "Popsicle.h"
#import "DRPageScrollView.h"
#import "UIView+Utils.h" // Extremely useful to simplify code.

@interface MainViewController ()

@property (nonatomic, strong) PSInterpolator *interpolator;
@property (nonatomic, strong) DRPageScrollView *pageScrollView;

@end

@implementation MainViewController

- (id)init {
	if (self = [super init]) {
		self.interpolator = [PSInterpolator new];
		self.pageScrollView = [DRPageScrollView new];
	}
	
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Popsicle";
	self.view.backgroundColor = [UIColor whiteColor];
	
	self.pageScrollView.delegate = self;
	self.pageScrollView.frame = self.view.frame;
	self.pageScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[self.view addSubview:self.pageScrollView];
	
	// Page 1
	
	UIImageView *logoImageView = [UIImageView new];
	logoImageView.image = [UIImage imageNamed:@"logo"];
	logoImageView.size = CGSizeMake(logoImageView.image.size.width/2, logoImageView.image.size.height/2);
	logoImageView.center = self.pageScrollView.center;
	
	CGFloat logoImageViewCenterX1 = logoImageView.centerX+self.pageScrollView.width;
	CGFloat logoImageViewCenterY1 = self.pageScrollView.height-80;
	[self.interpolator addInterpolations:PS(PSPointInterpolation, 0, 1, logoImageView.center, CGPointMake(logoImageViewCenterX1, logoImageViewCenterY1)) forObjects:logoImageView keyPath:@"center"];
	
	UILabel *firstLabel = [self labelWithText:@"Hello world! This is a Popsicle demo app."];
	firstLabel.y = self.pageScrollView.height-firstLabel.height-30;
	
	[self.interpolator addInterpolations:PS(PSFloatInterpolation, 0, 0.4, 1, 0) forObjects:firstLabel keyPath:@"alpha"];
	
	[self.pageScrollView addPageWithHandler:^(UIView *pageView) {
		[pageView addSubview:logoImageView];
		[pageView addSubview:firstLabel];
	}];
	
	// Page 2
	
	CGFloat logoImageViewCenterX2 = logoImageView.centerX+self.pageScrollView.width*2;
	[self.interpolator addInterpolations:PS(PSFloatInterpolation, 1, 2, logoImageViewCenterX1, logoImageViewCenterX2) forObjects:logoImageView keyPath:@"centerX"];
	
	UILabel *secondLabel = [self labelWithText:@"Woah! That was smooth!\n\nAs you can see, Popsicle provides a great way to create transitions through value interpolations."];
	secondLabel.centerY = (self.pageScrollView.height-80-logoImageView.height/2)/2+self.navigationController.navigationBar.height/2;
	
	[self.interpolator addInterpolations:PS(PSFloatInterpolation, 1, 1.4, 1, 0) forObjects:secondLabel keyPath:@"alpha"];
	
	[self.pageScrollView addPageWithHandler:^(UIView *pageView) {
		[pageView addSubview:secondLabel];
	}];
	
	// Page 3
	
	CGFloat logoImageViewCenterX3 = logoImageView.centerX+self.pageScrollView.width*3;
	[self.interpolator addInterpolations:PS(PSFloatInterpolation, 2, 3, logoImageViewCenterX2, logoImageViewCenterX3) forObjects:logoImageView keyPath:@"centerX"];
	[self.interpolator addInterpolations:PS(PSFloatInterpolation, 2, 3, logoImageViewCenterY1, self.pageScrollView.centerY+self.navigationController.navigationBar.height/2) forObjects:logoImageView keyPath:@"centerY"];
	[self.interpolator addInterpolations:PS(PSFloatInterpolation, 2, 3, 1, 0.1) forObjects:logoImageView keyPath:@"alpha"];
	[self.interpolator addInterpolations:PS(PSAffineTransformInterpolation, 2, 3, logoImageView.transform, CGAffineTransformCreate(0, 0, 1.4, 1.4, 60)) forObjects:logoImageView keyPath:@"transform"];
	
	UILabel *thirdLabel = [self labelWithText:@"Such values are not bound to UIKit, although Popsicle offers some built-in interpolations for values such as int, float, CGRect, CGAffineTransform and UIColor."];
	thirdLabel.centerY = (self.pageScrollView.height-80-logoImageView.height/2)/2+self.navigationController.navigationBar.height/2;
	
	CGAffineTransform thirdLabelTransform1 = CGAffineTransformCreate(0, 0, 0.5, 0.5, -70);
	CGAffineTransform thirdLabelTransform2 = CGAffineTransformCreate(0, 0, 0.5, 0.5, 0);
	[self.interpolator addInterpolations:@[PS(PSAffineTransformInterpolation, 1, 2, thirdLabelTransform1, CGAffineTransformIdentity),
										   PS(PSAffineTransformInterpolation, 2, 3, CGAffineTransformIdentity, thirdLabelTransform2)]
							  forObjects:thirdLabel
								 keyPath:@"transform"];
	[self.interpolator addInterpolations:PS(PSFloatInterpolation, 2, 2.4, 1, 0) forObjects:thirdLabel keyPath:@"alpha"];
	
	[self.pageScrollView addPageWithHandler:^(UIView *pageView) {
		[pageView addSubview:thirdLabel];
	}];
	
	// Page 4
	
	UILabel *fourthLabel = [self labelWithText:@"There's a lot more coming for Popsicle.\n\nFor requests, comments or concerns, just open a GitHub issue or ping me @Dromaguirre and I'll reply as soon as I can."];
	fourthLabel.center = self.pageScrollView.center;
	
	[self.pageScrollView addPageWithHandler:^(UIView *pageView) {
		[pageView addSubview:fourthLabel];
	}];
}

- (UILabel *)labelWithText:(NSString *)text {
	UILabel *label = [UILabel new];
	
	label.numberOfLines = 100;
	label.textAlignment = NSTextAlignmentCenter;
	label.text = text;
	label.width = self.pageScrollView.width-60;
	[label sizeToFit]; // Adjusts height for current width
	label.frame = CGRectMake(roundf(label.x), roundf(label.y), roundf(label.width), roundf(label.height)); // sizeToFit is an d*** to frame.
	label.centerX = self.pageScrollView.centerX;
	
	return label;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	self.interpolator.time = scrollView.contentOffset.x/scrollView.frame.size.width; // contentOffset.x/frame.size.width = current page index.
}

@end
