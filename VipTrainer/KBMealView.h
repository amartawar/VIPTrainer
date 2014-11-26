//
//  KBMealList.h
//  VipTrainer
//
//  Created by kenney on 7/28/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBViewController.h"
#import "Meal.h"
#import "MealPlan.h"

@interface KBMealView : KBViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic) MealPlan *mealPlan;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentToBottom;

@end
