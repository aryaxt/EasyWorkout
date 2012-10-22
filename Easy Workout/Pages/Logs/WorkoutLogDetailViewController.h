//
//  LogDetailViewController.h
//  iWorkout
//
//  Created by Aryan Gh on 9/30/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "WorkoutLog.h"
#import "Workout.h"
#import "NSString+Additions.h"

@protocol WorkoutLogDetailViewControllerDelegate <NSObject>
- (void)workoutLogDetailViewControllerDidSelectDone;
- (void)workoutLogDetailViewControllerDidSelectCancel;
@end

@interface WorkoutLogDetailViewController : BaseViewController <UITextFieldDelegate>

@property (nonatomic, weak) id <WorkoutLogDetailViewControllerDelegate> delegate;
@property (nonatomic, strong) WorkoutLog *workoutLog;
@property (nonatomic, strong) IBOutlet UIStepper *repStepper;
@property (nonatomic, strong) IBOutlet UIStepper *weightStepper;
@property (nonatomic, strong) IBOutlet UITextField *txtRep;
@property (nonatomic, strong) IBOutlet UITextField *txtWeight;

- (IBAction)repStepperDidChange:(id)sender;
- (IBAction)weightStepperDidChange:(id)sender;
- (IBAction)doneSelected:(id)sender;
- (IBAction)cancelSelected:(id)sender;
- (IBAction)textFieldDidChangeValue:(id)sender;

@end
