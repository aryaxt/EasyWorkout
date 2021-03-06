//
//  AddWrokoutRoutineViewController.m
//  iWorkout
//
//  Created by Aryan Gh on 9/30/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import "AddWrokoutRoutineViewController.h"

@implementation AddWrokoutRoutineViewController
@synthesize workouts = _workouts;
@synthesize txtRoutineName = _txtRoutineName;
@synthesize tableView = _tableView;

#pragma mark - UIViewController -

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.workouts = [Workout getInstancesWithPredicate:nil
									 andSortDescriptor:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[self.googleAnalyticsHelper trackPage:GoogleAnalyticsHelperPageAddRoutines];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self.txtRoutineName becomeFirstResponder];
}

#pragma mark - Private Methods -

- (void)updateCheckMarkStateForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
	
	cell.accessoryType = ([[self.tableView indexPathsForSelectedRows] containsObject:indexPath]) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

#pragma mark - UITableView Delegate & Datasrouce -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.workouts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	Workout *workout = [self.workouts objectAtIndex:indexPath.row];
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WorkoutRoutineWorkoutCell"];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.textLabel.text = workout.name;
	cell.accessoryType = ([[self.tableView indexPathsForSelectedRows] containsObject:indexPath]) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self updateCheckMarkStateForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self updateCheckMarkStateForRowAtIndexPath:indexPath];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	[self.txtRoutineName resignFirstResponder];
}

#pragma mark - UITextFieldDelegate Methods -

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

#pragma mark - IBActions -

- (IBAction)addSelected:(id)sender
{
	if (self.txtRoutineName.text.length && [self.tableView indexPathsForSelectedRows].count)
	{
		WorkoutRoutine *routine = [WorkoutRoutine getInstance];
		routine.name = self.txtRoutineName.text;
		
		NSMutableArray *workouts = [NSMutableArray array];
		for (NSIndexPath *indexPath in [self.tableView indexPathsForSelectedRows])
		{
			Workout *workout = [self.workouts objectAtIndex:indexPath.row];
			[workouts addObject:workout];
		}
		
		routine.workouts = [NSSet setWithArray:workouts];
	
		[self dismissModalViewControllerAnimated:YES];
	}
}

- (IBAction)cancelSelected:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}

@end
