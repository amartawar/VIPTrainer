//
//  KBClientDashboard.h
//  VipTrainer
//
//  Created by kenney on 4/17/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <Parse/Parse.h>
#import "KBCircleImageView.h"

@interface KBTrainerClientDashboard : KBViewController
@property (weak, nonatomic) IBOutlet KBCircleImageView *profilePic;
- (IBAction)workouts:(id)sender;
- (IBAction)mealPlans:(id)sender;
- (IBAction)assessments:(id)sender;
- (IBAction)profile:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
- (IBAction)chat:(id)sender;

@end
