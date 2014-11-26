//
//  KBMealList.h
//  VipTrainer
//
//  Created by kenney on 7/29/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBViewController.h"
#import "Meal.h"
#import "MealPlan.h"

@interface KBMealList : KBViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;

@end
