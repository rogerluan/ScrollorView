//
//  ScrollorView.m
//  MessingWithScrollView
//
//  Created by Roger Oba on 11/6/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "ScrollorView.h"

@interface UIScrollView() <UIScrollViewDelegate>


/**
 *  Contains all the colors that the scroll view should use, including the colros before the first page, and after the last one.
 */
@property (strong,nonatomic) NSArray *privateColors;


@end

@implementation ScrollorView

@synthesize colors = _colors;
@synthesize privateColors = _privateColors;

- (void) awakeFromNib {
	[self commomSetup];
}

- (instancetype) initWithColors:(NSArray*)colors {
	if ((self = [super init]) == nil) { return nil; }

	[self commomSetup];
	
	NSMutableArray *allColors = [colors mutableCopy];
	[allColors insertObject:[UIColor blackColor] atIndex:colors.count];
	[allColors insertObject:[UIColor blackColor] atIndex:0];
	self.privateColors = [allColors copy];
	_colors = colors;
	
	self.backgroundColor = [colors firstObject];
	self.contentSize = CGSizeMake(self.frame.size.width*colors.count,self.frame.size.height);
	
	return self;
}

/**
 *  @author Roger Oba
 *
 *  Setup the scroll view with information that's commom between interface builder and programmatic creations.
 */
- (void) commomSetup {
	self.delegate = self;
	self.pagingEnabled = YES;
	self.showsVerticalScrollIndicator = NO;
	self.showsHorizontalScrollIndicator = NO;
	
	[self registerForOrientationChanges];
}

/**
 *  @author Roger Oba
 *
 *  Registers this class as an observer to listen to device orientation changes.
 */
- (void) registerForOrientationChanges {
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(orientationDidChange)
												 name:UIDeviceOrientationDidChangeNotification
											   object:nil];
}

/**
 *  @author Roger Oba
 *
 *  Notifies a device orientation change.
 */
- (void) orientationDidChange {
	[self layoutIfNeeded];
	self.contentSize = CGSizeMake(self.frame.size.width*self.colors.count,self.frame.size.height);
}

#pragma mark - Setters -

- (void) setFirstColor:(UIColor*)firstColor lastColor:(UIColor*)lastColor {
	NSMutableArray *newArray = [self.privateColors mutableCopy];
	[newArray replaceObjectAtIndex:newArray.count-1 withObject:lastColor];
	[newArray replaceObjectAtIndex:0 withObject:firstColor];
}

- (void) setColors:(NSArray *)colors {

	[self layoutIfNeeded];
	
	self.backgroundColor = [colors firstObject];
	self.contentSize = CGSizeMake(self.frame.size.width*colors.count,self.frame.size.height);
	
	NSMutableArray *allColors = [colors mutableCopy];
	[allColors insertObject:[UIColor blackColor] atIndex:colors.count];
	[allColors insertObject:[UIColor blackColor] atIndex:0];

	_privateColors = [allColors copy];
	_colors = colors;
}

#pragma mark - UIScrollView Delegate Method -

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
	NSLog(@"offset: %f",scrollView.contentOffset.x);
	self.backgroundColor = [self dynamicBackgroundColorForScrollView:scrollView];
}

/**
 *  @author Roger Oba
 *
 *  Calculates the color that the scroll view should be at a given content offset.
 *
 *  @param scrollView ScrollView which will provide the content offset.
 *
 *  @return Returns the current color of the scroll view.
 */
- (UIColor*) dynamicBackgroundColorForScrollView:(UIScrollView*)scrollView {
	
	CGFloat firstColorRedComponent = 0.0;
	CGFloat firstColorGreenComponent = 0.0;
	CGFloat firstColorBlueComponent = 0.0;
	CGFloat firstColorAlphaComponent =0.0;
	
	CGFloat secondColorRedComponent = 0.0;
	CGFloat secondColorGreenComponent = 0.0;
	CGFloat secondColorBlueComponent = 0.0;
	CGFloat secondColorAlphaComponent = 0.0;
	
	CGFloat percentage = 1/(scrollView.frame.size.width/scrollView.contentOffset.x);
	
	NSInteger firstColorIndex = floor(percentage);
	NSInteger secondColorIndex = ceil(percentage);
	
	[[self.privateColors objectAtIndex:firstColorIndex+1] getRed:&firstColorRedComponent green:&firstColorGreenComponent blue:&firstColorBlueComponent alpha:&firstColorAlphaComponent];
	[[self.privateColors objectAtIndex:secondColorIndex+1] getRed:&secondColorRedComponent green:&secondColorGreenComponent blue:&secondColorBlueComponent alpha:&secondColorAlphaComponent];
	
	while (percentage > 1) {
		percentage--;
	}
	
	CGFloat finalColorRedComponent = [self finalColorComponentFromComponent:firstColorRedComponent component:secondColorRedComponent percentage:percentage];
	CGFloat finalColorGreenComponent = [self finalColorComponentFromComponent:firstColorGreenComponent component:secondColorGreenComponent percentage:percentage];
	CGFloat finalColorBlueComponent = [self finalColorComponentFromComponent:firstColorBlueComponent component:secondColorBlueComponent percentage:percentage];
	CGFloat finalColorAlphaComponent = [self finalColorComponentFromComponent:firstColorAlphaComponent component:secondColorAlphaComponent percentage:percentage];
	
//	NSLog(@"Index: %.2f%% firstComp:%f secondComp:%f finalComp:%f offset: %f || %.f/%.f=%.f",percentage*100,firstColorRedComponent,secondColorRedComponent,finalColorRedComponent,scrollView.contentOffset.x,scrollView.frame.size.width,scrollView.contentOffset.x,percentage);
	
	return [UIColor colorWithRed:finalColorRedComponent	green:finalColorGreenComponent blue:finalColorBlueComponent alpha:finalColorAlphaComponent];
}

#pragma mark - Helpers

/**
 *  @author Roger Oba
 *
 *  Helper method to determine the value of the final color component. Color components here may be the red, green, blue or alpha components.
 *
 *  @param firstColor  The color component value of the first color
 *  @param secondColor The color component value of the second color
 *  @param percentage  Percentage of the scroll view that have already been scrolled.
 *
 *  @return Returns the value of the final color component.
 */
- (CGFloat) finalColorComponentFromComponent:(CGFloat)firstColor component:(CGFloat)secondColor percentage:(CGFloat)percentage {
	return (percentage>=0) ?
	fabs(((firstColor-secondColor)*percentage)-firstColor) :
	fabs(((secondColor-firstColor)*percentage)+secondColor);
}

@end
