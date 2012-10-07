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
	return self.categories.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [[self.categories objectAtIndex:row] name];
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
	if (self.txtWorkoutName.text.length && self.categories.count)
	{
		Workout *workout = [Workout getInstance];
		workout.name = self.txtWorkoutName.text;
		NSInteger index = [self.pickerView selectedRowInComponent:0];
		workout.category = [self.categories objectAtIndex:index];
		
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
														message:@"Workout and category names are required"
													   delegate:self
											  cancelButtonTitle:@"Cancel"
											  otherButtonTitles:@"Add", nil];
	[alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
	[alertView show];
}

- (IBAction)cancelSelected:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}

@end
