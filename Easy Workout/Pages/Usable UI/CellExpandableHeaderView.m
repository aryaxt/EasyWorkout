//
//  CellExpandableHeaderView.m
//  Easy Workout
//
//  Created by Aryan Gh on 10/2/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import "CellExpandableHeaderView.h"

@implementation CellExpandableHeaderView
@synthesize lblTitle = _lblTitle;
@synthesize btnDelete = _btnDelete;
@synthesize btnExpand = _btnExpand;
@synthesize section = _section;
@synthesize delegate = _delegate;

#pragma mark - Initialization -

- (id)initWithSection:(NSInteger)section
{
	self = [[[NSBundle mainBundle] loadNibNamed:@"CellExpandableHeaderView" owner:nil options:nil] lastObject];
	self.section = section;
	
	UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
																					action:@selector(tapDetected:)];
	[self addGestureRecognizer:tapRecognizer];
	
	return self;
}

#pragma mark - Public Methods -

- (void)setTitle:(NSString *)title
{
	self.lblTitle.text = title;
}

- (void)setExpanded:(BOOL)expanded animated:(BOOL)animated
{
	[self.btnExpand rotateToDegree:(expanded) ? 180 : 0 animated:animated];
}

#pragma mark - IBActions -

- (IBAction)expandSelected:(id)sender
{
	[self.btnExpand rotateToDegree:180 animated:YES];
	[self.delegate cellExpandableHeaderViewDidSelectExpandInSection:self.section];
}

- (IBAction)tapDetected:(id)sender
{
	[self expandSelected:nil];
}

@end
