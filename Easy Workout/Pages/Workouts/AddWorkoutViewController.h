//
//  AddWorkoutViewController.h
//  iWorkout
//
//  Created by Aryan Gh on 9/30/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "WorkoutCategory.h"
#import "Workout.h"
#import "UIViewController+Additions.h"

@interface AddWorkoutViewController : BaseViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) IBOutlet UITextField *txtWorkoutName;
@property (nonatomic, strong) IBOutlet UITextField *txtWorkoutCategory;
@property (nonatomic, strong) IBOutlet UIPickerView *pickerView;

- (IBAction)addWorkoutSelected:(id)sender;
- (IBAction)cancelSelected:(id)sender;
- (IBAction)addCategorySelected:(id)sender;

@end
