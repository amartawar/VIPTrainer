//
//  KBTrainerProfile.h
//  VipTrainer
//
//  Created by kenney on 4/6/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASStarRatingView.h"


@interface KBTrainerSummary : KBViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet PFImageView *profilepicImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
- (IBAction)Rate:(id)sender;
@property (weak, nonatomic) IBOutlet ASStarRatingView *ratingView;
@property (weak, nonatomic) IBOutlet ASStarRatingView *certificationView;
@property (weak, nonatomic) IBOutlet UITableView *specialtiesTable;
@property (nonatomic, strong) User *user;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *specialtiesTableHeight;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *requestTrainerView;
@property (weak, nonatomic) IBOutlet UIButton *requestTrainerButton;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
- (IBAction)requestTrainer:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentToBottom;
@property (weak, nonatomic) IBOutlet UIButton *rateButton;
@property (weak, nonatomic) IBOutlet UITableView *certificationsTable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *certificationTableHeight;

@end
