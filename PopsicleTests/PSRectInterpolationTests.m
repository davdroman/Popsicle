//
//  PSRectInterpolationTests.m
//  Popsicle
//
//  Created by David Román Aguirre on 2/11/14.
//  Copyright (c) 2014 David Roman. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "PSRectInterpolation.h"
#import "PSInterpolation+Subclass.h"

@interface PSRectInterpolationTests : XCTestCase

@end

@implementation PSRectInterpolationTests

- (void)testRectInterpolation {
	PSRectInterpolation *interpolation = PS(PSRectInterpolation, 0, 100, CGRectMake(30, 10, 200, 150), CGRectMake(90, 20, 100, 100));
	
	XCTAssertEqual([[interpolation valueForTimeFraction:0] CGRectValue].origin.x, 30);
	XCTAssertEqual([[interpolation valueForTimeFraction:0] CGRectValue].origin.y, 10);
	XCTAssertEqual([[interpolation valueForTimeFraction:0] CGRectValue].size.width, 200);
	XCTAssertEqual([[interpolation valueForTimeFraction:0] CGRectValue].size.height, 150);
	
	XCTAssertEqual([[interpolation valueForTimeFraction:0.5] CGRectValue].origin.x, 60);
	XCTAssertEqual([[interpolation valueForTimeFraction:0.5] CGRectValue].origin.y, 15);
	XCTAssertEqual([[interpolation valueForTimeFraction:0.5] CGRectValue].size.width, 150);
	XCTAssertEqual([[interpolation valueForTimeFraction:0.5] CGRectValue].size.height, 125);
	
	XCTAssertEqual([[interpolation valueForTimeFraction:1] CGRectValue].origin.x, 90);
	XCTAssertEqual([[interpolation valueForTimeFraction:1] CGRectValue].origin.y, 20);
	XCTAssertEqual([[interpolation valueForTimeFraction:1] CGRectValue].size.width, 100);
	XCTAssertEqual([[interpolation valueForTimeFraction:1] CGRectValue].size.height, 100);
}

@end
