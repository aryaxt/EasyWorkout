//
//  CoreDataModel.m
//  iWorkout
//
//  Created by Aryan Gh on 9/29/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import "CoreDataModel.h"

@implementation CoreDataModel

+ (id)getInstance
{
	return [[CoreDataManager sharedManager] getInstanceForEntity:NSStringFromClass([self class])];
}

+ (NSArray *)getInstancesWithPredicate:(NSPredicate *)predicate
{
	return [[CoreDataManager sharedManager] getInstancesWithEntity:NSStringFromClass([self class])
													  andPredicate:predicate];
}

- (void)delete
{
	[[CoreDataManager sharedManager] deleteManageObject:self];
}

@end
