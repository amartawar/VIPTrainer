//
//  KBLandingClient.h
//  VipTrainer
//
//  Created by kenney on 6/27/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBViewController.h"

@interface KBLandingClient : KBViewController
- (IBAction)chat:(id)sender;
- (IBAction)assessment:(id)sender;
- (IBAction)diet:(id)sender;
- (IBAction)nutrition:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *firstProgressLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondProgressLabel;
@property (weak, nonatomic) IBOutlet PFImageView *firstProgressImage;
@property (weak, nonatomic) IBOutlet PFImageView *secondProgressImage;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UIButton *startWorkoutButton;
- (IBAction)workout:(id)sender;
- (IBAction)takeFirstPic:(id)sender;
- (IBAction)takeProgressPic:(id)sender;
- (IBAction)addProgress:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *firstPicButton;
@property (weak, nonatomic) IBOutlet UIButton *progressPicButton;
@property (weak, nonatomic) IBOutlet UIButton *secondPicButton;

@end
