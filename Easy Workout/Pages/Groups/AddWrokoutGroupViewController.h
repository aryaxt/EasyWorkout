//
//  AddWrokoutGroupViewController.h
//  iWorkout
//
//  Created by Aryan Gh on 9/30/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "WorkoutGroup.h"
#import "Workout.h"

@interface AddWrokoutGroupViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) NSArray *workouts;
@property (nonatomic, strong) IBOutlet UITextField *txtGroupName;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

- (IBAction)addSelected:(id)sender;
- (IBAction)cancelSelected:(id)sender;

@end
