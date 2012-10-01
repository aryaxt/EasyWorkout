//
//  CoreDataManager.h
//  iWorkout
//
//  Created by Aryan Gh on 9/29/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

+ (CoreDataManager *)sharedManager;
- (id)getInstanceForEntity:(NSString *)entity;
- (NSArray *)getInstancesWithEntity:(NSString *)entity andPredicate:(NSPredicate *)predicate;
- (id)getInstanceWithEntity:(NSString *)entity andPredicate:(NSPredicate *)predicate;
- (void)deleteManageObject:(id)object;
- (void)saveContext;

@end
