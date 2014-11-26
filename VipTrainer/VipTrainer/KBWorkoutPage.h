//
//  KBWorkoutPage.h
//  VipTrainer
//
//  Created by kenney on 6/29/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBViewController.h"

@interface KBWorkoutPage : KBViewController
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *setsLabel;
@property (weak, nonatomic) IBOutlet UILabel *repsLabel;
@property (weak, nonatomic) IBOutlet UILabel *restLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet PFImageView *workoutImage;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UILabel *recommendedTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *skipButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
- (IBAction)play:(id)sender;
- (IBAction)skip:(id)sender;

@property (nonatomic) int exerciseIndex;

@end
