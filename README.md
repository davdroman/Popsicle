DRDynamicSlideShow
==================
Create beautiful, animated, paging UIScrollViews.  Easily animate views as the UIScrollView gets paged. This is perfect for welcome screens and introduction views in iOS apps.

<p align="center">
	<img src="https://raw.github.com/Dromaguirre/DRDynamicSlideShow/images/1.gif" alt="DRDynamicSlideShow" title="DRDynamicSlideShow" width="320px" />
</p>

## Features  
- **1 line** of code per animation.
- **Any type of value** can be animated.
- **Block-driven**.

## Installation
There are two ways to install  DRDynamicSlideShow. The first (and preferred / recommended) method is through CocoaPods. If you prefer to do it the classic way, see instructions for manual install below.

### CocoaPods Install
You can install DRDynamicSlideShow through CocoaPods by adding the following to your Podfile:

	pod 'DRDynamicSlideShow'

### Manual Install
You can add DRDynamicSlideShow to your project by copying `DRDynamicSlideShow.h` and `DRDynamicSlideShow.m`. Ensure that they are *copied* into the project. Note, installing with this method will not keep DRDynamicSlideShow updated (you'll need to check GitHub).

## Usage
Using DRDynamicSlideShow is easy. There are two ways to use it - either set it up programatically or with an interface. The demo project demonstrates setup with a Storyboard.

1. Add a `DRDynamicSlideShow` instance to your view.  
2. Use the following method to **add subviews** to it on the page you want (you can simply use `addSubview:` as well):

		[self.slideShow addSubview:coolSubview onPage:0];
		
3. Just need **add whatever animation you want** it to perform for those subviews when the specified page is being swiped.  

		[self.slideShow addAnimation:[DRDynamicSlideShowAnimation animationForSubview:coolSubview page:0 keyPath:@"alpha" toValue:@0 delay:0]];
	
	OR

		[self.slideShow addAnimation:[DRDynamicSlideShowAnimation animationForSubview:coolSubview page:0 keyPath:@"alpha" fromValue:@0 toValue:@1 delay:0]];

Notice there are two ways for instantiating `DRDynamicSlideShowAnimation`. If you want the subview to animate **from its current value**, just use `animationForSubview:page:keyPath:toValue:delay:`. Otherwise, use `animationForSubview:page:keyPath:fromValue:toValue:delay:`.

As you can see, all we need for adding each animation is just **1 line of code**! Pretty amazing, isn't it? :)

## Requirements  
- Optimized for iOS 7 SDK and higher  
- Built for iOS 6 SDK or higher  
- Uses Objective-C ARC

## License  
DRDynamicSlideShow is available under the [**MIT license**](https://github.com/Dromaguirre/DRDynamicSlideShow/blob/master/LICENSE). Also, I'd really love to know  if you are using DRDynamicSlideShow in any of your projects, so send me an [**email**](mailto:dromaguirre@gmail.com) or a [**tweet**](http://twitter.com/Dromaguirre) and make my day :)

## To-do
- Use [**DRPaginatedScrollView**](http://github.com/Dromaguirre/DRPaginatedScrollView)'s base.
