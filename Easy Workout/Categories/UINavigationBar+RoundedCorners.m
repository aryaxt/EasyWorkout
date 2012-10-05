//
//  UINavigationBar+RoundedCorners.m
//  Easy Workout
//
//  Created by Aryan Gh on 10/3/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import "UINavigationBar+RoundedCorners.h"

@implementation UINavigationBar (RoundedCorners)

NSInteger ind = 0;

- (void)awakeFromNib
{	
	CALayer *capa = self.layer;
	[capa setShadowColor: [[UIColor blackColor] CGColor]];
	[capa setShadowOpacity:0.85f];
	[capa setShadowOffset: CGSizeMake(0.0f, 1.5f)];
	[capa setShadowRadius:4.0f];
	[capa setShouldRasterize:YES];
	[capa setRasterizationScale:[UIScreen mainScreen].scale];
	
	CGRect bounds = capa.bounds;
	bounds.size.height += 10.0f;
	UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds
												   byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
														 cornerRadii:CGSizeMake(7.0, 7.0)];
	
	CAShapeLayer *maskLayer = [CAShapeLayer layer];
	maskLayer.frame = bounds;
	maskLayer.path = maskPath.CGPath;
	
	[capa addSublayer:maskLayer];
	ind = [self.layer.sublayers indexOfObject:maskLayer];
	capa.mask = maskLayer;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	CAShapeLayer *layer = [self.layer.sublayers objectAtIndex:ind];
	
	CGRect bounds = self.layer.bounds;
	bounds.size.height += 10.0f;
	UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds
												   byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
														 cornerRadii:CGSizeMake(7.0, 7.0)];
	layer.path = maskPath.CGPath;
}


@end
