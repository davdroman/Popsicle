//
//  UIView+Utils.h
//  Popsicle
//
//  Created by David Román Aguirre on 9/5/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Utils)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

- (void)pinToSuperviewEdges;

+ (NSDictionary *)nibViewsByClassWithNibName:(NSString *)nibName;

@end
