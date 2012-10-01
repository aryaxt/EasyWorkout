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
@synthesize pickerView = _pickerView;
@synthesize categories = _categories;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self populateData];
}

#pragma mark - Private Methids -

- (void)populateData
{
	self.categories = [WorkoutCategory getInstancesWithPredicate:nil];
	
	[self.pickerView reloadAllComponents];
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
