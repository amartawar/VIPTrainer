//
//  KBChooseTrainerCell.h
//  VipTrainer
//
//  Created by kenney on 4/3/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASStarRatingView.h"

@interface KBChooseTrainerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet ASStarRatingView *ratingView;
@property (weak, nonatomic) IBOutlet UIButton *viewCertificationsButton;

@end
