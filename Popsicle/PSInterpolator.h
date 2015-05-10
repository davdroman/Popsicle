//
//  PSInterpolator.h
//  Popsicle
//
//  Created by David Román Aguirre on 27/10/14.
//  Copyright (c) 2014 David Roman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSInterpolator : NSObject

@property (nonatomic, assign) float time;

- (void)addInterpolations:(id)interpolations forObjects:(id)objects keyPath:(NSString *)keyPath;

@end
