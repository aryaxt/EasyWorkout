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
@synthesize calendarView = _calendarView;
@synthesize tapRecognizer = _tapRecognizer;

#pragma mark - Viewcontroller Methods -

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.selectedDate = [NSDate date];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
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

- (void)applicationDidEnterBackground
{
	[super applicationDidEnterBackground];
	
	self.selectedDate = [NSDate date];
}

#pragma mark - IBActions -

- (IBAction)calendarSelected:(id)sender
{
	if (self.calendarView.superview)
	{
		[self showCalendar:NO];
	}
	else
	{
		[self showCalendar:YES];
	}
}

- (void)tapDetected:(UITapGestureRecognizer *)gestureRecognizer
{
	[self showCalendar:NO];
}

#pragma mark - CKCalendarDelegate Methods -

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date
{
	self.selectedDate = date;
	[self showCalendar:NO];
}

#pragma mark - Private Methods -

- (void)showCalendar:(BOOL)show
{
	if (show)
		[self.view addSubview:self.calendarView];
	
	[UIView animateWithDuration:.3 animations:^{
		self.calendarView.alpha = (show) ? 1 : 0;
	} completion:^(BOOL finished){
		if (!show)
			[self.calendarView removeFromSuperview];
	}];
	
	if (show)
	{
		[self.view addGestureRecognizer:self.tapRecognizer];
	}
	else
	{
		[self.view removeGestureRecognizer:self.tapRecognizer];
	}
}

- (void)populateData
{
	unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self.selectedDate];
	
	//update for the start date
	[comps setHour:0];
	[comps setMinute:0];
	[comps setSecond:0];
	NSDate *fromDate = [calendar dateFromComponents:comps];
	
	//update for the end date
	[comps setHour:23];
	[comps setMinute:59];
	[comps setSecond:59];
	NSDate *toDate = [calendar dateFromComponents:comps];
	
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
		log.date = self.selectedDate;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle:NSDateFormatterFullStyle];
	return [dateFormatter stringFromDate:self.selectedDate];
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

- (UITapGestureRecognizer *)tapRecognizer
{
	if (!_tapRecognizer)
	{
		_tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
	}
	
	return _tapRecognizer;
}

- (CKCalendarView *)calendarView
{
	if (!_calendarView)
	{
		_calendarView = [[CKCalendarView alloc] initWithStartDay:startMonday frame:CGRectMake(10, 10, 300, 300)];
		_calendarView.delegate = self;
	}
	
	return _calendarView;
}

- (void)setSelectedDate:(NSDate *)selectedDate
{
	_selectedDate = selectedDate;
	
	[self.calendarView setSelectedDate:_selectedDate];
	
	[self populateData];
	[self.tableView reloadData];
}

@end
