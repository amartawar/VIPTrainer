//
//  Workout.m
//  VipTrainer
//
//  Created by kenney on 4/1/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "Workout.h"

@implementation Workout

@dynamic exercises;
@dynamic status;
@dynamic assessment;
@dynamic partnership;
@dynamic sessionIndex;

-(id)init{
    self = [super init];
    if(self){
        //self.exercises = [[NSMutableArray alloc] init];
    }
    return self;
}


+(NSString *)parseClassName{
    return @"Workout";
}

@end
