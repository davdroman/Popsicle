//
//  MainViewController.m
//  DRDynamicSlideShow
//
//  Created by David Román Aguirre on 17/09/13.
//  Copyright (c) 2013 David Román Aguirre. All rights reserved.
//

#import "MainViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "UIColor+RGBA.h"

#define LOGS_ENABLED YES

@implementation MainViewController

- (id)init {
    if (self = [super init]) {
        self.navigationBar = [UINavigationBar new];
        self.slideShow = [DRDynamicSlideShow new];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    #pragma mark View
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view.layer setCornerRadius:4.5];
    [self.view.layer setMasksToBounds:YES];
    
    #pragma mark Navigation Bar
    
    [self.navigationBar setFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [self.navigationBar setBarTintColor:[UIColor colorWithAbsoluteRed:63 green:138 blue:229 alpha:1]];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    UINavigationItem * mainItem = [UINavigationItem new];
    [mainItem setTitle:@"DRDynamicSlideShow"];
    
    [self.navigationBar setItems:@[mainItem]];
    
    [self.view addSubview:self.navigationBar];
    
    #pragma mark DRDynamicSlideShow
    
    [self.slideShow setFrame:CGRectMake(0, self.navigationBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-self.navigationBar.frame.size.height)];
    [self.slideShow setAlpha:0];
    
    [self.slideShow setDidReachPageBlock:^(NSInteger reachedPage) {
        if (LOGS_ENABLED) NSLog(@"Current Page: %i", reachedPage);
    }];
    
    [self.view insertSubview:self.slideShow belowSubview:self.navigationBar];
    
    [self addSlideShowSubviewsAndApplyEffects];
}

- (void)addSlideShowSubviewsAndApplyEffects {
    #pragma mark Page 0
    
    UITextView * descriptionTextView = [self standartTextView];
    [descriptionTextView setText:@"DRDynamicSlideShow is the best way to implement dynamic slide shows.\n\nIn fact, I'm a dynamic slide show!\n\nSlide your finger horizontally and you'll see how awesome I am."];
    [descriptionTextView sizeToFit];
    [descriptionTextView setCenter:CGPointMake(self.slideShow.center.x, self.slideShow.frame.size.height/2)];
    
    [self.slideShow addSubview:descriptionTextView onPage:0];
    
    DRDynamicSlideShowEffect * descriptionTextViewDynamicEffect = [[DRDynamicSlideShowEffect alloc] initWithSubview:descriptionTextView page:0 fromFrame:descriptionTextView.frame toFrame:CGRectMake(descriptionTextView.frame.origin.x+self.slideShow.frame.size.width, self.slideShow.frame.size.height, descriptionTextView.frame.size.width, descriptionTextView.frame.size.height) fromAlpha:1 toAlpha:0];
    
    [self.slideShow addDynamicEffect:descriptionTextViewDynamicEffect];
    
    UILabel * helloLabel = [self standartTitleLabel];
    [helloLabel setText:@"Hey there!"];
    [helloLabel sizeToFit];
    [helloLabel setCenter:CGPointMake(self.slideShow.center.x, descriptionTextView.frame.origin.y/2)];
    
    [self.slideShow addSubview:helloLabel onPage:0];
    
    #pragma mark Page 1
    
    UITextView * secondDescriptionTextView = [self standartTextView];
    [secondDescriptionTextView setText:@"So right now you're like this guy, right?"];
    [secondDescriptionTextView sizeToFit];
    [secondDescriptionTextView setCenter:CGPointMake(self.slideShow.frame.size.width/2, self.slideShow.frame.size.height/2-40)];
    
    [self.slideShow addSubview:secondDescriptionTextView onPage:1];
    
    DRDynamicSlideShowEffect * secondDescriptionTextViewDynamicEffect = [[DRDynamicSlideShowEffect alloc] initWithSubview:secondDescriptionTextView page:0 fromFrame:secondDescriptionTextView.frame toFrame:secondDescriptionTextView.frame fromAlpha:0 toAlpha:1];
    
    [self.slideShow addDynamicEffect:secondDescriptionTextViewDynamicEffect];
    
    DRDynamicSlideShowEffect * secondDescriptionTextViewDynamicEffectFadeOut = [[DRDynamicSlideShowEffect alloc] initWithSubview:secondDescriptionTextView page:1 fromFrame:secondDescriptionTextView.frame toFrame:secondDescriptionTextView.frame fromAlpha:1 toAlpha:0];
    
    [self.slideShow addDynamicEffect:secondDescriptionTextViewDynamicEffectFadeOut];
    
    UIImageView * suspiciousImageView = [self standartMemeImageViewWithImageName:@"suspicious.png"];
    
    [self.slideShow addSubview:suspiciousImageView onPage:1];
    
    DRDynamicSlideShowEffect * suspiciousImageViewDynamicEffect = [[DRDynamicSlideShowEffect alloc] initWithSubview:suspiciousImageView page:0 fromFrame:suspiciousImageView.frame toFrame:CGRectMake(suspiciousImageView.frame.origin.x, suspiciousImageView.frame.origin.y-suspiciousImageView.frame.size.height, suspiciousImageView.frame.size.width, suspiciousImageView.frame.size.height) fromAlpha:1 toAlpha:1];
    [suspiciousImageViewDynamicEffect setDelay:0.95];
    
    [self.slideShow addDynamicEffect:suspiciousImageViewDynamicEffect];
    
    DRDynamicSlideShowEffect * suspiciousImageViewDynamicEffectStay = [[DRDynamicSlideShowEffect alloc] initWithSubview:suspiciousImageView page:1 fromFrame:suspiciousImageViewDynamicEffect.toFrame toFrame:CGRectMake(suspiciousImageView.frame.origin.x+320, suspiciousImageView.frame.origin.y-suspiciousImageView.frame.size.height, suspiciousImageView.frame.size.width, suspiciousImageView.frame.size.height) fromAlpha:1 toAlpha:1];
    
    [self.slideShow addDynamicEffect:suspiciousImageViewDynamicEffectStay];
    
    DRDynamicSlideShowEffect * suspiciousImageViewDynamicEffectFadeOut = [[DRDynamicSlideShowEffect alloc] initWithSubview:suspiciousImageView page:2 fromFrame:suspiciousImageViewDynamicEffectStay.toFrame toFrame:suspiciousImageViewDynamicEffectStay.toFrame fromAlpha:1 toAlpha:0];
    
    [self.slideShow addDynamicEffect:suspiciousImageViewDynamicEffectFadeOut];
    
    #pragma mark Page 2
    
    UITextView * thirdDescriptionTextView = [self standartTextView];
    [thirdDescriptionTextView setText:@"And... what if I told you I implemented each of these awesome effects in 2 lines of code?"];
    [thirdDescriptionTextView sizeToFit];
    [thirdDescriptionTextView setCenter:CGPointMake(self.slideShow.frame.size.width/2, self.slideShow.frame.size.height/2-40)];
    
    [self.slideShow addSubview:thirdDescriptionTextView onPage:2];
    
    DRDynamicSlideShowEffect * thirdDescriptionTextViewDynamicEffect = [[DRDynamicSlideShowEffect alloc] initWithSubview:thirdDescriptionTextView page:1 fromFrame:thirdDescriptionTextView.frame toFrame:thirdDescriptionTextView.frame fromAlpha:0 toAlpha:1];
    
    [self.slideShow addDynamicEffect:thirdDescriptionTextViewDynamicEffect];
    
    DRDynamicSlideShowEffect * thirdDescriptionTextViewDynamicEffectFadeOut = [[DRDynamicSlideShowEffect alloc] initWithSubview:thirdDescriptionTextView page:2 fromFrame:thirdDescriptionTextView.frame toFrame:thirdDescriptionTextView.frame fromAlpha:1 toAlpha:0];
    
    [self.slideShow addDynamicEffect:thirdDescriptionTextViewDynamicEffectFadeOut];
    
    #pragma mark Page 3
    
    UILabel * enjoyLabel = [self standartTitleLabel];
    [enjoyLabel setText:@"Enjoy!"];
    [enjoyLabel sizeToFit];
    [enjoyLabel setCenter:CGPointMake(self.slideShow.frame.size.width/2, self.slideShow.frame.size.height/2-40)];
    
    [self.slideShow addSubview:enjoyLabel onPage:3];
    
    DRDynamicSlideShowEffect * enjoyLabelDynamicEffect = [[DRDynamicSlideShowEffect alloc] initWithSubview:enjoyLabel page:2 fromFrame:enjoyLabel.frame toFrame:enjoyLabel.frame fromAlpha:0 toAlpha:1];
    
    [self.slideShow addDynamicEffect:enjoyLabelDynamicEffect];
    
    UIImageView * winImageView = [self standartMemeImageViewWithImageName:@"win.png"];
    
    [self.slideShow addSubview:winImageView onPage:3];
    
    DRDynamicSlideShowEffect * winImageViewDynamicEffect = [[DRDynamicSlideShowEffect alloc] initWithSubview:winImageView page:2 fromFrame:winImageView.frame toFrame:CGRectMake(winImageView.frame.origin.x, winImageView.frame.origin.y-winImageView.frame.size.height, winImageView.frame.size.width, winImageView.frame.size.height) fromAlpha:1 toAlpha:1];
    [winImageViewDynamicEffect setDelay:0.95];
    
    [self.slideShow addDynamicEffect:winImageViewDynamicEffect];
}

- (UILabel *)standartTitleLabel {
    UILabel * titleLabel = [UILabel new];
    [titleLabel setFrame:CGRectMake(0, 0, self.slideShow.frame.size.width-20*2, 0)];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:23]];
    
    return titleLabel;
}

- (UITextView *)standartTextView {
    UITextView * textView = [UITextView new];
    [textView setEditable:NO];
    [textView setFrame:CGRectMake(0, 0, self.slideShow.frame.size.width-20*2, 0)];
    [textView setTextAlignment:NSTextAlignmentCenter];
    [textView setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:19]];
    
    return textView;
}

- (UIImageView *)standartMemeImageViewWithImageName:(NSString *)imageName {
    UIImage * image = [UIImage imageNamed:imageName];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.slideShow.frame.size.height, image.size.width, image.size.height)];
    [imageView setImage:image];
    [imageView setCenter:CGPointMake(self.slideShow.frame.size.width/2, imageView.center.y)];
    
    return imageView;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.7 animations:^{
        [self.slideShow setAlpha:1];
    }];
}

@end