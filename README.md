DRDynamicSlideShow
==================

<br />

<p align="center">
	<img src="https://raw.github.com/Dromaguirre/DRDynamicSlideShow/images/1.gif" alt="DRDynamicSlideShow" title="DRDynamicSlideShow" width="320px" />
</p>

## Features

- **1 line** of code per animation.
- **Any type of value** can be animated.
- **Block-driven**.

## CocoaPods

You can install DRDynamicSlideShow through CocoaPods adding the following to your Podfile:

	pod 'DRDynamicSlideShow'

## At a glance

1. First, add a `DRDynamicSlideShow` instance to your view.

2. Then, you can use the following method to **add subviews** to it on the page you want (you can simply use `addSubview:` as well):

		[self.slideShow addSubview:coolSubview onPage:0];
		
3. Finally, you just need to **add whatever animation you want** it to perform for those subviews when the specified page is being swiped.

		[self.slideShow addAnimation:[DRDynamicSlideShowAnimation animationForSubview:coolSubview page:0 keyPath:@"alpha" toValue:@0 delay:0]];
	
	or

		[self.slideShow addAnimation:[DRDynamicSlideShowAnimation animationForSubview:coolSubview page:0 keyPath:@"alpha" fromValue:@0 toValue:@1 delay:0]];

Notice there are two ways for instantiating `DRDynamicSlideShowAnimation`. If you want the subview to animate **from its current value**, just use `animationForSubview:page:keyPath:toValue:delay:`. Else, use `animationForSubview:page:keyPath:fromValue:toValue:delay:`.

As you can see, all we need for adding each animation is just **1 line of code**! Pretty amazing, isn't it? :)

## Wish list

- Use [**DRPaginatedScrollView**](http://github.com/Dromaguirre/DRPaginatedScrollView)'s base.

## Requirements

- iOS 6 or higher.

## License

DRDynamicSlideShow is available under the MIT license.

Also, I'd really love to know you're using it in any of your projects, so send me an [**email**](mailto:dromaguirre@gmail.com) or a [**tweet**](http://twitter.com/Dromaguirre) and make my day :)