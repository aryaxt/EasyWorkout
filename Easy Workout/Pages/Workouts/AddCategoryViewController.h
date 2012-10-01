//
//  AddCategoryViewController.h
//  iWorkout
//
//  Created by Aryan Gh on 9/30/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import "BaseViewController.h"
#import "WorkoutCategory.h"

@protocol AddCategoryViewControllerDelegate <NSObject>
- (void)addCategoryViewControllerDidAddCategory:(WorkoutCategory *)category;
- (void)addCategoryViewControllerDidSelectCancel;
@end

@interface AddCategoryViewController : BaseViewController <UITextFieldDelegate>

@property (nonatomic, assign) id <AddCategoryViewControllerDelegate> delegate;
@property (nonatomic, strong) IBOutlet UITextField *txtName;

- (IBAction)doneSelected:(id)sender;
- (IBAction)cancelSelected:(id)sender;

@end
