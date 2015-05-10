//
//  PSInterpolation.h
//  Popsicle
//
//  Created by David Román Aguirre on 27/10/14.
//  Copyright (c) 2014 David Roman. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PS(INTERPOLATION_CLASS, START_TIME, END_TIME, FROM_VALUE, TO_VALUE) [INTERPOLATION_CLASS interpolationWithStartTime:START_TIME endTime:END_TIME fromValue:FROM_VALUE toValue:TO_VALUE]

@interface PSInterpolation : NSObject

@property (nonatomic) float startTime;
@property (nonatomic) float endTime;

@property (nonatomic, strong) id fromValue;
@property (nonatomic, strong) id toValue;

+ (instancetype)interpolationWithStartTime:(float)startTime endTime:(float)endTime fromValue:(id)fromValue toValue:(id)toValue;

@end
