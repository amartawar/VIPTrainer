//
//  KBClientCell.h
//  VipTrainer
//
//  Created by kenney on 4/6/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXBlurView.h"
#import "KBCircleImageView.h"

@interface KBClientCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet FXBlurView *blurView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end
