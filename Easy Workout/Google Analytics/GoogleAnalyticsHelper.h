//
//  GoogleAnalyticsHelper.h
//  Easy Workout
//
//  Created by Aryan Gh on 10/21/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GANTracker.h"

@interface GoogleAnalyticsHelper : NSObject

extern NSString *GoogleAnalyticsHelperPageWorkoutLogs;
extern NSString *GoogleAnalyticsHelperPageWorkoutLogDetail;
extern NSString *GoogleAnalyticsHelperPageAddWorkoutLog;
extern NSString *GoogleAnalyticsHelperPageWorkouts;
extern NSString *GoogleAnalyticsHelperPageAddWorkouts;
extern NSString *GoogleAnalyticsHelperPageRoutines;
extern NSString *GoogleAnalyticsHelperPageAddRoutines;
extern NSString *GoogleAnalyticsHelperPageAddWorkoutCategory;

+ (GoogleAnalyticsHelper *)sharedInstance;
- (void)trackPage:(NSString *)pageName;
- (void)trackEventWithCategory:(NSString *)category
						action:(NSString *)action
						 label:(NSString *)label
					  andValue:(NSInteger)value;

@end
