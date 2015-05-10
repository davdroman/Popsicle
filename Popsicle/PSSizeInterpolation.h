//
//  PSSizeInterpolation.h
//  Popsicle
//
//  Created by David Román Aguirre on 1/11/14.
//  Copyright (c) 2014 David Roman. All rights reserved.
//

#import "PSInterpolation.h"
#import <UIKit/UIKit.h>

@interface PSSizeInterpolation : PSInterpolation

+ (instancetype)interpolationWithStartTime:(float)startTime endTime:(float)endTime fromValue:(CGSize)fromValue toValue:(CGSize)toValue;

@end
