//
//  MainViewController.m
//  DRDynamicSlideShow
//
//  Created by David Román Aguirre on 17/09/13.
//  Copyright (c) 2013 David Román Aguirre. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

- (id)init {
    if (self = [super init]) {
        self.navigationBar = [UINavigationBar new];
        self.slideShow = [DRDynamicSlideShow new];
        self.viewsForPages = [NSArray new];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    #pragma mark View
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    #pragma mark Navigation Bar
    
    [self.navigationBar setFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    
    UINavigationItem * mainItem = [UINavigationItem new];
    [mainItem setTitle:@"DRDynamicSlideShow"];
    
    [self.navigationBar setItems:@[mainItem]];
    
    [self.view addSubview:self.navigationBar];
    
    #pragma mark DRDynamicSlideShow
    
    [self.slideShow setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.slideShow setContentInset:UIEdgeInsetsMake(self.navigationBar.frame.size.height/2, 0, 0, 0)];
    [self.slideShow setAlpha:0];
    
    [self.slideShow setDidReachPageBlock:^(NSInteger reachedPage) {
        NSLog(@"Current Page: %i", reachedPage);
    }];
    
    [self.view insertSubview:self.slideShow belowSubview:self.navigationBar];
    
    #pragma mark DRDynamicSlideShow Subviews
    
    self.viewsForPages = [[NSBundle mainBundle] loadNibNamed:@"DRDynamicSlideShowSubviews" owner:self options:nil];
    
    [self setupSlideShowSubviewsAndAnimations];
}

- (void)setupSlideShowSubviewsAndAnimations {
    for (UIView * pageView in self.viewsForPages) {
        CGFloat verticalOrigin = self.slideShow.frame.size.height/2-pageView.frame.size.height/2;
        
        for (UIView * subview in pageView.subviews) {
            [subview setFrame:CGRectMake(subview.frame.origin.x, verticalOrigin+subview.frame.origin.y, subview.frame.size.width, subview.frame.size.height)];
            [self.slideShow addSubview:subview onPage:pageView.tag];
        }
    }
    
    #pragma mark Page 0
    
    UILabel * helloLabel = (UILabel *)[self.slideShow viewWithTag:1];

    [self.slideShow addAnimation:[DRDynamicSlideShowAnimation animationForSubview:helloLabel page:0 keyPath:@"center" toValue:[NSValue valueWithCGPoint:CGPointMake(helloLabel.center.x+self.slideShow.frame.size.width, helloLabel.center.y-self.slideShow.frame.size.height)] delay:0]];
    
    UITextView * descriptionTextView = (UITextView *)[self.slideShow viewWithTag:2];
    
    [self.slideShow addAnimation:[DRDynamicSlideShowAnimation animationForSubview:descriptionTextView page:0 keyPath:@"alpha" toValue:@0 delay:0]];
    
    [self.slideShow addAnimation:[DRDynamicSlideShowAnimation animationForSubview:descriptionTextView page:0 keyPath:@"center" toValue:[NSValue valueWithCGPoint:CGPointMake(descriptionTextView.center.x+self.slideShow.frame.size.width, descriptionTextView.center.y+self.slideShow.frame.size.height*2)] delay:0]];
    
    #pragma mark Page 1
    
    UIImageView * magicStickImageView = (UIImageView *)[self.slideShow viewWithTag:3];
    
    [self.slideShow addAnimation:[DRDynamicSlideShowAnimation animationForSubview:magicStickImageView page:0 keyPath:@"alpha" fromValue:@0 toValue:@1 delay:0.75]];
    
    UITextView * magicStickDescriptionTextView = (UITextView *)[self.slideShow viewWithTag:4];
    
    [self.slideShow addAnimation:[DRDynamicSlideShowAnimation animationForSubview:magicStickDescriptionTextView page:0 keyPath:@"transform" fromValue:[NSValue valueWithCGAffineTransform:CGAffineTransformMakeRotation(-0.9)] toValue:[NSValue valueWithCGAffineTransform:CGAffineTransformMakeRotation(0)] delay:0]];
    
    #pragma mark Page 2
    
    UILabel * codeBracketsLabel = (UILabel *)[self.slideShow viewWithTag:5];
    
    [self.slideShow addAnimation:[DRDynamicSlideShowAnimation animationForSubview:codeBracketsLabel page:1 keyPath:@"alpha" fromValue:@0 toValue:@1 delay:0.75]];
    
    UITextView * codingDescriptionTextView = (UITextView *)[self.slideShow viewWithTag:6];
    [codingDescriptionTextView setCenter:CGPointMake(codingDescriptionTextView.center.x-self.slideShow.frame.size.width, codingDescriptionTextView.center.y+self.slideShow.frame.size.height)];
    
    [self.slideShow addAnimation:[DRDynamicSlideShowAnimation animationForSubview:codingDescriptionTextView page:1 keyPath:@"center" toValue:[NSValue valueWithCGPoint:CGPointMake(codingDescriptionTextView.center.x+self.slideShow.frame.size.width, codingDescriptionTextView.center.y-self.slideShow.frame.size.height)] delay:0]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.6 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.slideShow setAlpha:1];
    } completion:nil];
}

@end