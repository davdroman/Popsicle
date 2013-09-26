//
//  DRDynamicSlideShow.m
//  DRDynamicSlideShow
//
//  Created by David Román Aguirre on 17/09/13.
//  Copyright (c) 2013 David Román Aguirre. All rights reserved.
//

#import "DRDynamicSlideShow.h"

#pragma mark Interfaces Extensions

@interface DRDynamicSlideShow ()

@property (readwrite, nonatomic) NSInteger numberOfPages;

@end

#pragma mark Implementations

@implementation DRDynamicSlideShowEffect

- (id)initWithSubview:(UIView *)subview page:(NSInteger)page fromFrame:(CGRect)fromFrame toFrame:(CGRect)toFrame fromAlpha:(CGFloat)fromAlpha toAlpha:(CGFloat)toAlpha {
    if (self = [super init]) {
        [self setSubview:subview];
        [self setPage:page];
        [self setFromFrame:fromFrame];
        [self setToFrame:toFrame];
        [self setFromAlpha:fromAlpha];
        [self setToAlpha:toAlpha];
    }
    
    return self;
}

- (void)performWithPercentage:(CGFloat)percentage {
    [self setSubviewFrameAndAlpha:self.subview fromFrame:self.fromFrame toFrame:self.toFrame fromAlpha:self.fromAlpha toAlpha:self.toAlpha percentage:percentage delay:self.delay];
}

- (void)setSubviewFrameAndAlpha:(UIView *)subview fromFrame:(CGRect)fromFrame toFrame:(CGRect)toFrame fromAlpha:(CGFloat)fromAlpha toAlpha:(CGFloat)toAlpha percentage:(CGFloat)percentage delay:(CGFloat)delay {
    if (delay > 0) {
        if (percentage > delay) {
            percentage = (percentage-delay)/(1-delay);
        } else {
            percentage = 0;
        }
    }
    
    CGFloat newX = fromFrame.origin.x+(toFrame.origin.x-fromFrame.origin.x)*percentage;
    CGFloat newY = fromFrame.origin.y+(toFrame.origin.y-fromFrame.origin.y)*percentage;
    CGFloat newWidth = fromFrame.size.width+(toFrame.size.width-fromFrame.size.width)*percentage;
    CGFloat newHeight = fromFrame.size.height+(toFrame.size.height-fromFrame.size.height)*percentage;
    CGFloat newAlpha = fromAlpha+(toAlpha-fromAlpha)*percentage;
    
    [subview setFrame:CGRectMake(newX, newY, newWidth, newHeight)];
    [subview setAlpha:newAlpha];
}

@end

@implementation DRDynamicSlideShow

#pragma mark Basic Defined Methods

- (id)init {
    if (self = [super init]) {
        dynamicEffects = [NSMutableArray new];
        
        [self setDelegate:self];
        [self setPagingEnabled:YES];
        [self setShowsHorizontalScrollIndicator:NO];
        [self setShowsVerticalScrollIndicator:NO];
    }
    
    return self;
}

- (void)addDynamicEffect:(DRDynamicSlideShowEffect *)dynamicEffect {
    [dynamicEffects addObject:dynamicEffect];
}

- (void)addSubview:(UIView *)subview onPage:(NSInteger)page {
    [subview setFrame:CGRectMake(subview.frame.origin.x+self.frame.size.width*page, subview.frame.origin.y, subview.frame.size.width, subview.frame.size.height)];
    [self addSubview:subview];
}

#pragma mark Listeners

- (void)didAddSubview:(UIView *)subview {
    if (subview.frame.origin.x >= self.contentSize.width) {
        NSInteger numberOfPages = floorf(subview.frame.origin.x/self.frame.size.width)+1;
        
        [self setNumberOfPages:numberOfPages];
        [self setContentSize:CGSizeMake(self.frame.size.width*self.numberOfPages, self.contentSize.height)];
    }
}

#pragma mark Useful Methods

- (NSInteger)currentPage {
    NSInteger page = floor(self.contentOffset.x / self.frame.size.width);
    
    return page;
}

- (void)resetCurrentDynamicEffectsForPage:(NSInteger)page {
    currentDynamicEffects = [self dynamicEffectsForPage:page];
}

- (NSArray *)dynamicEffectsForPage:(NSInteger)page {
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"page == %i", page];
    NSArray * filteredEffects = [dynamicEffects filteredArrayUsingPredicate:predicate];
    
    return filteredEffects;
}

#pragma mark Scroll View Delegate Methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSInteger page = [self currentPage];
    
    [self resetCurrentDynamicEffectsForPage:page];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger page = [self currentPage];
    
    if (currentPage != page) {
        [self performCurrentDynamicEffectsWithPercentage:(currentPage < page ? 1 : 0)];
        currentPage = page;
        [self resetCurrentDynamicEffectsForPage:page];
        if (self.didReachPageBlock) self.didReachPageBlock(page);
    }
    
    CGFloat horizontalScroll = self.contentOffset.x-self.frame.size.width*currentPage;
    CGFloat percentage = horizontalScroll/self.frame.size.width;
    
    [self performCurrentDynamicEffectsWithPercentage:percentage];
}

- (void)performCurrentDynamicEffectsWithPercentage:(CGFloat)percentage {
    for (DRDynamicSlideShowEffect * dynamicEffect in currentDynamicEffects) {
        [dynamicEffect performWithPercentage:percentage];
    }
}

@end