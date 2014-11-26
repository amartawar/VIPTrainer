//
//  Progress.m
//  VipTrainer
//
//  Created by kenney on 7/20/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "Progress.h"

@implementation Progress
@dynamic neck;
@dynamic shoulders;
@dynamic chest;
@dynamic biceps;
@dynamic forearms;
@dynamic waist;
@dynamic thighs;
@dynamic calves;
@dynamic bodyFat;
@dynamic weight;
@dynamic image;
@dynamic user;

+(NSString *)parseClassName{
    return @"Progress";
}
@end
