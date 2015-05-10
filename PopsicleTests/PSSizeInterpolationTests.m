//
//  PSSizeInterpolationTests.m
//  Popsicle
//
//  Created by David Román Aguirre on 2/11/14.
//  Copyright (c) 2014 David Roman. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "PSSizeInterpolation.h"
#import "PSInterpolation+Subclass.h"

@interface PSSizeInterpolationTests : XCTestCase

@end

@implementation PSSizeInterpolationTests

- (void)testSizeInterpolation {
	PSSizeInterpolation *interpolation = PS(PSSizeInterpolation, 0, 100, CGSizeMake(30, 10), CGSizeMake(90, 20));
	
	XCTAssertEqual([[interpolation valueForTimeFraction:0] CGSizeValue].width, 30);
	XCTAssertEqual([[interpolation valueForTimeFraction:0] CGSizeValue].height, 10);
	
	XCTAssertEqual([[interpolation valueForTimeFraction:0.5] CGSizeValue].width, 60);
	XCTAssertEqual([[interpolation valueForTimeFraction:0.5] CGSizeValue].height, 15);
	
	XCTAssertEqual([[interpolation valueForTimeFraction:1] CGSizeValue].width, 90);
	XCTAssertEqual([[interpolation valueForTimeFraction:1] CGSizeValue].height, 20);
}

@end
