//
//  UIViewController+Additions.m
//  iWorkout
//
//  Created by Aryan Gh on 9/30/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import "UIViewController+Additions.h"

@implementation UIViewController (Additions)

- (id)initFromStoryboard
{
	UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
	self = [storyBoard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
	return self;
}

@end
