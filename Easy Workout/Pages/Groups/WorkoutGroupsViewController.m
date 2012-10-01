//
//  WorkoutGroupsViewController.m
//  iWorkout
//
//  Created by Aryan Gh on 9/30/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import "WorkoutGroupsViewController.h"

@implementation WorkoutGroupsViewController
@synthesize tableView = _tableView;
@synthesize workoutGroupsDictionary = _workoutGroupsDictionary;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.workoutGroupsDictionary = [NSMutableDictionary dictionary];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self populateWorkoutGroups];
}

#pragma mark - Private Methods -

- (void)populateWorkoutGroups
{
	[self.workoutGroupsDictionary removeAllObjects];
	self.workoutGroups = [WorkoutGroup getInstancesWithPredicate:nil];
	
	for (WorkoutGroup *group in self.workoutGroups)
	{
		[self.workoutGroupsDictionary setObject:group.workouts.allObjects forKey:group.name];
	}
	
	[self.tableView reloadData];
}

#pragma mark - WorkoutGroupHeaderViewDelegate Methods -

- (void)workoutGroupHeaderViewDidSelectDeleteForWorkoutGroup:(WorkoutGroup *)group
{
	[group delete];
	[self populateWorkoutGroups];
}

#pragma mark - UITableView Delegate & Datasrouce -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return self.workoutGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	WorkoutGroup *group = [self.workoutGroups objectAtIndex:section];
	NSArray *workouts = [self.workoutGroupsDictionary objectForKey:group.name];
	return workouts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WorkoutGroupCell"];
	
	WorkoutGroup *group = [self.workoutGroups objectAtIndex:indexPath.section];
	NSArray *workouts = [self.workoutGroupsDictionary objectForKey:group.name];
	Workout *workout = [workouts objectAtIndex:indexPath.row];
	cell.textLabel.text = workout.name;
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	WorkoutGroup *group = [self.workoutGroups objectAtIndex:section];
	return group.name;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}

@end
