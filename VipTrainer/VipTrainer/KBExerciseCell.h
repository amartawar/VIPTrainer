//
//  KBExerciseCell.h
//  VipTrainer
//
//  Created by kenney on 4/2/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBExerciseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *setsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *repsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *restLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@property (weak, nonatomic) IBOutlet UIView *commentsView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *muscleGroupLabel;
@property (weak, nonatomic) IBOutlet KBToggle *finishedToggle;
-(float)getHeight;

@end
