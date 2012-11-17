//
//  AddWorkoutViewController.m
//  iWorkout
//
//  Created by Aryan Gh on 9/30/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import "AddWorkoutViewController.h"

@implementation AddWorkoutViewController
@synthesize txtWorkoutName = _txtWorkoutName;
@synthesize txtWorkoutCategory = _txtWorkoutCategory;
@synthesize pickerView = _pickerView;
@synthesize categories = _categories;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	dispatch_async(dispatch_get_main_queue(), ^{
		[self.pickerView removeFromSuperview];
		self.txtWorkoutCategory.inputView = self.pickerView;
		
		[self populateData];
		[self populateSelectedCategory];
	});
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[self.googleAnalyticsHelper trackPage:GoogleAnalyticsHelperPageAddWorkouts];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self.txtWorkoutName becomeFirstResponder];
}

#pragma mark - Private Methids -

- (void)populateData
{
	self.categories = [WorkoutCategory getInstancesWithPredicate:nil
											   andSortDescriptor:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
	
	[self.pickerView reloadAllComponents];
}

- (void)populateSelectedCategory
{
	if (self.categories.count)
	{
		NSInteger index = [self.pickerView selectedRowInComponent:0];
		WorkoutCategory *category = [self.categories objectAtIndex:index];
		self.txtWorkoutCategory.text = category.name;
	}
}

#pragma mark - UITextFieldDelegate Methods -

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if (textField == self.txtWorkoutName)
	{
		[self.txtWorkoutCategory becomeFirstResponder];
	}
	else
	{
		[self.txtWorkoutCategory resignFirstResponder];
	}
		
	return YES;
}

#pragma mark - UIPickerView Delegate & Datasource -

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	// Workaround for iOS 6 bug
	if (self.categories.count)
		return self.categories.count;
	else
		return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if (self.categories.count)
		return [[self.categories objectAtIndex:row] name];
	else
		return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	[self populateSelectedCategory];
}

#pragma mark - UIAlertViewDelegate Methods -

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex)
	{
		NSString *alertInput = [alertView textFieldAtIndex:0].text;
		
		if (alertInput.length)
		{
			NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@", alertInput];
			NSArray *existingCategoryWithName = [WorkoutCategory getInstancesWithPredicate:predicate andSortDescriptor:nil];
			
			if (existingCategoryWithName.count == 0)
			{
				WorkoutCategory *category = [WorkoutCategory getInstance];
				category.name = alertInput;
				
				[self populateData];
				[self populateSelectedCategory];
			}
			else
			{
				UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Add Category"
																	message:@"Category name already exists."
																   delegate:nil
														  cancelButtonTitle:@"Ok"
														  otherButtonTitles:nil];
				[alertView show];
			}
		}
	}
}

#pragma mark - IBAction -

- (IBAction)addWorkoutSelected:(id)sender
{
	NSInteger index = [self.pickerView selectedRowInComponent:0];
	WorkoutCategory *category;
	
	if (index != NSNotFound && self.categories.count)
		category = [self.categories objectAtIndex:index];
	
	if (self.txtWorkoutName.text.length && category.name.length)
	{
		Workout *workout = [Workout getInstance];
		workout.name = self.txtWorkoutName.text;
		workout.category = category;
		
		[self dismissModalViewControllerAnimated:YES];
	}
	else
	{
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Add Workout"
															message:@"Workout and category names are required"
														   delegate:self
												  cancelButtonTitle:@"Ok"
												  otherButtonTitles:nil];
		[alertView show];
	}
}

- (IBAction)addCategorySelected:(id)sender
{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Add Workout"
														message:@"Please enter a category name."
													   delegate:self
											  cancelButtonTitle:@"Cancel"
											  otherButtonTitles:@"Add", nil];
	[alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
	[alertView show];
	
	[self.googleAnalyticsHelper trackPage:GoogleAnalyticsHelperPageAddWorkoutCategory];
}

- (IBAction)cancelSelected:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}

@end
