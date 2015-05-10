//
//  PSPointInterpolationTests.m
//  Popsicle
//
//  Created by David Román Aguirre on 1/11/14.
//  Copyright (c) 2014 David Roman. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "PSPointInterpolation.h"
#import "PSInterpolation+Subclass.h"

@interface PSPointInterpolationTests : XCTestCase

@end

@implementation PSPointInterpolationTests

- (void)testPointInterpolation {
	PSPointInterpolation *interpolation = PS(PSPointInterpolation, 0, 100, CGPointMake(30, 10), CGPointMake(90, 20));
	
	XCTAssertEqual([[interpolation valueForTimeFraction:0] CGPointValue].x, 30);
	XCTAssertEqual([[interpolation valueForTimeFraction:0] CGPointValue].y, 10);
	
	XCTAssertEqual([[interpolation valueForTimeFraction:0.5] CGPointValue].x, 60);
	XCTAssertEqual([[interpolation valueForTimeFraction:0.5] CGPointValue].y, 15);
	
	XCTAssertEqual([[interpolation valueForTimeFraction:1] CGPointValue].x, 90);
	XCTAssertEqual([[interpolation valueForTimeFraction:1] CGPointValue].y, 20);
}

@end
