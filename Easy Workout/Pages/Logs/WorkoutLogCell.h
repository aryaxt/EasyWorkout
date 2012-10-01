//
//  WorkoutLogCell.h
//  iWorkout
//
//  Created by Aryan Gh on 9/30/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import	"WorkoutLog.h"
#import	"Workout.h"

@interface WorkoutLogCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *lblWorkoutName;
@property (nonatomic, strong) IBOutlet UILabel *lblReps;
@property (nonatomic, strong) IBOutlet UILabel *lblWeight;
@property (nonatomic, strong) IBOutlet UIView *bottomView;

- (void)setWorkoutLog:(WorkoutLog *)log;

@end
