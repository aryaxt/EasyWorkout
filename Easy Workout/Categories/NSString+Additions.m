//
//  NSString+Additions.m
//  iWorkout
//
//  Created by Aryan Gh on 9/30/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

- (BOOL)isInteger
{
	NSScanner *scanner = [NSScanner scannerWithString:self];
    int the_value;
	
    if ([scanner scanInt:&the_value])
    {
		return [scanner isAtEnd];
    }

	return NO;
}

- (BOOL)isFloat
{
	NSScanner *scanner = [NSScanner scannerWithString:self];
    float the_value;
	
    if ([scanner scanFloat:&the_value])
    {
		return [scanner isAtEnd];
    }
	
	return NO;
}

@end
