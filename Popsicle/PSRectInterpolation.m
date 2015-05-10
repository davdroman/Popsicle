//
//  PSRectInterpolation.m
//  Popsicle
//
//  Created by David Román Aguirre on 1/11/14.
//  Copyright (c) 2014 David Roman. All rights reserved.
//

#import "PSRectInterpolation.h"

#import "PSInterpolation+Subclass.h"

@implementation PSRectInterpolation

+ (instancetype)interpolationWithStartTime:(float)startTime endTime:(float)endTime fromValue:(CGRect)fromValue toValue:(CGRect)toValue {
	return [super interpolationWithStartTime:startTime endTime:endTime fromValue:[NSValue valueWithCGRect:fromValue] toValue:[NSValue valueWithCGRect:toValue]];
}

- (id)valueForTimeFraction:(float)timeFraction {
	CGRect fromValue = [self.fromValue CGRectValue];
	CGRect toValue = [self.toValue CGRectValue];
	
	CGFloat xInterpolation = Interpolation(fromValue.origin.x, toValue.origin.x, timeFraction);
	CGFloat yInterpolation = Interpolation(fromValue.origin.y, toValue.origin.y, timeFraction);
	CGFloat widthInterpolation = Interpolation(fromValue.size.width, toValue.size.width, timeFraction);
	CGFloat heightInterpolation = Interpolation(fromValue.size.height, toValue.size.height, timeFraction);
	
	CGRect value = CGRectMake(xInterpolation, yInterpolation, widthInterpolation, heightInterpolation);
	
	return [NSValue valueWithCGRect:value];
}

@end
