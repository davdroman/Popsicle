//
//  PSIntegerInterpolationTests.m
//  Popsicle
//
//  Created by David Román Aguirre on 1/11/14.
//  Copyright (c) 2014 David Roman. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "PSIntegerInterpolation.h"
#import "PSInterpolation+Subclass.h"

@interface PSIntegerInterpolationTests : XCTestCase

@end

@implementation PSIntegerInterpolationTests

- (void)testIntegerInterpolation {
	PSIntegerInterpolation *interpolation = PS(PSIntegerInterpolation, 20, 30, 10, 20);
	
	XCTAssertEqualObjects([interpolation valueForTimeFraction:0], @10);
	XCTAssertEqualObjects([interpolation valueForTimeFraction:0.5], @15);
	XCTAssertEqualObjects([interpolation valueForTimeFraction:0.7], @17);
	XCTAssertEqualObjects([interpolation valueForTimeFraction:1], @20);
}

@end
