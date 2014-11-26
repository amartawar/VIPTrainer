//
//  KBWorkoutCell.h
//  VipTrainer
//
//  Created by kenney on 5/15/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBToggle.h"

@interface KBWorkoutCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sessionName;
@property (weak, nonatomic) IBOutlet PFImageView *sessionImage;
@property (weak, nonatomic) IBOutlet KBToggle *workoutCheckbox;
@property (weak, nonatomic) IBOutlet KBToggle *assessmentCheckbox;

@end
