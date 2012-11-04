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
@synthesize expandedSections = _expandedSections;

#pragma mark - UIViewController Methods -

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.workoutsDictionary = [NSMutableDictionary dictionary];
	self.expandedSections = [NSMutableArray array];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self populateData];
	[self.tableView reloadData];
	
	[self.googleAnalyticsHelper trackPage:GoogleAnalyticsHelperPageWorkouts];
}

#pragma mark - Private Mthods -

- (void)populateData
{
	[self.workoutsDictionary removeAllObjects];
	self.workoutCategories = [WorkoutCategory getInstancesWithPredicate:nil
													  andSortDescriptor:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
	
	for (WorkoutCategory *category in self.workoutCategories)
	{
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category == %@", category];
		NSArray *workouts = [Workout getInstancesWithPredicate:predicate];
		
		if (workouts.count)
		{
			[self.workoutsDictionary setObject:workouts forKey:category.name];
		}
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
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Delete Workouts" message:@"Are you sure you want to delete this category and all its workouts?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
	alertView.tag = section;
	[alertView show];
}

#pragma mark - UIAlertViewDelegate Methods -

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex)
	{
		WorkoutCategory *category = [self.workoutCategories objectAtIndex:alertView.tag];
		
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category == %@", category];
		NSArray *workoutsForCategory = [Workout getInstancesWithPredicate:predicate];
		
		for (Workout *workout in workoutsForCategory)
		{
			[workout delete];
		}
		
		[category delete];
				
		[self populateData];
		[self.tableView deleteSections:[NSIndexSet indexSetWithIndex:alertView.tag]
					  withRowAnimation:UITableViewRowAnimationAutomatic];
		
		// Force table sections to be updated
		[self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.5];
	}
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	WorkoutCategory *category = [self.workoutCategories objectAtIndex:section];
	
	CellExpandableHeaderView *header = [[CellExpandableHeaderView alloc] initWithSection:section];
	[header setTitle:category.name];
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
		WorkoutCategory *category = [self.workoutCategories objectAtIndex:indexPath.section];
		NSArray *workouts = [self.workoutsDictionary objectForKey:category.name];
		Workout *workout = [workouts objectAtIndex:indexPath.row];
		[workout delete];
		[self populateData];
		[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
							  withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

@end
