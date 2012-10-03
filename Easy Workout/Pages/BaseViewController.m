//
//  BaseViewController.m
//  iWorkout
//
//  Created by Aryan Gh on 9/30/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController()
@property (nonatomic, strong) UIViewController *formSheetViewConotrller;
@property (nonatomic, assign) BOOL keyboardIsVisible;
@end

@implementation BaseViewController
@synthesize formSheetViewConotrller = _formSheetViewConotrller;
@synthesize keyboardIsVisible = _keyboardIsVisible;
@synthesize formSheetStyle = _formSheetStyle;

static NSInteger FORMSHEET_WITH = 300;
static NSInteger FORMSHEET_HEIGHT = 190;
static NSInteger FORMSHEET_LARGE_TOP_INSET = 5;
static CGFloat ANIMATION_DURATION = .35;

#pragma mark - UIViewConotrller MEthods -

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
	{
		self.formSheetStyle = FormSheetStyleSmall;
	}
	
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillShow:)
												 name:UIKeyboardWillShowNotification
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillHide:)
												 name:UIKeyboardWillHideNotification
											   object:nil];
}

#pragma mark - Public Methods -

- (void)presentFormSheetViewContorller:(UIViewController *)viewConotrller animated:(BOOL)animated
{
	self.formSheetViewConotrller = viewConotrller;
	
	self.formSheetViewConotrller.view.layer.cornerRadius = 5;
	self.formSheetViewConotrller.view.clipsToBounds = YES;
	self.formSheetViewConotrller.view.layer.borderColor = [UIColor darkGrayColor].CGColor;
	self.formSheetViewConotrller.view.layer.borderWidth = 2;
	
	__block CGRect rect = CGRectMake((320-FORMSHEET_WITH)/2, 500, FORMSHEET_WITH, FORMSHEET_HEIGHT);
	self.formSheetViewConotrller.view.frame = rect;
	[self.view addSubview:self.formSheetViewConotrller.view];
	
	[UIView animateWithDuration:(animated) ? ANIMATION_DURATION : 0 animations:^{
		[self moveFormSheetAccordingly];
	}];
}

- (void)dismissFormSheetViewControllerAnimated:(BOOL)animated
{
	[UIView animateWithDuration:(animated) ? ANIMATION_DURATION : 0 animations:^{
		CGRect rect = self.formSheetViewConotrller.view.frame;
		rect.origin.y = 500;
		self.formSheetViewConotrller.view.frame = rect;
	} completion:^(BOOL finished){
		[self.formSheetViewConotrller.view removeFromSuperview];
		self.formSheetViewConotrller = nil;
	}];
}

#pragma mark - Private Methods -

- (void)moveFormSheetAccordingly
{
	__block CGRect rect = self.formSheetViewConotrller.view.frame;
	rect.origin.y = (self.keyboardIsVisible) ? 5 : (self.view.frame.size.height - FORMSHEET_HEIGHT) /2;
	
	[UIView animateWithDuration:ANIMATION_DURATION animations:^{
		
		if (((BaseViewController *)self.formSheetViewConotrller).formSheetStyle == FormSheetStyleSmall)
		{
			rect.size.height = FORMSHEET_HEIGHT;
			rect.origin.y = (self.keyboardIsVisible) ? FORMSHEET_LARGE_TOP_INSET : (self.view.frame.size.height - FORMSHEET_HEIGHT) /2;
		}
		else
		{
			rect.size.height = self.view.frame.size.height - (FORMSHEET_LARGE_TOP_INSET*2);
			rect.origin.y = FORMSHEET_LARGE_TOP_INSET;
		}
		
		self.formSheetViewConotrller.view.frame = rect;
	}];
}

#pragma mark - NSNotification Handling -

- (void)keyboardWillShow:(NSNotification *)notification
{
	self.keyboardIsVisible = YES;
	[self moveFormSheetAccordingly];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
	self.keyboardIsVisible = NO;
	[self moveFormSheetAccordingly];
}

@end
