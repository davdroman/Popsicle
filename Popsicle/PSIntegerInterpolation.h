//
//  PSIntegerInterpolation.h
//  Popsicle
//
//  Created by David Román Aguirre on 27/10/14.
//  Copyright (c) 2014 David Roman. All rights reserved.
//

#import "PSInterpolation.h"

@interface PSIntegerInterpolation : PSInterpolation

+ (instancetype)interpolationWithStartTime:(float)startTime endTime:(float)endTime fromValue:(NSInteger)fromValue toValue:(NSInteger)toValue;

@end
