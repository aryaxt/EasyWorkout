//
//  WorkoutLogCell.m
//  iWorkout
//
//  Created by Aryan Gh on 9/30/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import "WorkoutLogCell.h"

@implementation WorkoutLogCell
@synthesize lblReps = _lblReps;
@synthesize lblWeight = _lblWeight;
@synthesize lblWorkoutName = _lblWorkoutName;
@synthesize bottomView = _bottomView;

- (void)setWorkoutLog:(WorkoutLog *)log
{
	self.lblWorkoutName.text = log.workout.name;
	self.lblWeight.text = [NSString stringWithFormat:@"%@", log.weight];
	self.lblReps.text = [NSString stringWithFormat:@"%@", log.reps];
	self.accessoryType = (log.completed.boolValue) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

@end
