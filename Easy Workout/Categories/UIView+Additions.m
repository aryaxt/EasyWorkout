//
//  UIView+Additions.m
//  Easy Workout
//
//  Created by Aryan Gh on 10/2/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import "UIView+Additions.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@implementation UIView (Additions)

- (void)rotateToDegree:(CGFloat)degree animated:(BOOL)animated
{
	[UIView animateWithDuration:(animated) ? .3 : 0 animations:^{
		CGAffineTransform rotationTransform =  CGAffineTransformRotate(self.transform, DEGREES_TO_RADIANS(degree));
		self.transform = rotationTransform;
	}];
}

@end
