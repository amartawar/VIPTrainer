//
//  Condition.m
//  VipTrainer
//
//  Created by kenney on 4/6/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "Meal.h"
#import "NSDictionary+JSON.h"

@implementation Meal


@synthesize name;
@synthesize description;
@synthesize calories;

-(id)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    
    if(self){
            self.name = [dictionary objectForKey:@"name"];
            self.description = [dictionary objectForKey:@"description"];
            self.calories = [dictionary objectForKey:@"calories"];
    }
    return self;
}

-(NSString *)getMealString{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:self.name forKey:@"name"];
    [dictionary setObject:self.description forKey:@"description"];
    [dictionary setObject:self.calories forKey:@"calories"];
    
    
    return [dictionary jsonStringWithPrettyPrint:YES];
}

-(id)init{
    self = [super init];
    if(self){
        name = @"";
        description = @"";
        calories = @"";
    }
    return self;
}



@end
