//
//  PSFloatInterpolation.h
//  Popsicle
//
//  Created by David Román Aguirre on 1/11/14.
//  Copyright (c) 2014 David Roman. All rights reserved.
//

#import "PSInterpolation.h"

@interface PSFloatInterpolation : PSInterpolation

+ (instancetype)interpolationWithStartTime:(float)startTime endTime:(float)endTime fromValue:(float)fromValue toValue:(float)toValue;

@end
