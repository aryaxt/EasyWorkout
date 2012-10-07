//
//  WorkoutRoutinesViewController.m
//  iWorkout
//
//  Created by Aryan Gh on 9/30/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import "WorkoutRoutinesViewController.h"

@implementation WorkoutRoutinesViewController
@synthesize tableView = _tableView;
@synthesize workoutRoutinesDictionary = _workoutRoutinesDictionary;
@synthesize expandedSections = _expandedSections;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.workoutRoutinesDictionary = [NSMutableDictionary dictionary];
	self.expandedSections = [NSMutableArray array];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[self populateWorkoutRoutines];
	[self.tableView reloadData];
}

#pragma mark - Private Methods -

- (void)populateWorkoutRoutines
{
	[self.workoutRoutinesDictionary removeAllObjects];
	self.workoutRoutines = [WorkoutRoutine getInstancesWithPredicate:nil andSortDescriptor:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
	
	for (WorkoutRoutine *routine in self.workoutRoutines)
	{
		[self.workoutRoutinesDictionary setObject:routine.workouts.allObjects forKey:routine.name];
	}
}

- (BOOL)isHeaderExpandedInSection:(NSInteger)section
{
	if ([self.expandedSections containsObject:[NSNumber numberWithInt:section]])
	{
		return YES;
	}
	
	return NO;
}

#pragma mark - CellExpandableHeaderViewDelegate Delegate -

- (void)cellExpandableHeaderViewDidSelectExpandInSection:(NSInteger)section
{
	NSNumber *currentSection = [NSNumber numberWithInt:section];
	
	if ([self isHeaderExpandedInSection:section])
	{
		[self.expandedSections removeObject:currentSection];
	}
	else
	{
		[self.expandedSections addObject:currentSection];
	}
	
	[self.tableView beginUpdates];
	[self.tableView endUpdates];
}

- (void)cellExpandableHeaderViewDidSelectDeleteInSection:(NSInteger)section
{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Delete Routine" message:@"Are you sure you want to delete this workout routine?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
	alertView.tag = section;
	[alertView show];
}

#pragma mark - UIAlertViewDelegate Methods -

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex)
	{
		WorkoutRoutine *routine = [self.workoutRoutines objectAtIndex:alertView.tag];
		[routine delete];
		
		[self populateWorkoutRoutines];
		[self.tableView deleteSections:[NSIndexSet indexSetWithIndex:alertView.tag]
					  withRowAnimation:UITableViewRowAnimationAutomatic];
		
		// Force table sections to be updated
		[self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.5];
		
	}
}

#pragma mark - UITableView Delegate & Datasrouce -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return self.workoutRoutines.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	WorkoutRoutine *routine = [self.workoutRoutines objectAtIndex:section];
	NSArray *workouts = [self.workoutRoutinesDictionary objectForKey:routine.name];
	return workouts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WorkoutRoutineCell"];
	
	WorkoutRoutine *routine = [self.workoutRoutines objectAtIndex:indexPath.section];
	NSArray *workouts = [self.workoutRoutinesDictionary objectForKey:routine.name];
	Workout *workout = [workouts objectAtIndex:indexPath.row];
	cell.textLabel.text = workout.name;
	return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	WorkoutRoutine *routine = [self.workoutRoutines objectAtIndex:section];
	
	CellExpandableHeaderView *header = [[CellExpandableHeaderView alloc] initWithSection:section];
	[header setTitle:routine.name];
	[header setDelegate:self];
	[header setExpanded:([self isHeaderExpandedInSection:section]) ? YES : NO animated:NO];
	return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([self.expandedSections containsObject:[NSNumber numberWithInt:indexPath.section]])
	{
		return 40;
	}
	else
	{
		return 0;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 40;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
	{
        WorkoutRoutine *routine = [self.workoutRoutines objectAtIndex:indexPath.section];
		
		NSMutableArray *workouts = [NSMutableArray arrayWithArray:[self.workoutRoutinesDictionary objectForKey:routine.name]];
		Workout *workout = [workouts objectAtIndex:indexPath.row];
		[workouts removeObject:workout];
		routine.workouts = [NSSet setWithArray:workouts];
		[self populateWorkoutRoutines];
		[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
							  withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

@end
