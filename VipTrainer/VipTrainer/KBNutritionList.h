//
//  KBNutritionList.h
//  VipTrainer
//
//  Created by kenney on 6/27/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBViewController.h"

@interface KBNutritionList : KBViewController
@property (nonatomic) NSMutableArray *nutritionArray;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
- (IBAction)submit:(id)sender;

@end
