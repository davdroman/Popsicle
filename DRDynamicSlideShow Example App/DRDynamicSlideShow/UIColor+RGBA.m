//
//  UIColor+RGBA.m
//  DRDynamicSlideShow
//
//  Created by David Román Aguirre on 17/09/13.
//  Copyright (c) 2013 David Román Aguirre. All rights reserved.
//

#import "UIColor+RGBA.h"

@implementation UIColor (RGBA)

+ (UIColor *)colorWithAbsoluteRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    CGFloat r = red/255.0f;
    CGFloat g = green/255.0f;
    CGFloat b = blue/255.0f;
    
    UIColor * color = [[UIColor alloc] initWithRed:r green:g blue:b alpha:alpha];
    
    return color;
}

@end