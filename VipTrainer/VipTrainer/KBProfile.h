//
//  KBProfile.h
//  VipTrainer
//
//  Created by kenney on 4/6/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBViewController.h"
#import "KBCircleImageView.h"

@interface KBProfile : KBViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
- (IBAction)basicInfo:(id)sender;
@property (weak, nonatomic) IBOutlet KBCircleImageView *profilePic;
- (IBAction)loadTargets:(id)sender;
- (IBAction)loadRatings:(id)sender;
- (IBAction)loadFinancials:(id)sender;
- (IBAction)loadQualifications:(id)sender;

@end
