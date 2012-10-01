//
//  WorkoutLog.h
//  iWorkout
//
//  Created by Aryan Gh on 9/29/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CoreDataModel.h"

@class Workout;

@interface WorkoutLog : CoreDataModel

@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSNumber *weight;
@property (nonatomic, retain) NSNumber *reps;
@property (nonatomic, retain) NSNumber *completed;
@property (nonatomic, retain) Workout *workout;

@end
