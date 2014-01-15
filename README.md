DRDynamicSlideShow
==================

A UIScrollView subclass to easily implement an amazing swiping interactive slide show, as IFTTT's.

<p align="center">
	<img src="https://raw.github.com/Dromaguirre/DRDynamicSlideShow/images/1.gif" alt="DRDynamicSlideShow GIF" title="DRDynamicSlideShow GIF" />
</p>

No external frameworks or subclasses for subviews needed. Just add a `DRDynamicSlideShow` to your view, and add `DRDynamicSlideShowAnimation`'s to it to let the magic happen.

## How to use

Here's an super simple example of how to use `DRDynamicSlideShow`. You can check out the **example app**, too.

1. First, add a `DRDynamicSlideShow` instance to your view.

2. Then, you can use the following method to **add subviews** to it on the page you want (you can simply use `addSubview:` as well):

		[self.slideShow addSubview:coolSubview onPage:0];
		
3. Finally, you just need to **add whatever animation you want** it to perform for those subviews when the specified page is being swiped.

		[self.slideShow addAnimation:[DRDynamicSlideShowAnimation animationForSubview:coolSubview page:0 keyPath:@"alpha" toValue:@0 delay:0]];
	
	or

		[self.slideShow addAnimation:[DRDynamicSlideShowAnimation animationForSubview:coolSubview page:0 keyPath:@"alpha" fromValue:@0 toValue:@1 delay:0]];

Notice there are two ways for instantiating `DRDynamicSlideShowAnimation`. If you want the subview to animate **from its current value**, just use `animationForSubview:page:keyPath:toValue:delay:`. Else, use `animationForSubview:page:keyPath:fromValue:toValue:delay:`.

As you can see, all we need for adding each animation is just **1 line of code**! Pretty amazing, isn't it? :)

## Known issues

- The animation used to go to next page by tapping the view does not consider `DRDynamicSlideShowAnimation`'s `delay` property.

## License

DRDynamicSlideShow is available under the MIT license.

Also, I'd really love to know you're using it in any of your projects, so send me an [**email**](mailto:dromaguirre@gmail.com) or a [**tweet**](http://twitter.com/Dromaguirre) and make my day :)
