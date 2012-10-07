//
//  AddWorkoutLogViewController.h
//  iWorkout
//
//  Created by Aryan Gh on 9/30/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Workout.h"
#import "WorkoutRoutine.h"

@protocol AddWorkoutLogViewControllerDelegate <NSObject>
- (void)addWorkoutLogViewControllerDidSelectWorkouts:(NSArray *)workouts;
@end

@interface AddWorkoutLogViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id <AddWorkoutLogViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray *workoutRoutines;
@property (nonatomic, strong) NSArray *workouts;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

- (IBAction)addSelected:(id)sender;
- (IBAction)cancelSelected:(id)sender;

@end
