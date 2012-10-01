//
//  WorkoutCategory.h
//  iWorkout
//
//  Created by Aryan Gh on 9/29/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CoreDataModel.h"

@class Workout;

@interface WorkoutCategory : CoreDataModel

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *workout;

@end
