//
//  Chat.m
//  VipTrainer
//
//  Created by kenney on 4/17/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "Rating.h"

@implementation Rating

@dynamic client;
@dynamic trainer_id;
@dynamic rating;
@dynamic comments;

+(NSString *)parseClassName{
    return @"Rating";
}

@end
