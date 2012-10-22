//
//  LogDetailViewController.m
//  iWorkout
//
//  Created by Aryan Gh on 9/30/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import "WorkoutLogDetailViewController.h"

@implementation WorkoutLogDetailViewController
@synthesize workoutLog = _workoutLog;
@synthesize txtRep = _txtRep;
@synthesize txtWeight = _txtWeight;
@synthesize repStepper = _repStepper;
@synthesize weightStepper = _weightStepper;

#pragma mark - UIViewController Methods -

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[self.googleAnalyticsHelper trackPage:GoogleAnalyticsHelperPageWorkoutLogDetail];
}

#pragma mark - IBActions -

- (IBAction)repStepperDidChange:(id)sender
{
	self.txtRep.text = [NSString stringWithFormat:@"%.0f", self.repStepper.value];
}

- (IBAction)weightStepperDidChange:(id)sender
{
	self.txtWeight.text = [NSString stringWithFormat:@"%.0f", self.weightStepper.value];
}

- (IBAction)doneSelected:(id)sender
{
	self.workoutLog.reps = [NSNumber numberWithInt:self.txtRep.text.intValue];
	self.workoutLog.weight = [NSNumber numberWithInt:self.txtWeight.text.floatValue];
	self.workoutLog.completed = [NSNumber numberWithBool:YES];
	
	[self.delegate workoutLogDetailViewControllerDidSelectDone];
}

- (IBAction)cancelSelected:(id)sender
{
	[self.delegate workoutLogDetailViewControllerDidSelectCancel];
}

- (IBAction)textFieldDidChangeValue:(id)sender
{
	self.repStepper.value = self.txtRep.text.doubleValue;
	self.weightStepper.value = self.txtWeight.text.doubleValue;
}

#pragma mark - UITextField Delegate -

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	NSString *finalString = [textField.text stringByReplacingCharactersInRange:range withString:string];
	
	if (textField == self.txtRep)
	{
		if ([finalString isInteger] || !finalString.length)
		{
			return YES;
		}
	}
	else
	{
		if ([finalString isFloat] || !finalString.length)
		{
			return YES;
		}
	}
	
	return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

#pragma mark - Setter & Getter -

- (void)setWorkoutLog:(WorkoutLog *)workoutLog
{
	_workoutLog = workoutLog;
	
	self.txtRep.text = [NSString stringWithFormat:@"%@", workoutLog.reps];
	self.txtWeight.text = [NSString stringWithFormat:@"%@", workoutLog.weight];
	self.repStepper.value = workoutLog.reps.doubleValue;
	self.weightStepper.value = workoutLog.weight.doubleValue;
}

@end
