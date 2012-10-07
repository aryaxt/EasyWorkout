//
//  AddWrokoutRoutineViewController.h
//  iWorkout
//
//  Created by Aryan Gh on 9/30/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "WorkoutRoutine.h"
#import "Workout.h"

@interface AddWrokoutRoutineViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) NSArray *workouts;
@property (nonatomic, strong) IBOutlet UITextField *txtRoutineName;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

- (IBAction)addSelected:(id)sender;
- (IBAction)cancelSelected:(id)sender;

@end
