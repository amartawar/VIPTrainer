//
//  KBMealListCell.h
//  VipTrainer
//
//  Created by kenney on 7/28/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBMealListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UITextField *calorieField;
@property (weak, nonatomic) IBOutlet UITextField *titleField;

@end
