//
//  DRDynamicSlideShow.m
//  DRDynamicSlideShow
//
//  Created by David Román Aguirre on 17/09/13.
//  Copyright (c) 2013 David Román Aguirre. All rights reserved.
//

#import "DRDynamicSlideShow.h"

typedef enum {
    DRDynamicSlideShowEffectValueTypeCGFloat = 0,
    DRDynamicSlideShowEffectValueTypeCGPoint = 1,
    DRDynamicSlideShowEffectValueTypeCGSize = 2,
    DRDynamicSlideShowEffectValueTypeCGRect = 3,
    DRDynamicSlideShowEffectValueTypeCGAffineTransform = 4,
    DRDynamicSlideShowEffectValueTypeUIColor = 5,
} DRDynamicSlideShowEffectValueType;

#pragma mark Interfaces Extensions

@interface DRDynamicSlideShow ()

@property (readwrite, nonatomic) NSInteger numberOfPages;

@end

@interface DRDynamicSlideShowEffect ()

@property (nonatomic) DRDynamicSlideShowEffectValueType valueType;

@end

#pragma mark Implementations

@implementation DRDynamicSlideShowEffect

- (id)initWithSubview:(UIView *)subview page:(NSInteger)page keyPath:(NSString *)keyPath toValue:(id)toValue {
    if (self = [super init]) {
        [self setSubview:subview];
        [self setPage:page];
        [self setKeyPath:keyPath];
        [self setFromValue:[subview valueForKeyPath:keyPath]];
        [self setToValue:toValue];
        [self setValueType:[self effectValueDataType]];
    }
    
    return self;
}

- (id)initWithSubview:(UIView *)subview page:(NSInteger)page keyPath:(NSString *)keyPath fromValue:(id)fromValue toValue:(id)toValue {
    if (self = [super init]) {
        [self setSubview:subview];
        [self setPage:page];
        [self setKeyPath:keyPath];
        [self setFromValue:fromValue];
        [self setToValue:toValue];
        [self setValueType:[self effectValueDataType]];
    }
    
    return self;
}

- (DRDynamicSlideShowEffectValueType)effectValueDataType {
    DRDynamicSlideShowEffectValueType valueDataType = 0;
    
    if ([self.fromValue isKindOfClass:NSClassFromString(@"NSNumber")]) {
        if ([self valueTypeIsEqualTo:@encode(CGFloat)]) {
            valueDataType = DRDynamicSlideShowEffectValueTypeCGFloat;
        }
    } else if ([self.fromValue isKindOfClass:NSClassFromString(@"NSValue")]) {
        if ([self valueTypeIsEqualTo:@encode(CGPoint)]) {
            valueDataType = DRDynamicSlideShowEffectValueTypeCGPoint;
        } else if ([self valueTypeIsEqualTo:@encode(CGSize)]) {
            valueDataType = DRDynamicSlideShowEffectValueTypeCGSize;
        } else if ([self valueTypeIsEqualTo:@encode(CGRect)]) {
            valueDataType = DRDynamicSlideShowEffectValueTypeCGRect;
        } else if ([self valueTypeIsEqualTo:@encode(CGAffineTransform)]) {
            valueDataType = DRDynamicSlideShowEffectValueTypeCGAffineTransform;
        }
    } else {
        valueDataType = DRDynamicSlideShowEffectValueTypeUIColor;
    }
    
    return valueDataType;
}

- (BOOL)valueTypeIsEqualTo:(const char *)typeChar {
    NSString * valueDataTypeString = [[NSString alloc] initWithCString:[self.fromValue objCType] encoding:NSUTF8StringEncoding];
    
    NSString * comparationDataTypeString = [[NSString alloc] initWithCString:typeChar encoding:NSUTF8StringEncoding];
    
    if ([valueDataTypeString isEqualToString:comparationDataTypeString]) {
        return YES;
    }
    
    return NO;
}

- (void)performWithPercentage:(CGFloat)percentage {
    percentage = MAX((percentage-self.delay)/(1-self.delay), 0);
    
    switch (self.valueType) {
        case DRDynamicSlideShowEffectValueTypeCGFloat: {
            CGFloat newFloat = [self partialValueWithFromValue:[self.fromValue floatValue] toValue:[self.toValue floatValue] percentage:percentage];
            
            [self.subview setValue:@(newFloat) forKeyPath:self.keyPath];
        }
            break;
        case DRDynamicSlideShowEffectValueTypeCGPoint: {
            CGFloat newX = [self partialValueWithFromValue:[self.fromValue CGPointValue].x toValue:[self.toValue CGPointValue].x percentage:percentage];
            CGFloat newY = [self partialValueWithFromValue:[self.fromValue CGPointValue].y toValue:[self.toValue CGPointValue].y percentage:percentage];
            
            [self.subview setValue:[NSValue valueWithCGPoint:CGPointMake(newX, newY)] forKeyPath:self.keyPath];
        }
            break;
        case DRDynamicSlideShowEffectValueTypeCGSize: {
            CGFloat newWidth = [self partialValueWithFromValue:[self.fromValue CGSizeValue].width toValue:[self.toValue CGSizeValue].width percentage:percentage];
            CGFloat newHeight = [self partialValueWithFromValue:[self.fromValue CGSizeValue].height toValue:[self.toValue CGSizeValue].height percentage:percentage];
            
            [self.subview setValue:[NSValue valueWithCGSize:CGSizeMake(newWidth, newHeight)] forKeyPath:self.keyPath];
        }
            break;
        case DRDynamicSlideShowEffectValueTypeCGRect: {
            CGFloat newX = [self partialValueWithFromValue:[self.fromValue CGRectValue].origin.x toValue:[self.toValue CGRectValue].origin.x percentage:percentage];
            CGFloat newY = [self partialValueWithFromValue:[self.fromValue CGRectValue].origin.y toValue:[self.toValue CGRectValue].origin.y percentage:percentage];
            CGFloat newWidth = [self partialValueWithFromValue:[self.fromValue CGRectValue].size.width toValue:[self.toValue CGRectValue].size.width percentage:percentage];
            CGFloat newHeight = [self partialValueWithFromValue:[self.fromValue CGRectValue].size.height toValue:[self.toValue CGRectValue].size.height percentage:percentage];
            
            [self.subview setValue:[NSValue valueWithCGRect:CGRectMake(newX, newY, newWidth, newHeight)] forKeyPath:self.keyPath];
        }
            break;
        case DRDynamicSlideShowEffectValueTypeCGAffineTransform: {
            CGFloat newA = [self partialValueWithFromValue:[self.fromValue CGAffineTransformValue].a toValue:[self.toValue CGAffineTransformValue].a percentage:percentage];
            CGFloat newB = [self partialValueWithFromValue:[self.fromValue CGAffineTransformValue].b toValue:[self.toValue CGAffineTransformValue].b percentage:percentage];
            CGFloat newC = [self partialValueWithFromValue:[self.fromValue CGAffineTransformValue].c toValue:[self.toValue CGAffineTransformValue].c percentage:percentage];
            CGFloat newD = [self partialValueWithFromValue:[self.fromValue CGAffineTransformValue].d toValue:[self.toValue CGAffineTransformValue].d percentage:percentage];
            CGFloat newTx = [self partialValueWithFromValue:[self.fromValue CGAffineTransformValue].tx toValue:[self.toValue CGAffineTransformValue].tx percentage:percentage];
            CGFloat newTy = [self partialValueWithFromValue:[self.fromValue CGAffineTransformValue].ty toValue:[self.toValue CGAffineTransformValue].ty percentage:percentage];
            
            [self.subview setValue:[NSValue valueWithCGAffineTransform:CGAffineTransformMake(newA, newB, newC, newD, newTx, newTy)] forKeyPath:self.keyPath];
        }
            break;
        case DRDynamicSlideShowEffectValueTypeUIColor: {
            CGFloat fromR = 0;
            CGFloat fromG = 0;
            CGFloat fromB = 0;
            CGFloat fromA = 0;
            CGFloat toR = 0;
            CGFloat toG = 0;
            CGFloat toB = 0;
            CGFloat toA = 0;
            
            [(UIColor *)self.fromValue getRed:&fromR green:&fromG blue:&fromB alpha:&fromA];
            [(UIColor *)self.toValue getRed:&toR green:&toG blue:&toB alpha:&toA];
            
            CGFloat newR = [self partialValueWithFromValue:fromR toValue:toR percentage:percentage];
            CGFloat newG = [self partialValueWithFromValue:fromG toValue:toG percentage:percentage];
            CGFloat newB = [self partialValueWithFromValue:fromB toValue:toB percentage:percentage];
            CGFloat newA = [self partialValueWithFromValue:fromA toValue:toA percentage:percentage];
            
            UIColor * newColor = [[UIColor alloc] initWithRed:newR green:newG blue:newB alpha:newA];
            
            [self.subview setValue:newColor forKeyPath:self.keyPath];
        }
            break;
            
        default:
            break;
    }
}

- (CGFloat)partialValueWithFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue percentage:(CGFloat)percentage {
    return fromValue+(toValue-fromValue)*percentage;
}

@end

@implementation DRDynamicSlideShow

#pragma mark Basic Defined Methods

- (id)init {
    if (self = [super init]) {
        dynamicEffects = [NSMutableArray new];
        
        [self setDelegate:self];
        [self setPagingEnabled:YES];
        [self setShowsHorizontalScrollIndicator:NO];
        [self setShowsVerticalScrollIndicator:NO];
    }
    
    return self;
}

- (void)addDynamicEffect:(DRDynamicSlideShowEffect *)dynamicEffect {
    [dynamicEffects addObject:dynamicEffect];
}

- (void)addSubview:(UIView *)view {
    [super addSubview:view];
    
    if (view.frame.origin.x >= self.contentSize.width) {
        NSInteger numberOfPages = floorf(view.frame.origin.x/self.frame.size.width)+1;
        
        [self setNumberOfPages:numberOfPages];
        [self setContentSize:CGSizeMake(self.frame.size.width*self.numberOfPages, self.contentSize.height)];
    }
}

- (void)addSubview:(UIView *)view onPage:(NSInteger)page {
    [view setFrame:CGRectMake(view.frame.origin.x+self.frame.size.width*page, view.frame.origin.y, view.frame.size.width, view.frame.size.height)];
    [self addSubview:view];
}

#pragma mark Useful Methods

- (NSInteger)currentPage {
    NSInteger page = floor(self.contentOffset.x / self.frame.size.width);
    
    return page;
}

- (void)resetCurrentDynamicEffectsForPage:(NSInteger)page {
    currentDynamicEffects = [self dynamicEffectsForPage:page];
}

- (NSArray *)dynamicEffectsForPage:(NSInteger)page {
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"page == %i", page];
    NSArray * filteredEffects = [dynamicEffects filteredArrayUsingPredicate:predicate];
    
    return filteredEffects;
}

#pragma mark Scroll View Delegate Methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSInteger page = [self currentPage];
    
    [self resetCurrentDynamicEffectsForPage:page];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger page = [self currentPage];
    
    if (currentPage != page) {
        [self performCurrentDynamicEffectsWithPercentage:(currentPage < page ? 1 : 0)];
        currentPage = page;
        [self resetCurrentDynamicEffectsForPage:page];
        if (self.didReachPageBlock) self.didReachPageBlock(page);
    }
    
    CGFloat horizontalScroll = self.contentOffset.x-self.frame.size.width*currentPage;
    CGFloat percentage = horizontalScroll/self.frame.size.width;
    
    [self performCurrentDynamicEffectsWithPercentage:percentage];
}

- (void)performCurrentDynamicEffectsWithPercentage:(CGFloat)percentage {
    for (DRDynamicSlideShowEffect * dynamicEffect in currentDynamicEffects) {
        [dynamicEffect performWithPercentage:percentage];
    }
}

@end