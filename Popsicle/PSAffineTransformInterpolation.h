//
//  PSAffineTransformInterpolation.h
//  Popsicle
//
//  Created by David Román Aguirre on 3/11/14.
//  Copyright (c) 2014 David Roman. All rights reserved.
//

#import "PSInterpolation.h"
#import <UIKit/UIKit.h>

#define CGAffineTransformCreate(tx, ty, sx, sy, deg) CGAffineTransformRotate(CGAffineTransformConcat(CGAffineTransformMakeTranslation(tx, ty), CGAffineTransformMakeScale(sx, sy)), (deg*M_PI_2)/180)

@interface PSAffineTransformInterpolation : PSInterpolation

+ (instancetype)interpolationWithStartTime:(float)startTime endTime:(float)endTime fromValue:(CGAffineTransform)fromValue toValue:(CGAffineTransform)toValue;

@end
