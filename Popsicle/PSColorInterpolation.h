//
//  PSColorInterpolation.h
//  Popsicle
//
//  Created by David Román Aguirre on 3/11/14.
//  Copyright (c) 2014 David Roman. All rights reserved.
//

#import "PSInterpolation.h"
#import <UIKit/UIKit.h>

@interface PSColorInterpolation : PSInterpolation

+ (instancetype)interpolationWithStartTime:(float)startTime endTime:(float)endTime fromValue:(UIColor *)fromValue toValue:(UIColor *)toValue;

@end
