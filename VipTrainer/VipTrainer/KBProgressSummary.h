//
//  KBProgressSummary.h
//  VipTrainer
//
//  Created by kenney on 7/20/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBViewController.h"
#import "Progress.h"
#import "KBCircleImageView.h"

@interface KBProgressSummary : KBViewController


@property (nonatomic) Progress *progress;
@property (weak, nonatomic) IBOutlet UIButton *takePictureButton;
- (IBAction)takePicture:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *neckLabel;
@property (weak, nonatomic) IBOutlet UILabel *shouldersLabel;
@property (weak, nonatomic) IBOutlet UILabel *chestLabel;
@property (weak, nonatomic) IBOutlet UILabel *bicepsLabel;
@property (weak, nonatomic) IBOutlet UILabel *forearmsLabel;
@property (weak, nonatomic) IBOutlet UILabel *waistLabel;
@property (weak, nonatomic) IBOutlet UILabel *thighsLabel;
@property (weak, nonatomic) IBOutlet UILabel *calvesLabel;
@property (weak, nonatomic) IBOutlet KBCircleImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyFatLabel;
- (IBAction)save:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *saveHeight;

@end
