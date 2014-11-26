//
//  KBSignup.h
//  VipTrainer
//
//  Created by kenney on 4/1/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBViewController.h"
#import "KBCircleImageView.h"
#import "KBInterestsList.h"

@interface KBBasic : KBViewController <KBInterestsDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderControl;
@property (weak, nonatomic) IBOutlet UIButton *birthdayButton;
- (IBAction)next:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentToBottom;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet KBCircleImageView *profilePictureImage;
- (IBAction)loadPicture:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *addPictureButton;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *confrimPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *ageField;
@property (weak, nonatomic) IBOutlet UITableView *tblMenu;

@end
