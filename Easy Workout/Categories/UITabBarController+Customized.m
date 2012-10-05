//
//  UITabBarController+Customized.m
//  Easy Workout
//
//  Created by Aryan Gh on 10/4/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import "UITabBarController+Customized.h"

@implementation UITabBarController (Customized)

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	//[self addCenterButtonWithImage:[UIImage imageNamed:@"tabBar_cameraButton_ready_matte.png"] highlightImage:[UIImage imageNamed:@"tabBar_cameraButton_ready_matte.png"]];
}

// Create a custom UIButton and add it to the center of our tab bar
-(void) addCenterButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage
{
	UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
	button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
	[button setBackgroundImage:buttonImage forState:UIControlStateNormal];
	[button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
	
	CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
	if (heightDifference < 0)
		button.center = self.tabBar.center;
	else
	{
		CGPoint center = self.tabBar.center;
		center.y = center.y - heightDifference/2.0;
		button.center = center;
	}
	
	[self.view addSubview:button];
}

@end
