//
//  Nutrition.m
//  VipTrainer
//
//  Created by kenney on 6/27/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "Nutrition.h"

@implementation Nutrition

@dynamic name;
@dynamic description;
@dynamic url;
@dynamic size;
@dynamic price;
@dynamic picture;


+(NSString *)parseClassName{
    return @"Nutrition";
}

@end
