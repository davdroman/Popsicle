//
//  DRDynamicSlideShow.h
//  DRDynamicSlideShow
//
//  Created by David Román Aguirre on 17/09/13.
//  Copyright (c) 2013 David Román Aguirre. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark Interfaces

@interface DRDynamicSlideShowEffect : NSObject

@property (strong, nonatomic) UIView * subview;
@property (nonatomic) NSInteger page;
@property (nonatomic) CGRect fromFrame;
@property (nonatomic) CGFloat fromAlpha;
@property (nonatomic) CGRect toFrame;
@property (nonatomic) CGFloat toAlpha;
@property (nonatomic) CGFloat delay;

- (id)initWithSubview:(UIView *)subview page:(NSInteger)page fromFrame:(CGRect)fromFrame toFrame:(CGRect)toFrame fromAlpha:(CGFloat)fromAlpha toAlpha:(CGFloat)toAlpha;

@end

@interface DRDynamicSlideShow : UIScrollView <UIScrollViewDelegate> {
    NSMutableArray * dynamicEffects;
    NSArray * currentDynamicEffects;
    NSInteger currentPage;
}

@property (readonly, nonatomic) NSInteger numberOfPages;
@property (strong, nonatomic) void (^didReachPageBlock)(NSInteger page);

- (void)addDynamicEffect:(DRDynamicSlideShowEffect *)dynamicEffect;
- (void)addSubview:(UIView *)subview onPage:(NSInteger)page;

// @property (nonatomic) DRDynamicSlideShowDirection direction;
// - (id)initWithOrientation:(DRDynamicSlideShowDirection)direction;

// ;)

@end