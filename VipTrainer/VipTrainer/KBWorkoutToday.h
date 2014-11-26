
//
//  KBWorkoutBuilder.h
//  VipTrainer
//
//  Created by kenney on 4/2/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <Parse/Parse.h>
#import "KBExerciseCell.h"

@interface KBWorkoutToday : KBViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UILabel *noWorkoutsLabel;
@property (weak, nonatomic) IBOutlet UIButton *startButton;


-(NSString*)getNextExercise;
- (IBAction)play:(id)sender;
- (IBAction)skip:(id)sender;
- (IBAction)submit:(id)sender;
- (IBAction)start:(id)sender;
- (IBAction)quit:(id)sender;

@end
