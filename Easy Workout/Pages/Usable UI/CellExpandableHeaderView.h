//
//  CellExpandableHeaderView.h
//  Easy Workout
//
//  Created by Aryan Gh on 10/2/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Additions.h"

@protocol CellExpandableHeaderViewDelegate <NSObject>
- (void)cellExpandableHeaderViewDidSelectExpandInSection:(NSInteger)section;
@end

@interface CellExpandableHeaderView : UIView

@property (nonatomic, weak) id <CellExpandableHeaderViewDelegate> delegate;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, strong) IBOutlet UILabel *lblTitle;
@property (nonatomic, strong) IBOutlet UIButton *btnExpand;
@property (nonatomic, strong) IBOutlet UIButton *btnDelete;

- (id)initWithSection:(NSInteger)section;
- (void)setTitle:(NSString *)title;
- (IBAction)expandSelected:(id)sender;

@end
