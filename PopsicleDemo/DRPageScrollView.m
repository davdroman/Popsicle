//
//  DRPageScrollView.m
//  DRPageScrollView
//
//  Created by David Román Aguirre on 3/4/15.
//  Copyright (c) 2015 David Román Aguirre. All rights reserved.
//

#import "DRPageScrollView.h"

@interface DRPageScrollView	() {
	NSInteger previousPage;
	NSInteger instantaneousPreviousPage;
}

@property (nonatomic, strong) NSArray *pageViews;
@property (nonatomic, strong) NSArray *pageHandlers;

@end

@implementation DRPageScrollView

- (instancetype)init {
	if (self = [super init]) {
		[self commonInit];
	}
	
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self commonInit];
	}

	return self;
}

- (void)commonInit {
	previousPage = -1;
	self.pagingEnabled = YES;
	self.showsHorizontalScrollIndicator = NO;
	self.showsVerticalScrollIndicator = NO;

	self.pageViews = [NSMutableArray new];
	self.pageHandlers = [NSArray new];
}

- (void)setPageReuseEnabled:(BOOL)pageReuseEnabled {
	if (self.numberOfPages > 0) return;
	_pageReuseEnabled = pageReuseEnabled;
}

- (NSInteger)currentPage {
	CGPoint presentationLayerContentOffset = [self.layer.presentationLayer bounds].origin;
	return MAX(round(presentationLayerContentOffset.x/self.frame.size.width), 0);
}

- (void)setCurrentPage:(NSInteger)currentPage {
	self.contentOffset = CGPointMake(self.frame.size.width*currentPage, self.contentOffset.y);
}

- (NSInteger)numberOfPages {
	return [self.pageHandlers count];
}

- (void)addPageWithHandler:(DRPageHandlerBlock)handler {
	self.pageHandlers = [self.pageHandlers arrayByAddingObject:handler];
}

#pragma mark Pages

- (BOOL)isAnimating {
	return [[self.layer animationKeys] count] != 0;
}

- (void)setContentOffset:(CGPoint)contentOffset {
	[super setContentOffset:contentOffset];
	
	if ([self isAnimating]) {
		CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(didRefreshDisplay:)];
		[displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
	} else {
		[self didScrollToPosition:contentOffset];
	}
}

- (void)didRefreshDisplay:(CADisplayLink *)displayLink {
	if ([self isAnimating]) {
		CGPoint presentationLayerContentOffset = [self.layer.presentationLayer bounds].origin;
		[self didScrollToPosition:presentationLayerContentOffset];
	} else {
		[displayLink invalidate];
	}
}

- (void)didScrollToPosition:(CGPoint)position {
	if (self.numberOfPages == 0 || self.currentPage == previousPage) return;
	
	if (self.pageReuseEnabled) {
		for (UIView *pageView in self.pageViews) {
			if (pageView.tag < self.currentPage - 1 || pageView.tag > self.currentPage + 1) {
				[self queuePageView:pageView];
			}
		}
	}
	
	for (NSInteger i = self.currentPage-1; i <= self.currentPage+1; i++) {
		if (i >= 0 && i < self.numberOfPages && ![self pageViewWithTag:i]) {
			UIView *pageView = [self dequeuePageView];
			pageView.tag = i;
			
			DRPageHandlerBlock handler = self.pageHandlers[i];
			handler(pageView);
			[self addSubview:pageView];
			
			NSInteger pageMultiplier = 2*i+1; // We need an odd multiplier. Any odd number can be expressed as 2n+1.
			
			NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:pageMultiplier constant:0];
			NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
			NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
			NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
			
			[self addConstraints:@[centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]]; // This may lead to vertical orientation support in the future ;)
		}
	}
	
	previousPage = self.currentPage;
}

- (void)queuePageView:(UIView *)pageView {
	[pageView removeFromSuperview];
	
	for (UIView *sb in pageView.subviews) {
		[sb removeFromSuperview];
	}
	
	pageView.tag = -1;
}

- (UIView *)dequeuePageView {
	for (UIView *pv in self.pageViews) {
		if (!pv.superview) {
			return pv;
		}
	}
	
	UIView *pageView = [UIView new];
	pageView.tag = -1;
	pageView.translatesAutoresizingMaskIntoConstraints = NO;
	self.pageViews = [self.pageViews arrayByAddingObject:pageView];
	
	return pageView;
}

- (UIView *)pageViewWithTag:(NSInteger)tag {
	for (UIView *pageView in self.subviews) {
		if (pageView.tag == tag && pageView.class == [UIView class]) {
			return pageView;
		}
	}
	
	return nil;
}

#pragma mark Rotation/resize

- (void)layoutSubviews {
	CGFloat neededContentSizeWidth = self.frame.size.width*self.numberOfPages;
	
	if (self.contentSize.width != neededContentSizeWidth) {
		[self refreshDimensions];
		self.currentPage = instantaneousPreviousPage;
	} else {
		instantaneousPreviousPage = self.currentPage;
	}
	
	[super layoutSubviews];
}

- (void)refreshDimensions {
	self.contentSize = CGSizeMake(self.frame.size.width*self.numberOfPages, self.frame.size.height);
	self.contentInset = UIEdgeInsetsZero;
}

@end
