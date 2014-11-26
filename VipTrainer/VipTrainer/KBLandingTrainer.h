//
//  KBLandingTrainer.h
//  VipTrainer
//
//  Created by kenney on 6/27/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBViewController.h"
#import "KBCircleImageView.h"
#import "ASStarRatingView.h"

@interface KBLandingTrainer : KBViewController
- (IBAction)newClients:(id)sender;
- (IBAction)clients:(id)sender;
- (IBAction)nutrition:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *myNewClientsCounter;
@property (weak, nonatomic) IBOutlet UILabel *clientsCounter;
@property (weak, nonatomic) IBOutlet UILabel *nutritionCounter;
@property (weak, nonatomic) IBOutlet KBCircleImageView *profilePic;
@property (weak, nonatomic) IBOutlet ASStarRatingView *ratingView;
- (IBAction)loadRatingPage:(id)sender;

@end
