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
#import "UIView+Utils.h"

@implementation FirstPageView @end
@implementation SecondPageView @end
@implementation ThirdPageView @end
@implementation FourthPageView @end

@interface MainViewController ()

@property (nonatomic, strong) PSInterpolator *interpolator;
@property (nonatomic, strong) DRPageScrollView *pageScrollView;

@end

@implementation MainViewController

- (id)init {
	if (self = [super init]) {
		self.interpolator = [PSInterpolator new];
		self.pageScrollView = [DRPageScrollView new];
		
		NSDictionary *nibViews = [UIView nibViewsByClassWithNibName:@"PageViews"];
		self.firstPageView = nibViews[@"FirstPageView"];
		self.secondPageView = nibViews[@"SecondPageView"];
		self.thirdPageView = nibViews[@"ThirdPageView"];
		self.fourthPageView = nibViews[@"FourthPageView"];
	}
	
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Popsicle";
	self.view.backgroundColor = [UIColor whiteColor];
	
	self.pageScrollView.delegate = self;
	[self.view addSubview:self.pageScrollView];
	[self.pageScrollView pinToSuperviewEdges];
	[self addPageViews:@[self.firstPageView, self.secondPageView, self.thirdPageView, self.fourthPageView]];
}

- (void)addPageViews:(NSArray *)pageViews {
	for (UIView *pv in pageViews) {
		[self.pageScrollView addPageWithHandler:^(UIView *pageView) {
			[pageView addSubview:pv];
			[pv pinToSuperviewEdges];
		}];
	}
}

- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	
	[self.interpolator removeAllInterpolations];
	
	// Logo image view interpolations
	
	[self.interpolator addInterpolations:@[PS(PSFloatInterpolation, 0, 1, 0, -self.pageScrollView.width),
										   PS(PSFloatInterpolation, 1, 2, -self.pageScrollView.width, -self.pageScrollView.width*2),
										   PS(PSFloatInterpolation, 2, 3, -self.pageScrollView.width*2, -self.pageScrollView.width*3)]
							  forObjects:self.firstPageView.imageViewCenterXConstraint
								 keyPath:@"constant"];
	
	[self.interpolator addInterpolations:@[PS(PSFloatInterpolation, 0, 1, 0, -self.pageScrollView.height/2+80),
										   PS(PSFloatInterpolation, 2, 3, -self.pageScrollView.height/2+80, 0)]
							  forObjects:self.firstPageView.imageViewCenterYConstraint
								 keyPath:@"constant"];
	
	[self.interpolator addInterpolations:PS(PSFloatInterpolation, 2, 3, 1, 0.1) forObjects:self.firstPageView.imageView keyPath:@"alpha"];
	
	[self.interpolator addInterpolations:PS(PSAffineTransformInterpolation, 2, 3, CGAffineTransformIdentity, CGAffineTransformCreate(0, 0, 1.4, 1.4, 60)) forObjects:self.firstPageView.imageView keyPath:@"transform"];
	
	// First label interpolations
	
	[self.interpolator addInterpolations:PS(PSFloatInterpolation, 0, 0.4, 1, 0) forObjects:self.firstPageView.label keyPath:@"alpha"];
	
	// Second label interpolations
	
	[self.interpolator addInterpolations:PS(PSFloatInterpolation, 1, 1.4, 1, 0) forObjects:self.secondPageView.label keyPath:@"alpha"];
	
	// Third label interpolations
	
	[self.interpolator addInterpolations:PS(PSFloatInterpolation, 2, 2.4, 1, 0) forObjects:self.thirdPageView.label keyPath:@"alpha"];
	[self.interpolator addInterpolations:@[PS(PSAffineTransformInterpolation, 1, 2, CGAffineTransformCreate(0, 0, 0.5, 0.5, -70), CGAffineTransformIdentity),
										   PS(PSAffineTransformInterpolation, 2, 3, CGAffineTransformIdentity, CGAffineTransformCreate(0, 0, 0.5, 0.5, 0))]
							  forObjects:self.thirdPageView.label
								 keyPath:@"transform"];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	self.interpolator.time = scrollView.contentOffset.x/scrollView.frame.size.width; // contentOffset.x/frame.size.width = current page index.
}

@end
