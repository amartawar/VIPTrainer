//
//  KBProgressList.h
//  VipTrainer
//
//  Created by kenney on 7/20/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBViewController.h"

@interface KBProgressList : KBViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
- (IBAction)add:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addProgressHeightConstraint;
- (IBAction)save:(id)sender;
- (IBAction)add:(id)sender;
@property (nonatomic) BOOL isModal;

@end
