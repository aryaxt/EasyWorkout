//
//  WorkoutLogsViewController.m
//  iWorkout
//
//  Created by Aryan Gh on 9/30/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import "WorkoutLogsViewController.h"

@implementation WorkoutLogsViewController
@synthesize logDetailViewContorller = _logDetailViewContorller;
@synthesize logs = _logs;
@synthesize selectedDate = _selectedDate;
@synthesize tableView = _tableView;

#pragma mark - Viewcontroller Methods -

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	self.selectedDate = [NSDate date];
	[self populateData];
	[self.tableView reloadData];
	
	[self.googleAnalyticsHelper trackPage:GoogleAnalyticsHelperPageWorkoutLogs];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"AddWorkoutLogViewControllerSegue"])
	{
		AddWorkoutLogViewController *vc = (AddWorkoutLogViewController *) segue.destinationViewController;
		vc.delegate = self;
	}
}

#pragma mark - Private Methods -

- (void)populateData
{
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit
											   fromDate:self.selectedDate];
	
	NSDateComponents *oneDay = [[NSDateComponents alloc] init];
	oneDay.day = 1;
	
	// From date  & To date
	NSDate *fromDate = [calendar dateFromComponents:components];
	NSDate *toDate = [calendar dateByAddingComponents:oneDay toDate:fromDate options:0];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date >= %@ AND date <= %@", fromDate, toDate];
	self.logs = [WorkoutLog getInstancesWithPredicate:predicate];
}

- (WorkoutLog *)pastLogForWorkout:(Workout *)workout
{
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"workout == %@", workout];
	NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
	
	NSArray *logs = [WorkoutLog getInstancesWithPredicate:predicate
											  sortDescriptor:sortDescriptor
													andLimit:1];
	
	if (logs.count)
	{
		return [logs lastObject];
	}
	
	return nil;
}

#pragma mark - AddWorkoutLogViewControllerDelegate Methods -

- (void)addWorkoutLogViewControllerDidSelectWorkouts:(NSArray *)workouts
{
	for (Workout *workout in workouts)
	{
		WorkoutLog *pastLog = [self pastLogForWorkout:workout];
		
		WorkoutLog *log = [WorkoutLog getInstance];
		log.date = [NSDate date];
		log.workout = workout;
		
		if (pastLog)
		{
			log.reps = pastLog.reps;
			log.weight = pastLog.weight;
		}
	}
	
	[self populateData];
	[self.tableView reloadData];
}

#pragma mark - WorkoutLogDetailViewControllerDelegate Methods -

- (void)workoutLogDetailViewControllerDidSelectDone
{
	[self dismissFormSheetViewControllerAnimated:YES];
	[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
	[self.tableView reloadData];
}

- (void)workoutLogDetailViewControllerDidSelectCancel
{
	[self dismissFormSheetViewControllerAnimated:YES];
	[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

#pragma mark - UITableView Delegate & Datasrouce -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.logs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	WorkoutLogCell *cell = (WorkoutLogCell *) [tableView dequeueReusableCellWithIdentifier:@"WorkoutLogCell"];
	
	WorkoutLog *log = [self.logs objectAtIndex:indexPath.row];
	[cell setWorkoutLog:log];
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	WorkoutLog *log = [self.logs objectAtIndex:indexPath.row];
	[self presentFormSheetViewContorller:self.logDetailViewContorller animated:YES];
	self.logDetailViewContorller.workoutLog = log;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
	{
        WorkoutLog *log = [self.logs objectAtIndex:indexPath.row];
		[log delete];
		[self populateData];
		[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
							  withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - Setter & Getter -

- (WorkoutLogDetailViewController *)logDetailViewContorller
{
	if (!_logDetailViewContorller)
	{
		_logDetailViewContorller = [[WorkoutLogDetailViewController alloc] initFromStoryboard];
		_logDetailViewContorller.delegate = self;
	}
	
	return _logDetailViewContorller;
}

@end
