//
//  CoreDataModel.h
//  iWorkout
//
//  Created by Aryan Gh on 9/29/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CoreDataManager.h"

@interface CoreDataModel : NSManagedObject

+ (id)getInstance;
+ (NSArray *)getInstancesWithPredicate:(NSPredicate *)predicate;
+ (NSArray *)getInstancesWithPredicate:(NSPredicate *)predicate
					 andSortDescriptor:(NSSortDescriptor *)sortDescriptor;
+ (NSArray *)getInstancesWithPredicate:(NSPredicate *)predicate
					 sortDescriptor:(NSSortDescriptor *)sortDescriptor
							  andLimit:(NSInteger)limit;
- (void)delete;

@end
