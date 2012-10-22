//
//  AppDelegate.m
//  iWorkout
//
//  Created by Aryan Gh on 9/29/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import "AppDelegate.h"
#import "Workout.h"
#import "WorkoutRoutine.h"
#import "WorkoutCategory.h"
#import "Workout.h"
#import "CoreDataManager.h"
#import "GoogleAnalyticsHelper.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[self setAppearanceSettings];
	[self populateInitialData];
	[GoogleAnalyticsHelper sharedInstance];
	
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)setAppearanceSettings
{
	UIColor *color = [UIColor colorWithRed:31.0/255.0 green:52.0/255.0 blue:145.0/255.0 alpha:1];
	
	[[UINavigationBar appearance] setTintColor:color];
	[[UIToolbar appearance] setTintColor:color];
	[[UITabBar appearance] setTintColor:color];
}

- (void)populateInitialData
{
	static NSString *initialDataPopulationPreference = @"initialDataPopulationPreference";
	
	if (![[NSUserDefaults standardUserDefaults] objectForKey:initialDataPopulationPreference])
	{
		WorkoutCategory *bicepCategory = [WorkoutCategory getInstance];
		bicepCategory.name = @"Bicep";
		
		WorkoutCategory *tricepCategory = [WorkoutCategory getInstance];
		tricepCategory.name = @"Tricep";
		
		WorkoutCategory *backCategory = [WorkoutCategory getInstance];
		backCategory.name = @"Back";
		
		WorkoutCategory *shoulderCategory = [WorkoutCategory getInstance];
		shoulderCategory.name = @"Shoulder";
		
		WorkoutCategory *legCategory = [WorkoutCategory getInstance];
		legCategory.name = @"Leg";
		
		
		Workout *workout1 = [Workout getInstance];
		workout1.name = @"Bicep Curl";
		workout1.category = bicepCategory;
		
		Workout *workout2 = [Workout getInstance];
		workout2.name = @"Rotating Bicep Curl";
		workout2.category = bicepCategory;
		
		Workout *workout3 = [Workout getInstance];
		workout3.name = @"Tricep Extension";
		workout3.category = tricepCategory;
		
		Workout *workout11 = [Workout getInstance];
		workout11.name = @"Bench Dips";
		workout11.category = tricepCategory;
		
		Workout *workout4 = [Workout getInstance];
		workout4.name = @"Shoulder Shrugs";
		workout4.category = shoulderCategory;
		
		Workout *workout5 = [Workout getInstance];
		workout5.name = @"Shoulder Press";
		workout5.category = shoulderCategory;
		
		Workout *workout6 = [Workout getInstance];
		workout6.name = @"Lateral Deltoid";
		workout6.category = shoulderCategory;
		
		Workout *workout7 = [Workout getInstance];
		workout7.name = @"Leg Extension";
		workout7.category = legCategory;
		
		Workout *workout8 = [Workout getInstance];
		workout8.name = @"Leg Curl";
		workout8.category = legCategory;
		
		Workout *workout9 = [Workout getInstance];
		workout9.name = @"Lat Pull-Downs";
		workout9.category = backCategory;
		
		Workout *workout10 = [Workout getInstance];
		workout10.name = @"Seated Cable Rows";
		workout10.category = backCategory;
		
		WorkoutRoutine *routine = [WorkoutRoutine getInstance];
		routine.name = @"Shoulder & Arms Day";
		routine.workouts = [NSSet setWithObjects:workout5, workout4, workout3, workout2, workout1, workout11, nil];
		
		[[CoreDataManager sharedManager] saveContext];
		[[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:initialDataPopulationPreference];
	}
}

@end
