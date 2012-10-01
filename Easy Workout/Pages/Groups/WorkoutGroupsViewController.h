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

@interface WorkoutGroupsViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableDictionary *workoutGroupsDictionary;
@property (nonatomic, strong) NSArray *workoutGroups;
@property (nonatomic, strong) IBOutlet UITableView *tableView;


@end
