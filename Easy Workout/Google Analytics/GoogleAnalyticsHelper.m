//
//  GoogleAnalyticsHelper.m
//  Easy Workout
//
//  Created by Aryan Gh on 10/21/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import "GoogleAnalyticsHelper.h"

@interface GoogleAnalyticsHelper()
@property (nonatomic, weak) GANTracker *ganTracker;
@end

@implementation GoogleAnalyticsHelper
@synthesize ganTracker = _ganTracker;

#pragma mark - Custom Variables -

NSString *GoogleAnalyticsHelperCustomVariableModality = @"Modality";
NSString *GoogleAnalyticsHelperCustomVariableApplicationVersion = @"App Version";

NSString *GoogleAnalyticsHelperPageWorkoutLogs = @"Workout Logs";
NSString *GoogleAnalyticsHelperPageWorkoutLogDetail = @"Workout Logs Detail";;
NSString *GoogleAnalyticsHelperPageAddWorkoutLog = @"Add Workout Logs";
NSString *GoogleAnalyticsHelperPageWorkouts = @"Workouts";
NSString *GoogleAnalyticsHelperPageAddWorkouts = @"Add Workouts";
NSString *GoogleAnalyticsHelperPageRoutines = @"Routines";
NSString *GoogleAnalyticsHelperPageAddRoutines = @"Add Routines";
NSString *GoogleAnalyticsHelperPageAddWorkoutCategory = @"Add Category";

#pragma mark - Initialization -

+ (GoogleAnalyticsHelper *)sharedInstance
{
	static dispatch_once_t onceToken;
	static GoogleAnalyticsHelper *singleton;
	
	dispatch_once(&onceToken, ^{
		singleton = [[GoogleAnalyticsHelper alloc] init];
	});
	
	return singleton;
}

- (id)init
{
	if (self = [super init])
	{
		[self startTracker];
		[self setupCustomVariables];
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(applicationDidEnterBackground:)
													 name:UIApplicationDidEnterBackgroundNotification
												   object:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(applicationWillEnterForeground:)
													 name:UIApplicationWillEnterForegroundNotification
												   object:nil];
	}
	
	return self;
}

#pragma mark - Public MEthods -

- (void)trackPage:(NSString *)pageName
{
	NSError *error;
	
	if ([self.ganTracker trackPageview:pageName withError:&error])
	{
		DLog(@"🎦 Tracked page (%@)", pageName);
	}
	else
	{
		DLog(@"🎦 Failed to track page (%@)", pageName);
	}
}

- (void)trackEventWithCategory:(NSString *)category
						action:(NSString *)action
						 label:(NSString *)label
					  andValue:(NSInteger)value
{
	NSError *error;
	
	if ([self.ganTracker trackEvent:category
							 action:action
							  label:label
							  value:value
						  withError:&error])
	{
		DLog(@"🎦 Tracked event (%@-%@-%@-%d))", category, action, label, value);
	}
	else
	{
		DLog(@"🎦 Failed to track event (%@-%@-%@-%d)", category, action, label, value);
	}
}

#pragma mark - Private Methods -

- (void)startTracker
{
	[self.ganTracker startTrackerWithAccountID:@"UA-35738460-3"
								dispatchPeriod:5
									  delegate:nil];
}

- (void)stopTracker
{
	[self.ganTracker stopTracker];
}

- (void)setupCustomVariables
{
	NSError *error;
	
	if (![self.ganTracker setCustomVariableAtIndex:1
											  name:GoogleAnalyticsHelperCustomVariableModality
											 value:@"Tablet"
										 withError:&error])
	{
		DLog(@"🎦 Failed to setup Custom Variable");
	}
	
	NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
	NSString *versionString = [infoDictionary objectForKey:@"CFBundleVersion"];
	
	if (![self.ganTracker setCustomVariableAtIndex:2
											  name:GoogleAnalyticsHelperCustomVariableApplicationVersion
											 value:versionString
										 withError:&error])
	{
		DLog(@"🎦 Failed to setup Custom Variable");
	}
}

#pragma mark - NSNotification Handling -

- (void)applicationDidEnterBackground:(NSNotification *)notification
{
	[self stopTracker];
}

- (void)applicationWillEnterForeground:(NSNotification *)notification
{
	[self startTracker];
}

#pragma mark - Setter & Getter -

- (GANTracker *)ganTracker
{
	if (!_ganTracker)
	{
		_ganTracker = [GANTracker sharedTracker];
	}
	
	return _ganTracker;
}

@end
