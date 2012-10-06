//
//  WorkoutGroupsViewController.h
//  iWorkout
//
//  Created by Aryan Gh on 9/30/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "WorkoutGroup.h"
#import "Workout.h"
#import "CellExpandableHeaderView.h"

@interface WorkoutGroupsViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, CellExpandableHeaderViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableDictionary *workoutGroupsDictionary;
@property (nonatomic, strong) NSArray *workoutGroups;
@property (nonatomic, strong) NSMutableArray *expandedSections;
@property (nonatomic, strong) IBOutlet UITableView *tableView;


@end
