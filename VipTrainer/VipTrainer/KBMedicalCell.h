//
//  KBMedicalCell.h
//  VipTrainer
//
//  Created by kenney on 4/6/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBMedicalCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *affectedField;
@property (weak, nonatomic) IBOutlet UITextField *commentsField;
@property (weak, nonatomic) IBOutlet UIImageView *indicator;
-(void)setExpanded:(BOOL)expanded;
@end
