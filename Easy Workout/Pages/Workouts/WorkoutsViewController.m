//
//  WorkoutsViewController.m
//  iWorkout
//
//  Created by Aryan Gh on 9/29/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import "WorkoutsViewController.h"

@implementation WorkoutsViewController
@synthesize tableView = _tableView;
@synthesize workoutsDictionary = _workoutsDictionary;
@synthesize workoutCategories = _workoutCategories;

#pragma mark - UIViewController Methods -

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.workoutsDictionary = [NSMutableDictionary dictionary];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self populateData];
}

#pragma mark - Private Mthods -

- (void)populateData
{
	[self.workoutsDictionary removeAllObjects];
	self.workoutCategories = [WorkoutCategory getInstancesWithPredicate:nil];
	
	for (WorkoutCategory *category in self.workoutCategories)
	{
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category == %@", category];
		NSArray *workouts = [Workout getInstancesWithPredicate:predicate];
		
		if (workouts.count)
		{
			[self.workoutsDictionary setObject:workouts forKey:category.name];
		}
	}
	
	[self.tableView reloadData];
}

#pragma mark - IBActions -

- (IBAction)addSelected:(id)sender
{
	
}

#pragma mark - UITableView Delegate & Datasrouce -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return self.workoutCategories.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	WorkoutCategory *category = [self.workoutCategories objectAtIndex:section];
	NSArray *workouts = [self.workoutsDictionary objectForKey:category.name];
	return workouts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	WorkoutCategory *category = [self.workoutCategories objectAtIndex:indexPath.section];
	NSArray *workouts = [self.workoutsDictionary objectForKey:category.name];
	Workout *workout = [workouts objectAtIndex:indexPath.row];
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WorkoutCell"];
	cell.textLabel.text = workout.name;
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	WorkoutCategory *category = [self.workoutCategories objectAtIndex:section];
	return category.name;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}

@end
