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
@synthesize expandedSections = _expandedSections;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.workoutGroupsDictionary = [NSMutableDictionary dictionary];
	self.expandedSections = [NSMutableArray array];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[self populateWorkoutGroups];
	[self.tableView reloadData];
}

#pragma mark - Private Methods -

- (void)populateWorkoutGroups
{
	[self.workoutGroupsDictionary removeAllObjects];
	self.workoutGroups = [WorkoutGroup getInstancesWithPredicate:nil andSortDescriptor:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
	
	for (WorkoutGroup *group in self.workoutGroups)
	{
		[self.workoutGroupsDictionary setObject:group.workouts.allObjects forKey:group.name];
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	WorkoutGroup *group = [self.workoutGroups objectAtIndex:section];
	
	CellExpandableHeaderView *header = [[CellExpandableHeaderView alloc] initWithSection:section];
	[header setTitle:group.name];
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
        WorkoutGroup *group = [self.workoutGroups objectAtIndex:indexPath.section];
		
		NSMutableArray *workouts = [NSMutableArray arrayWithArray:[self.workoutGroupsDictionary objectForKey:group.name]];
		Workout *workout = [workouts objectAtIndex:indexPath.row];
		[workouts removeObject:workout];
		group.workouts = [NSSet setWithArray:workouts];
		[self populateWorkoutGroups];
		[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
							  withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

@end
