//
//  DRDynamicSlideShow.h
//  DRDynamicSlideShow
//
//  Created by David Román Aguirre on 17/09/13.
//  Copyright (c) 2013 David Román Aguirre. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark Interfaces

@interface DRDynamicSlideShowAnimation : NSObject

@property (strong, nonatomic) id subview;
@property (nonatomic) NSInteger page;
@property (strong, nonatomic) NSString * keyPath;
@property (strong, nonatomic) id fromValue;
@property (strong, nonatomic) id toValue;
@property (nonatomic) CGFloat delay;

+ (id)animationForSubview:(UIView *)subview page:(NSInteger)page keyPath:(NSString *)keyPath toValue:(id)toValue delay:(CGFloat)delay;
+ (id)animationForSubview:(UIView *)subview page:(NSInteger)page keyPath:(NSString *)keyPath fromValue:(id)fromValue toValue:(id)toValue delay:(CGFloat)delay;

@end

@interface DRDynamicSlideShow : UIScrollView <UIScrollViewDelegate> {
    NSMutableArray * animations;
    NSArray * currentAnimations;
    NSInteger currentPage;
    UITapGestureRecognizer * tapGestureRecognizer;
}

@property (readonly, nonatomic) NSInteger numberOfPages;
@property (nonatomic) BOOL scrollsPageOnTap;
@property (strong, nonatomic) void (^didReachPageBlock)(NSInteger page);
@property (strong, nonatomic) void (^didScrollBlock)(CGPoint contentOffset);

- (void)addAnimation:(DRDynamicSlideShowAnimation *)animation;
- (void)addSubview:(UIView *)subview onPage:(NSInteger)page;

// @property (nonatomic) DRDynamicSlideShowDirection direction;
// - (id)initWithOrientation:(DRDynamicSlideShowDirection)direction;

// ;)

@end