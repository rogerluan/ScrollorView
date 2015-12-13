//
//  ScrollViewController.m
//  MessingWithScrollView
//
//  Created by Roger Oba on 11/6/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "ScrollViewController.h"
#import "ScrollorView.h"

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self configureScrollView];
}

#pragma mark - Setup - 

/**
 *  @author Roger Oba
 *
 *  Configures the ScrollorView to display colors.
 */
- (void) configureScrollView {
	
	UIColor *firstPageColor = [UIColor colorWithRed:0.497 green:0.649 blue:0.000 alpha:1.000];
	UIColor *secondPageColor = [UIColor colorWithRed:0.194 green:0.509 blue:0.852 alpha:1.000];
	UIColor *thirdPageColor = [UIColor colorWithRed:0.984 green:0.780 blue:0.000 alpha:1.000];
	UIColor *fourthPageColor = [UIColor colorWithRed:0.765 green:0.258 blue:0.568 alpha:1.000];
	UIColor *fifthPageColor = [UIColor colorWithRed:0.976 green:0.604 blue:0.000 alpha:1.000];
	
	self.scrollView.colors = @[firstPageColor,secondPageColor,thirdPageColor,fourthPageColor,fifthPageColor];
}

@end
