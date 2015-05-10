//
//  PSInterpolation+Subclass.h
//  Popsicle
//
//  Created by David Román Aguirre on 1/11/14.
//  Copyright (c) 2014 David Roman. All rights reserved.
//

#define Interpolation(FROM_VALUE, TO_VALUE, TIME_FRACTION) (float)FROM_VALUE+((float)TO_VALUE-(float)FROM_VALUE)*(float)TIME_FRACTION

@interface PSInterpolation ()

- (id)valueForTimeFraction:(float)timeFraction;

@end
