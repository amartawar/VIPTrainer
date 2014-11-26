//
//  Condition.m
//  VipTrainer
//
//  Created by kenney on 4/6/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "Condition.h"

@implementation Condition


@synthesize name;
@synthesize affected;
@synthesize comment;

-(id)init{
    self = [super init];
    if(self){
        name = @"";
        affected = @"";
        comment = @"";
    }
    return self;
}

@end
