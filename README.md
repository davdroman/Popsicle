DRDynamicSlideShow
==================

A UIScrollView subclass to easily implement an amazing swiping interactive slide show, as IFTTT's.

[New Demo Video](https://vimeo.com/75693078)

No external frameworks or UIView subclasses for subviews needed. Just add a `DRDynamicSlideShow` to your view, and use `DRDynamicSlideShowEffect`'s to let the magic happen.

## How to use

Here's an super simple example of how to use `DRDynamicSlideShow`. You can check out the example app, too.

1. First, just need to add a `DRDynamicSlideShow` instance to your view.

2. Then, you can use the following method to add subviews to it on the page you want (you can simply use `addSubview:` as well):

		[dynamicSlideShow addSubview:coolSubview onPage:0];
	
3. Finally, you just need to add whatever effects you want to those subviews when the specified page is being swiped.

		[self.slideShow addDynamicEffect:[DRDynamicSlideShowEffect dynamicEffectWithSubview:coolSubview page:0 keyPath:@"alpha" toValue:@0 delay:0]];
	
	or

		[self.slideShow addDynamicEffect:[DRDynamicSlideShowEffect dynamicEffectWithSubview:coolSubview page:0 keyPath:@"alpha" fromValue:@0 toValue:@1 delay:0]];
	
Notice there are two methods for instantiating `DRDynamicSlideShowEffect`. If you want the subview to animate from the current state, just use `dynamicEffectWithSubview:page:keyPath:toValue:delay:`. Else, use `dynamicEffectWithSubview:page:keyPath:fromValue:toValue:delay:`.

So, as you can see, all we need for adding each effect is 1 line of code. Pretty amazing, isn't it? :)

## Known issues

- The animation used to go to next page by tapping the view does not consider `DRDynamicSlideShowEffect`'s `delay` property.

## LICENSE

You can use it for whatever you want, however you want. I just would love to know if you're using it in any project of yours.