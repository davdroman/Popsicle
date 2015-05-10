//
//  PSInterpolation.m
//  Popsicle
//
//  Created by David Román Aguirre on 27/10/14.
//  Copyright (c) 2014 David Roman. All rights reserved.
//

#import "PSInterpolation.h"

@implementation PSInterpolation

- (instancetype)initWithStartTime:(float)startTime endTime:(float)endTime fromValue:(id)fromValue toValue:(id)toValue {
	if (self = [super init]) {
		self.startTime = startTime;
		self.endTime = endTime;
		
		self.fromValue = fromValue;
		self.toValue = toValue;
	}
	
	return self;
}

+ (instancetype)interpolationWithStartTime:(float)startTime endTime:(float)endTime fromValue:(id)fromValue toValue:(id)toValue {
	return [[self alloc] initWithStartTime:startTime endTime:endTime fromValue:fromValue toValue:toValue];
}

@end
