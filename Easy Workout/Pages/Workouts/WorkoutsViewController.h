//
//  WorkoutsViewController.h
//  iWorkout
//
//  Created by Aryan Gh on 9/29/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Workout.h"
#import "WorkoutCategory.h"
#import "CellExpandableHeaderView.h"

@interface WorkoutsViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, CellExpandableHeaderViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *workoutCategories;
@property (nonatomic, strong) NSMutableDictionary *workoutsDictionary;
@property (nonatomic, strong) NSMutableArray *expandedSections;

@end
