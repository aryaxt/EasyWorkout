//
//  AddWorkoutLogViewController.m
//  iWorkout
//
//  Created by Aryan Gh on 9/30/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import "AddWorkoutLogViewController.h"

@implementation AddWorkoutLogViewController
@synthesize workoutRoutines = _workoutRoutines;
@synthesize workouts = _workouts;
@synthesize tableView = _tableView;
@synthesize delegate = _delegate;

#pragma mark - UIViewController Methods -

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	dispatch_async(dispatch_get_main_queue(), ^{
		self.workouts = [Workout getInstancesWithPredicate:nil andSortDescriptor:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
		self.workoutRoutines = [WorkoutRoutine getInstancesWithPredicate:nil
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
				WorkoutRoutine *routine = [self.workoutRoutines objectAtIndex:indexPath.row];
				[workouts addObjectsFromArray:routine.workouts.allObjects];
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

#pragma mark - Private Methods -

- (void)updateCheckMarkStateForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
	
	cell.accessoryType = ([[self.tableView indexPathsForSelectedRows] containsObject:indexPath]) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
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
		return self.workoutRoutines.count;
	}
	else
	{
		return self.workouts.count;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddWorkoutLogCell"];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.accessoryType = ([[self.tableView indexPathsForSelectedRows] containsObject:indexPath]) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
	
	if (indexPath.section == 0)
	{
		WorkoutRoutine *routine = [self.workoutRoutines objectAtIndex:indexPath.row];
		cell.textLabel.text = routine.name;
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
		return @"Routines";
	}
	else
	{
		return @"Workouts";
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{	
	[self updateCheckMarkStateForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self updateCheckMarkStateForRowAtIndexPath:indexPath];
}

@end
