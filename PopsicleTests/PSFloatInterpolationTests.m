//
//  PSFloatInterpolationTests.m
//  Popsicle
//
//  Created by David Román Aguirre on 1/11/14.
//  Copyright (c) 2014 David Roman. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "PSFloatInterpolation.h"
#import "PSInterpolation+Subclass.h"

@interface PSFloatInterpolationTests : XCTestCase

@end

@implementation PSFloatInterpolationTests

- (void)testFloatInterpolation {
	PSFloatInterpolation *interpolation = PS(PSFloatInterpolation, 0, 30, 10, 20);
	
	XCTAssertEqualObjects([interpolation valueForTimeFraction:0], @10);
	XCTAssertEqualObjects([interpolation valueForTimeFraction:0.5], @15);
	XCTAssertEqual([[interpolation valueForTimeFraction:0.6916666] floatValue], 16.916666f);
	XCTAssertEqualObjects([interpolation valueForTimeFraction:1], @20);
}

@end
