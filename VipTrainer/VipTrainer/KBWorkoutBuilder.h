//
//  KBWorkoutBuilder.h
//  VipTrainer
//
//  Created by kenney on 4/16/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Workout.h"
#import "KBExerciseCell.h"
#import "FXBlurView.h"

@interface KBWorkoutBuilder : KBViewController

@property (weak, nonatomic) IBOutlet UITableView *table;
//@property (nonatomic) Workout *workout;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;


- (IBAction)close:(id)sender;
- (IBAction)add:(id)sender;
- (IBAction)addRest:(id)sender;
- (IBAction)save:(id)sender;
-(IBAction)closeWithRefresh:(id)sender;

@property (weak, nonatomic) IBOutlet FXBlurView *blurView;
@property (weak, nonatomic) IBOutlet UIView *tintView;

@end
