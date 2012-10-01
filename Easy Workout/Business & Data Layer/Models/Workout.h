//
//  Workout.h
//  iWorkout
//
//  Created by Aryan Gh on 9/29/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CoreDataModel.h"

@class WorkoutCategory, WorkoutGroup, WorkoutLog;

@interface Workout : CoreDataModel

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) WorkoutCategory *category;
@property (nonatomic, retain) NSSet *workoutLog;
@property (nonatomic, retain) NSSet *workoutGroup;

@end
