//
//  PSColorInterpolation.m
//  Popsicle
//
//  Created by David Román Aguirre on 3/11/14.
//  Copyright (c) 2014 David Roman. All rights reserved.
//

#import "PSColorInterpolation.h"

#import "PSInterpolation+Subclass.h"

@implementation PSColorInterpolation

+ (instancetype)interpolationWithStartTime:(float)startTime endTime:(float)endTime fromValue:(UIColor *)fromValue toValue:(UIColor *)toValue {
	return [super interpolationWithStartTime:startTime endTime:endTime fromValue:fromValue toValue:toValue];
}

- (id)valueForTimeFraction:(float)timeFraction {
	UIColor *fromValue = self.fromValue;
	UIColor *toValue = self.toValue;
	
	CGFloat fromRed;
	CGFloat fromGreen;
	CGFloat fromBlue;
	CGFloat fromAlpha;
	
	CGFloat toRed;
	CGFloat toGreen;
	CGFloat toBlue;
	CGFloat toAlpha;
	
	[fromValue getRed:&fromRed green:&fromGreen blue:&fromBlue alpha:&fromAlpha];
	[toValue getRed:&toRed green:&toGreen blue:&toBlue alpha:&toAlpha];
	
	CGFloat redInterpolation = Interpolation(fromRed, toRed, timeFraction);
	CGFloat greenInterpolation = Interpolation(fromGreen, toGreen, timeFraction);
	CGFloat blueInterpolation = Interpolation(fromBlue, toBlue, timeFraction);
	CGFloat alphaInterpolation = Interpolation(fromAlpha, toAlpha, timeFraction);
	
	UIColor *value = [UIColor colorWithRed:redInterpolation green:greenInterpolation blue:blueInterpolation alpha:alphaInterpolation];
	
	return value;
}

@end
