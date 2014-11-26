//
//  KBAssessmentView.h
//  VipTrainer
//
//  Created by kenney on 7/28/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBViewController.h"

@interface KBAssessmentView : KBViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentToBottom;
- (IBAction)save:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end
