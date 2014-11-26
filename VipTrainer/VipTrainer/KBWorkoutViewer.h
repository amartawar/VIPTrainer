//
//  KBWorkoutViewer.h
//  VipTrainer
//
//  Created by kenney on 5/20/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Workout.h"
#import "KBExerciseCell.h"
#import "FXBlurView.h"

@interface KBWorkoutViewer : KBViewController
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic) Workout *workout;

- (IBAction)close:(id)sender;
- (IBAction)assess:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *assessView;
@property (weak, nonatomic) IBOutlet UIButton *assessButton;

@end
