//
//  AddWorkoutLogViewController.m
//  iWorkout
//
//  Created by Aryan Gh on 9/30/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import "AddWorkoutLogViewController.h"

@implementation AddWorkoutLogViewController
@synthesize workoutGroups = _workoutGroups;
@synthesize workouts = _workouts;
@synthesize tableView = _tableView;
@synthesize delegate = _delegate;

#pragma mark - UIViewController Methods -

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	dispatch_async(dispatch_get_main_queue(), ^{
		self.workouts = [Workout getInstancesWithPredicate:nil andSortDescriptor:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
		self.workoutGroups = [WorkoutGroup getInstancesWithPredicate:nil
												   andSortDescriptor:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
	});
}

#pragma mark - IBActions -

- (IBAction)addSelected:(id)sender
{
	NSArray *indexPaths = [self.tableView indexPathsForSelectedRows];
	
	if (indexPaths.count)
	{
		NSMutableArray *workouts = [NSMutableArray array];
		
		for (NSIndexPath *indexPath in indexPaths)
		{
			if (indexPath.section == 0)
			{
				WorkoutGroup *group = [self.workoutGroups objectAtIndex:indexPath.row];
				[workouts addObjectsFromArray:group.workouts.allObjects];
			}
			else
			{
				Workout *workout = [self.workouts objectAtIndex:indexPath.row];
				[workouts addObject:workout];
			}
		}
		
		[self.delegate addWorkoutLogViewControllerDidSelectWorkouts:workouts];
		[self dismissModalViewControllerAnimated:YES];
	}
}

- (IBAction)cancelSelected:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark - UITableView Delegate & Datasrouce -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (section == 0)
	{
		return self.workoutGroups.count;
	}
	else
	{
		return self.workouts.count;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddWorkoutLogCell"];
	
	if (indexPath.section == 0)
	{
		WorkoutGroup *group = [self.workoutGroups objectAtIndex:indexPath.row];
		cell.textLabel.text = group.name;
	}
	else
	{
		Workout *workout = [self.workouts objectAtIndex:indexPath.row];
		cell.textLabel.text = workout.name;
	}
	
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if (section == 0)
	{
		return @"Workout Groups";
	}
	else
	{
		return @"Workouts";
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}

@end
