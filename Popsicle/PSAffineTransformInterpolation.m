//
//  PSAffineTransformInterpolation.m
//  Popsicle
//
//  Created by David Román Aguirre on 3/11/14.
//  Copyright (c) 2014 David Roman. All rights reserved.
//

#import "PSAffineTransformInterpolation.h"

#import "PSInterpolation+Subclass.h"

#define CGAffineTransformGetXTranslation(t) t.tx
#define CGAffineTransformGetYTranslation(t) t.ty
#define CGAffineTransformGetXScale(t) sqrt(t.a * t.a + t.c * t.c)
#define CGAffineTransformGetYScale(t) sqrt(t.b * t.b + t.d * t.d)
#define CGAffineTransformGetRotation(t) atan2f(t.b, t.a)

@implementation PSAffineTransformInterpolation

+ (instancetype)interpolationWithStartTime:(float)startTime endTime:(float)endTime fromValue:(CGAffineTransform)fromValue toValue:(CGAffineTransform)toValue {
	return [super interpolationWithStartTime:startTime endTime:endTime fromValue:[NSValue valueWithCGAffineTransform:fromValue] toValue:[NSValue valueWithCGAffineTransform:toValue]];
}

- (id)valueForTimeFraction:(float)timeFraction {
	CGAffineTransform fromValue = [self.fromValue CGAffineTransformValue];
	CGAffineTransform toValue = [self.toValue CGAffineTransformValue];
	
	CGFloat xTranslationInterpolation = Interpolation(fromValue.tx, toValue.tx, timeFraction);
	CGFloat yTranslationInterpolation = Interpolation(fromValue.ty, toValue.ty, timeFraction);
	CGAffineTransform translationValue = CGAffineTransformMakeTranslation(xTranslationInterpolation, yTranslationInterpolation);
	
	CGFloat xScaleInterpolation = Interpolation(CGAffineTransformGetXScale(fromValue), CGAffineTransformGetXScale(toValue), timeFraction);
	CGFloat yScaleInterpolation = Interpolation(CGAffineTransformGetYScale(fromValue), CGAffineTransformGetYScale(toValue), timeFraction);
	CGAffineTransform scaleValue = CGAffineTransformMakeScale(xScaleInterpolation, yScaleInterpolation);
	
	CGFloat rotationInterpolation = Interpolation(CGAffineTransformGetRotation(fromValue), CGAffineTransformGetRotation(toValue), timeFraction);
	CGAffineTransform rotationValue = CGAffineTransformMakeRotation(rotationInterpolation);
	
	CGAffineTransform value = CGAffineTransformConcat(CGAffineTransformConcat(translationValue, scaleValue), rotationValue);
	
	return [NSValue valueWithCGAffineTransform:value];
}

@end
