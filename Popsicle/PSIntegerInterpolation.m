//
//  PSIntegerInterpolation.m
//  Popsicle
//
//  Created by David Román Aguirre on 27/10/14.
//  Copyright (c) 2014 David Roman. All rights reserved.
//

#import "PSIntegerInterpolation.h"

#import "PSInterpolation+Subclass.h"

@implementation PSIntegerInterpolation

+ (instancetype)interpolationWithStartTime:(float)startTime endTime:(float)endTime fromValue:(NSInteger)fromValue toValue:(NSInteger)toValue {
	return [super interpolationWithStartTime:startTime endTime:endTime fromValue:@(fromValue) toValue:@(toValue)];
}

- (id)valueForTimeFraction:(float)timeFraction {
	NSInteger fromValue = [self.fromValue integerValue];
	NSInteger toValue = [self.toValue integerValue];
	
	NSInteger value = (NSInteger)floor(Interpolation(fromValue, toValue, timeFraction));
	
	return @(value);
}

@end
