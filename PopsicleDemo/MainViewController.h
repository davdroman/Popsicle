//
//  MainViewController.h
//  Popsicle
//
//  Created by David Román Aguirre on 1/4/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstPageView : UIView

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewCenterYConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewCenterXConstraint;

@end

@interface SecondPageView : UIView

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@interface ThirdPageView : UIView

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@interface FourthPageView : UIView

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@interface MainViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, weak) FirstPageView *firstPageView;
@property (nonatomic, weak) SecondPageView *secondPageView;
@property (nonatomic, weak) ThirdPageView *thirdPageView;
@property (nonatomic, weak) FourthPageView *fourthPageView;

@end
