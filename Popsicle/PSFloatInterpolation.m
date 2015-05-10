//
//  PSFloatInterpolation.m
//  Popsicle
//
//  Created by David Román Aguirre on 1/11/14.
//  Copyright (c) 2014 David Roman. All rights reserved.
//

#import "PSFloatInterpolation.h"

#import "PSInterpolation+Subclass.h"

@implementation PSFloatInterpolation

+ (instancetype)interpolationWithStartTime:(float)startTime endTime:(float)endTime fromValue:(float)fromValue toValue:(float)toValue {
	return [super interpolationWithStartTime:startTime endTime:endTime fromValue:@(fromValue) toValue:@(toValue)];
}

- (id)valueForTimeFraction:(float)timeFraction {
	float fromValue = [self.fromValue floatValue];
	float toValue = [self.toValue floatValue];
	
	float value = Interpolation(fromValue, toValue, timeFraction);
	
	return @(value);
}

@end
