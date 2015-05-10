//
//  PSInterpolationContext.h
//  Popsicle
//
//  Created by David Román Aguirre on 10/5/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PSInterpolation;

@interface PSInterpolationContext : NSObject

@property (nonatomic, strong) PSInterpolation *interpolation;
@property (nonatomic, weak) id object;
@property (nonatomic, strong) NSString *keyPath;
@property (nonatomic) float timeFraction;

+ (instancetype)contextWithInterpolation:(PSInterpolation *)interpolation object:(id)object keyPath:(NSString *)keyPath;

@end
