//
//  PSInterpolationContext.m
//  Popsicle
//
//  Created by David Román Aguirre on 10/5/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "PSInterpolationContext.h"

@implementation PSInterpolationContext

- (instancetype)initWithWithInterpolation:(PSInterpolation *)interpolation object:(id)object keyPath:(NSString *)keyPath {
	if (self = [super init]) {
		self.interpolation = interpolation;
		self.object = object;
		self.keyPath = keyPath;
	}
	
	return self;
}

+ (instancetype)contextWithInterpolation:(PSInterpolation *)interpolation object:(id)object keyPath:(NSString *)keyPath {
	return [[self alloc] initWithWithInterpolation:interpolation object:object keyPath:keyPath];
}

@end
