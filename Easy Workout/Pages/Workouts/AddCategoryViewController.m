//
//  AddCategoryViewController.m
//  iWorkout
//
//  Created by Aryan Gh on 9/30/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import "AddCategoryViewController.h"

@implementation AddCategoryViewController
@synthesize txtName = _txtName;
@synthesize delegate = _delegate;

#pragma mark - UIViewContorller Methods -

- (void)viewDidLoad
{
	[super viewDidLoad];
}

#pragma mark - UITextFieldDelegate Methods -

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

#pragma mark - IBActions -

- (IBAction)doneSelected:(id)sender
{
	if (self.txtName.text.length)
	{
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", self.txtName.text];
		NSArray *categories = [WorkoutCategory getInstancesWithPredicate:predicate];
		
		if (categories.count == 0)
		{
			WorkoutCategory *category = [WorkoutCategory getInstance];
			category.name = self.txtName.text;
			
			[self.delegate addCategoryViewControllerDidAddCategory:category];
		}
	}
}

- (IBAction)cancelSelected:(id)sender
{
	[self.delegate addCategoryViewControllerDidSelectCancel];
}

@end
