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
	
	self.txtWorkoutCategory.inputView = self.pickerView;
	[self.txtWorkoutName becomeFirstResponder];
	
	[self populateData];
	[self populateSelectedCategory];
}

#pragma mark - Private Methids -

- (void)populateData
{
	self.categories = [WorkoutCategory getInstancesWithPredicate:nil];
	
	[self.pickerView reloadAllComponents];
}

- (void)populateSelectedCategory
{
	NSInteger index = [self.pickerView selectedRowInComponent:0];
	WorkoutCategory *category = [self.categories objectAtIndex:index];
	self.txtWorkoutCategory.text = category.name;
}

#pragma mark - AddCategoryViewControllerDelegate Methods -

- (void)addCategoryViewControllerDidSelectCancel
{
	[self dismissFormSheetViewControllerAnimated:YES];
}

- (void)addCategoryViewControllerDidAddCategory:(WorkoutCategory *)category
{
	[self dismissFormSheetViewControllerAnimated:YES];
	[self populateData];
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

#pragma mark - IBAction -

- (IBAction)addWorkoutSelected:(id)sender
{
	if (self.txtWorkoutName.text.length)
	{
		Workout *workout = [Workout getInstance];
		workout.name = self.txtWorkoutName.text;
		NSInteger index = [self.pickerView selectedRowInComponent:0];
		workout.category = [self.categories objectAtIndex:index];
		
		[self dismissModalViewControllerAnimated:YES];
	}
}

- (IBAction)addCategorySelected:(id)sender
{
	AddCategoryViewController *vc = [[AddCategoryViewController alloc] initFromStoryboard];
	vc.delegate = self;
	[self presentFormSheetViewContorller:vc animated:YES];
}

- (IBAction)cancelSelected:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}

@end
