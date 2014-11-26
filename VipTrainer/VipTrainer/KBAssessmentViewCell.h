//
//  KBAssessmentViewCell.h
//  VipTrainer
//
//  Created by kenney on 7/28/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBAssessmentViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet KBToggle *checkbox;

@end
