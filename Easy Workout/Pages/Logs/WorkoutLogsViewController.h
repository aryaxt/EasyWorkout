//
//  WorkoutLogsViewController.h
//  iWorkout
//
//  Created by Aryan Gh on 9/30/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AddWorkoutLogViewController.h"
#import "WorkoutLog.h"
#import "WorkoutLogCell.h"
#import "WorkoutLogDetailViewController.h"
#import "UIViewController+Additions.h"

@interface WorkoutLogsViewController : BaseViewController <AddWorkoutLogViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, WorkoutLogDetailViewControllerDelegate>

@property (nonatomic, strong) WorkoutLogDetailViewController *logDetailViewContorller;
@property (nonatomic, strong) NSArray *logs;
@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
