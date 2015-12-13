//
//  ScrollorView.h
//  MessingWithScrollView
//
//  Created by Roger Oba on 11/6/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollorView : UIScrollView

/**
 *  @author Roger Oba
 *
 *  Contains an array of all the colors that the user should see, from the first page to the last one.
 */
@property (strong,nonatomic) NSArray *colors;

/**
 *  @author Roger Oba
 *
 *  Initializer to create the scroll view programmatically. The number of colors will be the number of pages that the scroll view will have.
 *
 *  @param colors Array containing all the colors that the user should see, from the first page to the last one.
 *
 *  @return Returns an instance of ScrollorView.
 */
- (instancetype) initWithColors:(NSArray*)colors;

/**
 *  @author Roger Oba
 *
 *  Setter method to customize the colors before the first page, and after the last one. This method is optional and the default colors are black.
 *
 *  @param firstColor Color that should fade before the first page.
 *  @param lastColor  Color that should fade after the last page.
 */
- (void) setFirstColor:(UIColor*)firstColor lastColor:(UIColor*)lastColor;

@end
