//
//  KBOpen.h
//  VipTrainer
//
//  Created by kenney on 3/30/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBRoundedRectButton.h"

@interface KBOpen : KBViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;
- (IBAction)signup:(id)sender;
- (IBAction)login:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentToBottom;
@property (weak, nonatomic) IBOutlet KBRoundedRectButton *loginButton;

@end
