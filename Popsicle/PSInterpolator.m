//
//  PSInterpolator.m
//  Popsicle
//
//  Created by David Román Aguirre on 27/10/14.
//  Copyright (c) 2014 David Roman. All rights reserved.
//

#import "PSInterpolator.h"

#import "PSInterpolation.h"
#import "PSInterpolationContext.h"
#import "PSInterpolation+Subclass.h"

#define Fraction(START_VALUE, END_VALUE, VALUE) ((float)VALUE-(float)START_VALUE)/((float)END_VALUE-(float)START_VALUE)

@interface PSInterpolator ()

@property (nonatomic, strong) NSMutableArray *interpolationContexts;

@end

@implementation PSInterpolator

- (instancetype)init {
	if (self = [super init]) {
		self.interpolationContexts = [NSMutableArray new];
	}
	
	return self;
}

- (void)performInterpolations {
	for (PSInterpolationContext *ic in self.interpolationContexts) {
		float timeFraction = Fraction(ic.interpolation.startTime, ic.interpolation.endTime, self.time);
		timeFraction = MAX(0, timeFraction);
		timeFraction = MIN(1, timeFraction);
		
		if ((ic.interpolation.startTime <= self.time && self.time <= ic.interpolation.endTime) || (ic.timeFraction != 1 && ic.timeFraction != 0)) {
			id value = [ic.interpolation valueForTimeFraction:timeFraction];
			[ic.object setValue:value forKeyPath:ic.keyPath];
			ic.timeFraction = timeFraction;
		}
	}
}

- (void)setTime:(float)time {
	_time = time;
	[self performInterpolations];
}

- (void)addInterpolations:(id)interpolations forObjects:(id)objects keyPath:(NSString *)keyPath {
	safeFor(objects, ^void(id object) {
		safeFor(interpolations, ^void(PSInterpolation *interpolation) {
			interpolation.fromValue = interpolation.fromValue ? interpolation.fromValue : [object valueForKey:keyPath];
			
			PSInterpolationContext *context = [PSInterpolationContext contextWithInterpolation:interpolation object:object keyPath:keyPath];
			[self.interpolationContexts addObject:context];
		});
	});
}

void safeFor(id arrayOrObject, void (^forBlock)(id object)) {
	if ([arrayOrObject isKindOfClass:[NSArray class]]) {
		for (id object in arrayOrObject) {
			forBlock(object);
		}
	} else {
		forBlock(arrayOrObject);
	}
}

- (void)removeAllInterpolations {
	[self.interpolationContexts removeAllObjects];
}

@end
