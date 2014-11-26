//
//  Workout.h
//  VipTrainer
//
//  Created by kenney on 4/1/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <Parse/Parse.h>
#import "Partnership.h"


typedef enum {
    WORKOUT_CREATED = 1,
    WORKOUT_COMPLETED,
    WORKOUT_ASSESSED,
    
} WorkoutStatus;

@interface Workout : PFObject <PFSubclassing>

+(NSString *)parseClassName;

@property (nonatomic) NSMutableArray  *exercises;
@property (nonatomic) NSString *assessment;
@property (nonatomic) int status;
@property (nonatomic) Partnership *partnership;
@property (nonatomic) NSNumber *sessionIndex;

@end
