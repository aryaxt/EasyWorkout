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

+ (NSArray *)getInstancesWithPredicate:(NSPredicate *)predicate andSortDescriptor:(NSSortDescriptor *)sortDescriptor
{
	return [[CoreDataManager sharedManager] getInstancesWithEntity:NSStringFromClass([self class])
													  predicate:predicate
												 andSortDescriptor:sortDescriptor];
}

+ (NSArray *)getInstancesWithPredicate:(NSPredicate *)predicate
{
	return [[self class] getInstancesWithPredicate:predicate andSortDescriptor:nil];
}

- (void)delete
{
	[[CoreDataManager sharedManager] deleteManageObject:self];
}

@end
