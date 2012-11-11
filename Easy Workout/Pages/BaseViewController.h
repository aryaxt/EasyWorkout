//
//  BaseViewController.h
//  iWorkout
//
//  Created by Aryan Gh on 9/30/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "GoogleAnalyticsHelper.h"

typedef enum {
	FormSheetStyleSmall,
	FormSheetStyleLarge
}FormSheetStyle;

@interface BaseViewController : UIViewController

@property (nonatomic, assign) FormSheetStyle formSheetStyle;
@property (nonatomic, strong) GoogleAnalyticsHelper *googleAnalyticsHelper;

- (void)presentFormSheetViewContorller:(UIViewController *)viewConotrller animated:(BOOL)animated;
- (void)dismissFormSheetViewControllerAnimated:(BOOL)animated;
- (void)applicationDidEnterBackground;
- (void)applicationDidEnterForeground;

@end
