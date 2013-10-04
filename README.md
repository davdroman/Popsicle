DRDynamicSlideShow
==================

A UIScrollView subclass to easily implement an amazing swiping interactive slide show, as IFTTT's.

[New Demo Video](https://vimeo.com/75693078)

No external frameworks or UIView subclasses for subviews needed. Just add a `DRDynamicSlideShow` to your view, and use `DRDynamicSlideShowEffect`'s to let the magic happen.

## How to use

Here's an super simple example of how to use `DRDynamicSlideShow`. You can check out the example app, too.

First, you need to simply instantiate `DRDynamicSlideShow` like this:

	DRDynamicSlideShow * dynamicSlideShow = [[DRDynamicSlideShow alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
	
	[self.view addSubview:dynamicSlideShow];

Then, you need to add some views to it.

	UIView * blueSquare = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
	[blueSquare setBackgroundColor:[UIColor blueColor]];
	
	[dynamicSlideShow addSubview:blueSquare onPage:0]; // You can also use addSubview:, but keep in mind that addSubview:onPage: is just simpler so you don't need to worry about calculating more than necessary.
	
	UIView * orangeSquare = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
	[orangeSquare setBackgroundColor:[UIColor orangeColor]];
	
	[dynamicSlideShow addSubview:orangeSquare onPage:1];
	
And finally you just need to add the effects you want to those subviews when the specified page is being dragged.

	[self.slideShow addDynamicEffect:[DRDynamicSlideShowEffect dynamicEffectWithSubview:blueSquare page:0 keyPath:@"alpha" toValue:@0 delay:0]];
	
	[self.slideShow addDynamicEffect:[DRDynamicSlideShowEffect dynamicEffectWithSubview:orangeSquare page:0 keyPath:@"alpha" fromValue:@0 toValue:@1 delay:0]];
	
Notice that there are two methods for instantiating a `DRDynamicSlideShowEffect`. If you use the one that does not include the `fromValue` parameter, `fromValue` will be that subview's current value.

So, as you can see, all we need to add each effect is 1 line of code. Pretty amazing, isn't it? :)

## Known issues

- The animation used to go to next page by tapping the view does not consider `DRDynamicSlideShowEffect`'s `delay` property.

## LICENSE

You can use it for whatever you want, however you want. I just would love to know if you're using it in any project of yours.