//
//  PSSizeInterpolation.m
//  Popsicle
//
//  Created by David Román Aguirre on 1/11/14.
//  Copyright (c) 2014 David Roman. All rights reserved.
//

#import "PSSizeInterpolation.h"

#import "PSInterpolation+Subclass.h"

@implementation PSSizeInterpolation

+ (instancetype)interpolationWithStartTime:(float)startTime endTime:(float)endTime fromValue:(CGSize)fromValue toValue:(CGSize)toValue {
	return [super interpolationWithStartTime:startTime endTime:endTime fromValue:[NSValue valueWithCGSize:fromValue] toValue:[NSValue valueWithCGSize:toValue]];
}

- (id)valueForTimeFraction:(float)timeFraction {
	CGSize fromValue = [self.fromValue CGSizeValue];
	CGSize toValue = [self.toValue CGSizeValue];
	
	CGFloat widthInterpolation = Interpolation(fromValue.width, toValue.width, timeFraction);
	CGFloat heightInterpolation = Interpolation(fromValue.height, toValue.height, timeFraction);
	
	CGSize value = CGSizeMake(widthInterpolation, heightInterpolation);
	
	return [NSValue valueWithCGSize:value];
}

@end
