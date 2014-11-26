//
//  KBClientNutrition.h
//  VipTrainer
//
//  Created by kenney on 6/30/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBViewController.h"

@interface KBClientNutrition : KBViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) NSMutableArray *nutritionArray;
@property (nonatomic) NSMutableArray *recommendNutritionArray;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@end
