//
//  AppDelegate.m
//  CoreDataMagicalRecordTempObjectsDemo
//
//  Created by Vivek Gani on 6/23/14.
//  Copyright (c) 2014 Vivek Gani. All rights reserved.
//


#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"CoreDataMagicalRecordTempObjectsDemo"];
    
    NSEntityDescription *workoutEntity = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:[NSManagedObjectContext MR_defaultContext]];
    
    //
    //Using default context directly (not what we want, but known to work)
    //
    Workout *workoutDefaultContext = [[Workout alloc] initWithEntity:workoutEntity insertIntoManagedObjectContext:[NSManagedObjectContext MR_defaultContext]];
    
    workoutDefaultContext.workoutHeadbandCount = [[NSNumber alloc] initWithInt:1];
    workoutDefaultContext.isBouncyHousePresent = @true;
    workoutDefaultContext.workoutShortColor = @"Default Context - Boring Grey";
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    //
    //Using nil context then inserting to context (doesn't properly save attributes on OSX)
    //
    Workout *workoutNilContext = [[Workout alloc] initWithEntity:workoutEntity insertIntoManagedObjectContext:nil];
    
    workoutNilContext.workoutHeadbandCount = [[NSNumber alloc] initWithInt:2];
    workoutNilContext.isBouncyHousePresent = @true;
    workoutNilContext.workoutShortColor = @"Nil Context. Black. Fin.";
    
    [[NSManagedObjectContext MR_defaultContext] insertObject:workoutNilContext];
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    //
    //Using child context
    //
    //Part 1: Example of saving to persistent store
    NSManagedObjectContext *childContextOne = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    childContextOne.parentContext = [NSManagedObjectContext MR_defaultContext];
    
    Workout *workoutChildContextOne = [[Workout alloc] initWithEntity:workoutEntity insertIntoManagedObjectContext:childContextOne];
    
    workoutChildContextOne.workoutHeadbandCount = [[NSNumber alloc] initWithInt:3];
    workoutChildContextOne.isBouncyHousePresent = @true;
    workoutChildContextOne.workoutShortColor = @"Shiny Child - Persisted Silver";
    
    [childContextOne MR_saveToPersistentStoreAndWait]; //first save child context to apply it to parent.
    //[[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait]; //this is redundant, and not needed. saving the child context using saveToPersistStore will also persist into the parent.
    
    //
    //Using child context
    //
    //Part 2: Example of not saving to persistent store
    NSManagedObjectContext *childContextTwo = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    childContextTwo.parentContext = [NSManagedObjectContext MR_defaultContext];
    
    Workout *workoutChildContextTwo = [[Workout alloc] initWithEntity:workoutEntity insertIntoManagedObjectContext:childContextTwo];
    
    workoutChildContextTwo.workoutHeadbandCount = [[NSNumber alloc] initWithInt:4];
    workoutChildContextTwo.isBouncyHousePresent = @true;
    workoutChildContextTwo.workoutShortColor = @"YOLO Child - Yellow";
    
    //no save done on the child context, this object won't be persisted...
    //to ensure it won't get saved, let's test saving the default context, which will do nothing
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}


@end
