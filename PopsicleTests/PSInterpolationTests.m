//
//  PSInterpolationTests.m
//  Popsicle
//
//  Created by David Román Aguirre on 1/11/14.
//  Copyright (c) 2014 David Roman. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "PSInterpolation.h"
#import "PSInterpolation+Subclass.h"

@interface PSInterpolationTests : XCTestCase

@end

@implementation PSInterpolationTests

- (void)testInterpolation {
	XCTAssertEqual(Interpolation(10, 20, 0.75), 17.5);
}

- (void)testInitialization {
	PSInterpolation *interpolation = PS(PSInterpolation, 20, 30, [NSObject new], [NSObject new]);
	
	XCTAssertEqual(interpolation.startTime, 20);
	XCTAssertEqual(interpolation.endTime, 30);
	XCTAssertNotNil(interpolation.fromValue);
	XCTAssertNotNil(interpolation.toValue);
}

@end
