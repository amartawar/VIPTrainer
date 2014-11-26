//
//  KBBasicInfo.h
//  VipTrainer
//
//  Created by kenney on 4/6/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBViewController.h"

@interface KBBasicInfo : KBViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentToBottom;
@property (weak, nonatomic) IBOutlet UITextField *firstname_field;
@property (weak, nonatomic) IBOutlet UITextField *lastname_field;
@property (weak, nonatomic) IBOutlet UITextField *phone_field;
@property (weak, nonatomic) IBOutlet UITextField *age_field;
@property (weak, nonatomic) IBOutlet UITextField *email_field;
- (IBAction)changePassword:(id)sender;
- (IBAction)save:(id)sender;

@end
