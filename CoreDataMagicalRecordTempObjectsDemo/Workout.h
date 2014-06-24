//
//  Workout.h
//  magicalDemo
//
//  Created by Vivek Gani on 6/22/14.
//  Copyright (c) 2014 Vivek Gani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Workout : NSManagedObject

@property (nonatomic, retain) NSNumber * workoutHeadbandCount;
@property (nonatomic, retain) NSString * workoutShortColor;
@property (nonatomic, retain) NSNumber * isBouncyHousePresent;

@end
