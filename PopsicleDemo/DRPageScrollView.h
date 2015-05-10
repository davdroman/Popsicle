//
//  DRPageScrollView.h
//  DRPageScrollView
//
//  Created by David Román Aguirre on 3/4/15.
//  Copyright (c) 2015 David Román Aguirre. All rights reserved.
//

#import <UIKit/UIKit.h>

/// The type of block used to define what to display on each page view.
typedef void(^DRPageHandlerBlock)(UIView *pageView);

@interface DRPageScrollView : UIScrollView

/// Determines whether page views are reused or not in order to reduce memory consumption.
@property (nonatomic, getter=isPageReuseEnabled) BOOL pageReuseEnabled;

/// The current page index (starting from 0).
@property (nonatomic, assign) NSInteger currentPage;

/// The total number of pages in the scroll view.
@property (nonatomic, readonly) NSInteger numberOfPages;

/**
 * Sets up a new page for the scroll view.
 *
 * @param handler A block that defines what to display on the page.
**/
- (void)addPageWithHandler:(DRPageHandlerBlock)handler;

@end
