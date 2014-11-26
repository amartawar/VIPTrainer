//
//  KBQuestionanaire.h
//  VipTrainer
//
//  Created by kenney on 6/26/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBViewController.h"

@interface KBQuestionnaire : KBViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *submitAssessment;
@property (weak, nonatomic) IBOutlet KBToggle *howOftenToggle1;
@property (weak, nonatomic) IBOutlet KBToggle *howOftenToggle2;
@property (weak, nonatomic) IBOutlet KBToggle *howOftenToggle3;
@property (weak, nonatomic) IBOutlet KBToggle *howOftenToggle4;

@property (weak, nonatomic) IBOutlet KBToggle *howLongToggle1;
@property (weak, nonatomic) IBOutlet KBToggle *howLongToggle2;
@property (weak, nonatomic) IBOutlet KBToggle *howLongToggle3;
@property (weak, nonatomic) IBOutlet KBToggle *howLongToggle4;

@property (weak, nonatomic) IBOutlet UITextView *question3TextView;
@property (weak, nonatomic) IBOutlet UITextView *question4TextView;
@property (weak, nonatomic) IBOutlet UITextView *question5TextView;
@property (weak, nonatomic) IBOutlet UITextView *question6TextView;
@property (weak, nonatomic) IBOutlet UITextView *question7TextView;
@property (weak, nonatomic) IBOutlet UITextView *question8TextView;
- (IBAction)submit:(id)sender;

@end
