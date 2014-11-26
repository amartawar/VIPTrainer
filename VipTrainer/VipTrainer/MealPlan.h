//
//  Meal.h
//  VipTrainer
//
//  Created by kenney on 7/28/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <Parse/Parse.h>

@interface MealPlan : PFObject <PFSubclassing>
+(NSString *)parseClassName;
@property (nonatomic) NSMutableArray *meals;
@end
