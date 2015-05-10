//
//  PSAffineTransformInterpolationTests.m
//  Popsicle
//
//  Created by David Román Aguirre on 3/11/14.
//  Copyright (c) 2014 David Roman. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "PSAffineTransformInterpolation.h"
#import "PSInterpolation+Subclass.h"

#define CGAffineTransformGetXTranslation(t) t.tx
#define CGAffineTransformGetYTranslation(t) t.ty
#define CGAffineTransformGetXScale(t) sqrt(t.a * t.a + t.c * t.c)
#define CGAffineTransformGetYScale(t) sqrt(t.b * t.b + t.d * t.d)
#define CGAffineTransformGetRotation(t) atan2f(t.b, t.a)

@interface PSAffineTransformInterpolationTests : XCTestCase

@end

@implementation PSAffineTransformInterpolationTests

- (void)testTranslationAffineTransformInterpolation {
	PSAffineTransformInterpolation *interpolation = PS(PSAffineTransformInterpolation, 0, 100, CGAffineTransformIdentity, CGAffineTransformMakeTranslation(100, 100));
	
	CGAffineTransform intermediateAffineTransform = [[interpolation valueForTimeFraction:0.5] CGAffineTransformValue];
	XCTAssertEqual(CGAffineTransformGetXTranslation(intermediateAffineTransform), 50);
	XCTAssertEqual(CGAffineTransformGetYTranslation(intermediateAffineTransform), 50);
}

- (void)testScaleAffineTransformInterpolation {
	PSAffineTransformInterpolation *interpolation = PS(PSAffineTransformInterpolation, 0, 100, CGAffineTransformIdentity, CGAffineTransformMakeScale(1.5, 1.5));
	
	CGAffineTransform intermediateAffineTransform = [[interpolation valueForTimeFraction:0.5] CGAffineTransformValue];
	XCTAssertEqual(CGAffineTransformGetXScale(intermediateAffineTransform), 1.25);
	XCTAssertEqual(CGAffineTransformGetYScale(intermediateAffineTransform), 1.25);
}

- (void)testRotationAffineTransformInterpolation {
	PSAffineTransformInterpolation *interpolation = PS(PSAffineTransformInterpolation, 0, 100, CGAffineTransformIdentity, CGAffineTransformMakeRotation(0.5));
	
	CGAffineTransform intermediateAffineTransform = [[interpolation valueForTimeFraction:0.5] CGAffineTransformValue];
	XCTAssertEqual(CGAffineTransformGetRotation(intermediateAffineTransform), 0.25);
}

@end
