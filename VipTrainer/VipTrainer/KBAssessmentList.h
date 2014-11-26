//
//  KBWorkoutList2.h
//  VipTrainer
//
//  Created by kenney on 5/15/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBViewController.h"

@interface KBAssessmentList : KBViewController
@property (weak, nonatomic) IBOutlet UITableView *table;
- (IBAction)newWorkout:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *noClientsLabel;
@end
