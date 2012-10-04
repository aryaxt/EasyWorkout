//
//  CoreDataManager.m
//  iWorkout
//
//  Created by Aryan Gh on 9/29/12.
//  Copyright (c) 2012 Aryan Gh. All rights reserved.
//

#import "CoreDataManager.h"

@interface CoreDataManager()
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;
@end

@implementation CoreDataManager
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark - Initialization -

+ (CoreDataManager *)sharedManager
{
	static CoreDataManager *singleton;
	static dispatch_once_t onceToken;
	
	dispatch_once(&onceToken, ^{
		singleton = [[CoreDataManager alloc] init];
	});
	
	return singleton;
}

- (id)init
{
	if (self = [super init])
	{
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(applicationWillBeUnavailable:)
													 name:UIApplicationWillTerminateNotification
												   object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(applicationWillBeUnavailable:)
													 name:UIApplicationDidEnterBackgroundNotification
												   object:nil];
	}
	
	return self;
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Public Methods -

- (id)getInstanceForEntity:(NSString *)entity
{
	return [NSEntityDescription insertNewObjectForEntityForName:entity inManagedObjectContext:self.managedObjectContext];
}

- (id)getInstanceWithEntity:(NSString *)entity andPredicate:(NSPredicate *)predicate
{
	NSArray *result = [self getInstancesWithEntity:entity andPredicate:predicate];
	
	if (result.count == 1)
	{
		return [result lastObject];
	}
	
	return nil;
}

- (NSArray *)getInstancesWithEntity:(NSString *)entity andPredicate:(NSPredicate *)predicate
{
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entity
														 inManagedObjectContext:self.managedObjectContext];
	[request setEntity:entityDescription];
	
	if (predicate)
		[request setPredicate:predicate];
	
	return [self.managedObjectContext executeFetchRequest:request error:nil];
}

- (void)deleteManageObject:(id)object
{
	[self.managedObjectContext deleteObject:object];
}

#pragma mark - Private Methods -

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
	{
        if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error])
		{
			// Replace this implementation with code to handle the error appropriately.
			// abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil)
	{
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
	{
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil)
	{
        return _managedObjectModel;
    }
	
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"iWorkout" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil)
	{
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"iWorkout.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
	{
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - NSNotificationHandling -

- (void)applicationWillBeUnavailable:(NSNotification *)notification
{
	[self saveContext];
}

@end