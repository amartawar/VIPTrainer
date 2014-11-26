//
//  KBViewClient.h
//  VipTrainer
//
//  Created by kenney on 5/21/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBViewController.h"
#import "KBCircleImageView.h"

@interface KBClientSummary : KBViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;
@property (weak, nonatomic) IBOutlet KBCircleImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UIView *acceptView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentToBottom;
@property (weak, nonatomic) IBOutlet UIToolbar *acceptToolbar;
@property (weak, nonatomic) IBOutlet UITableView *medicalTable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *medicalTableHeight;
- (IBAction)accept:(id)sender;
- (IBAction)chat:(id)sender;
- (IBAction)decline:(id)sender;
@end
