//
//  UIView+Utils.m
//  Popsicle
//
//  Created by David Román Aguirre on 9/5/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "UIView+Utils.h"

@implementation UIView (Utils)

#pragma mark Extended frame properties

- (CGFloat)x {
	return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
	self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)y {
	return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
	self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)width {
	return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}

- (CGFloat)height {
	return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

#pragma mark Helper methods

- (void)pinToSuperviewEdges {
	self.translatesAutoresizingMaskIntoConstraints = NO;
	
	NSArray *attributeArray = @[@(NSLayoutAttributeTop), @(NSLayoutAttributeLeft), @(NSLayoutAttributeBottom), @(NSLayoutAttributeRight)];
	
	for (NSNumber *attributeNumber in attributeArray) {
		NSLayoutAttribute attribute = (NSLayoutAttribute)[attributeNumber integerValue];
		
		NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:attribute multiplier:1 constant:0];
		
		[self.superview addConstraint:constraint];
	}
}

+ (NSDictionary *)nibViewsByClassWithNibName:(NSString *)nibName {
	NSMutableDictionary *nibViewsDictionary = [NSMutableDictionary new];
	NSArray *nibViewsArray = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
	
	for (id nibView in nibViewsArray) {
		[nibViewsDictionary setObject:nibView forKey:NSStringFromClass([nibView class])];
	}
	
	return nibViewsDictionary;
}

@end
