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
	
	[self.tableView reloadData];
}

- (BOOL)isHeaderExpandedInSection:(NSInteger)section
{
	if ([self.expandedSections containsObject:[NSNumber numberWithInt:section]])
	{
		return YES;
	}
	
	return NO;
}

#pragma mark - IBActions -

- (IBAction)addSelected:(id)sender
{
	
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
    }
}

@end
