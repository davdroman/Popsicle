//
//  PSColorInterpolationTests.m
//  Popsicle
//
//  Created by David Román Aguirre on 4/11/14.
//  Copyright (c) 2014 David Roman. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "PSColorInterpolation.h"
#import "PSInterpolation+Subclass.h"

@interface PSColorInterpolationTests : XCTestCase

@end

@implementation PSColorInterpolationTests

- (void)testColorInterpolation {
	PSColorInterpolation *interpolation = PS(PSColorInterpolation, 0, 100, [UIColor whiteColor], [UIColor blackColor]);
	
	CGFloat intermediateColorRedComponent;
	CGFloat intermediateColorGreenComponent;
	CGFloat intermediateColorBlueComponent;
	CGFloat intermediateColorAlphaComponent;
	
	CGFloat grayColorRedComponent;
	CGFloat grayColorGreenComponent;
	CGFloat grayColorBlueComponent;
	CGFloat grayColorAlphaComponent;
	
	[[interpolation valueForTimeFraction:0.5] getRed:&intermediateColorRedComponent green:&intermediateColorGreenComponent blue:&intermediateColorBlueComponent alpha:&intermediateColorAlphaComponent];
	[[UIColor grayColor] getRed:&grayColorRedComponent green:&grayColorGreenComponent blue:&grayColorBlueComponent alpha:&grayColorAlphaComponent];
	
	XCTAssertEqual(intermediateColorRedComponent, grayColorRedComponent);
	XCTAssertEqual(intermediateColorGreenComponent, grayColorGreenComponent);
	XCTAssertEqual(intermediateColorBlueComponent, grayColorBlueComponent);
	XCTAssertEqual(intermediateColorAlphaComponent, grayColorAlphaComponent);
}

@end
