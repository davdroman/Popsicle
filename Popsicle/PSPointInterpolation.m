//
//  PSPointInterpolation.m
//  Popsicle
//
//  Created by David Román Aguirre on 1/11/14.
//  Copyright (c) 2014 David Roman. All rights reserved.
//

#import "PSPointInterpolation.h"

#import "PSInterpolation+Subclass.h"

@implementation PSPointInterpolation

+ (instancetype)interpolationWithStartTime:(float)startTime endTime:(float)endTime fromValue:(CGPoint)fromValue toValue:(CGPoint)toValue {
	return [super interpolationWithStartTime:startTime endTime:endTime fromValue:[NSValue valueWithCGPoint:fromValue] toValue:[NSValue valueWithCGPoint:toValue]];
}

- (id)valueForTimeFraction:(float)timeFraction {
	CGPoint fromValue = [self.fromValue CGPointValue];
	CGPoint toValue = [self.toValue CGPointValue];
	
	CGFloat xInterpolation = Interpolation(fromValue.x, toValue.x, timeFraction);
	CGFloat yInterpolation = Interpolation(fromValue.y, toValue.y, timeFraction);
	
	CGPoint value = CGPointMake(xInterpolation, yInterpolation);
	
	return [NSValue valueWithCGPoint:value];
}

@end
