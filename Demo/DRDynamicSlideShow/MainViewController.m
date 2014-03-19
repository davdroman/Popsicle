//
//  MainViewController.m
//  DRDynamicSlideShow
//
//  Created by David Román Aguirre on 17/09/13.
//  Copyright (c) 2013 David Román Aguirre. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set the slide show view's alpha so that we can fade it in later
    [self.slideShow setAlpha:0];
    
    // Set the content size
    [self.slideShow setContentSize:CGSizeMake(960, self.slideShow.frame.size.height)];
    
    // Set the "did reach page block"
    [self.slideShow setDidReachPageBlock:^(NSInteger reachedPage) {
        NSLog(@"Current Page: %li", reachedPage);
        self.pageControl.currentPage = reachedPage;
    }];
    
    // Add the animations
    [self setupSlideShowSubviewsAndAnimations];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.6 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.slideShow setAlpha:1];
    } completion:nil];
}

- (void)setupSlideShowSubviewsAndAnimations {
    #pragma mark Page 0
    
    [self.slideShow addAnimation:[DRDynamicSlideShowAnimation animationForSubview:self.helloLabel page:0 keyPath:@"center" toValue:[NSValue valueWithCGPoint:CGPointMake(self.helloLabel.center.x+self.slideShow.frame.size.width, self.helloLabel.center.y-self.slideShow.frame.size.height)] delay:0]];
    
    [self.slideShow addAnimation:[DRDynamicSlideShowAnimation animationForSubview:self.welcomeLabel page:0 keyPath:@"alpha" toValue:@0 delay:0]];
    
    [self.slideShow addAnimation:[DRDynamicSlideShowAnimation animationForSubview:self.welcomeLabel page:0 keyPath:@"center" toValue:[NSValue valueWithCGPoint:CGPointMake(self.welcomeLabel.center.x+self.slideShow.frame.size.width, self.welcomeLabel.center.y+self.slideShow.frame.size.height*2)] delay:0]];
    
    #pragma mark Page 1
    
    [self.slideShow addAnimation:[DRDynamicSlideShowAnimation animationForSubview:self.magicStickImageView page:0 keyPath:@"alpha" fromValue:@0 toValue:@1 delay:0.75]];
    
    [self.slideShow addAnimation:[DRDynamicSlideShowAnimation animationForSubview:self.magicStickDescriptionTextView page:0 keyPath:@"transform" fromValue:[NSValue valueWithCGAffineTransform:CGAffineTransformMakeRotation(-0.9)] toValue:[NSValue valueWithCGAffineTransform:CGAffineTransformMakeRotation(0)] delay:0]];
    
    #pragma mark Page 2
    
    [self.slideShow addAnimation:[DRDynamicSlideShowAnimation animationForSubview:self.codeBracketsLabel page:1 keyPath:@"alpha" fromValue:@0 toValue:@1 delay:0.75]];
    
    [self.codingDescriptionTextView setCenter:CGPointMake(self.codingDescriptionTextView.center.x-self.slideShow.frame.size.width, self.codingDescriptionTextView.center.y+self.slideShow.frame.size.height)];
    
    [self.slideShow addAnimation:[DRDynamicSlideShowAnimation animationForSubview:self.codingDescriptionTextView page:1 keyPath:@"center" toValue:[NSValue valueWithCGPoint:CGPointMake(self.codingDescriptionTextView.center.x+self.slideShow.frame.size.width, self.codingDescriptionTextView.center.y-self.slideShow.frame.size.height)] delay:0]];
}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    return UIBarPositionTopAttached;
}

@end