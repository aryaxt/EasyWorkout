//
//  AddWrokoutGroupViewController.m
//  iWorkout
//
//  Created by Aryan Gh on 9/30/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import "AddWrokoutGroupViewController.h"

@implementation AddWrokoutGroupViewController
@synthesize workouts = _workouts;
@synthesize txtGroupName = _txtGroupName;
@synthesize tableView = _tableView;

#pragma mark - UIViewController -

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.workouts = [Workout getInstancesWithPredicate:nil
									 andSortDescriptor:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self.txtGroupName becomeFirstResponder];
}

#pragma mark - UITableView Delegate & Datasrouce -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.workouts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	Workout *workout = [self.workouts objectAtIndex:indexPath.row];
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WorkoutGroupWorkoutCell"];
	cell.textLabel.text = workout.name;
	return cell;
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
	if (self.txtGroupName.text.length && [self.tableView indexPathsForSelectedRows].count)
	{
		WorkoutGroup *group = [WorkoutGroup getInstance];
		group.name = self.txtGroupName.text;
		
		NSMutableArray *workouts = [NSMutableArray array];
		for (NSIndexPath *indexPath in [self.tableView indexPathsForSelectedRows])
		{
			Workout *workout = [self.workouts objectAtIndex:indexPath.row];
			[workouts addObject:workout];
		}
		
		group.workouts = [NSSet setWithArray:workouts];
	
		[self dismissModalViewControllerAnimated:YES];
	}
}

- (IBAction)cancelSelected:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}

@end
