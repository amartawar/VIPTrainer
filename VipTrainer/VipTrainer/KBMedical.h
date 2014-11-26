//
//  KBMedical.h
//  VipTrainer
//
//  Created by kenney on 4/6/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBViewController.h"

@interface KBMedical : KBViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
- (IBAction)save:(id)sender;
- (IBAction)add:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *noConditionsButton;

@end
