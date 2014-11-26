//
//  KBExerciseBuilder.h
//  VipTrainer
//
//  Created by kenney on 4/16/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBViewController.h"
#import "KBSliderField.h"

@interface KBExerciseBuilder : KBViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentToBottom;
- (IBAction)save:(id)sender;
- (IBAction)presets:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionField;
@property (weak, nonatomic) IBOutlet UITextField *setsField;
@property (weak, nonatomic) IBOutlet UITextField *restField;
@property (weak, nonatomic) IBOutlet UITextField *repsField;
@property (weak, nonatomic) IBOutlet UITextField *weightField;
@property (weak, nonatomic) IBOutlet UITextField *timeField;
@property (weak, nonatomic) IBOutlet UITextField *commentsField;
@property (weak, nonatomic) IBOutlet UIImageView *exerciseImage;

- (IBAction)cancel:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *addImageIcon;
@property (nonatomic) int exerciseIndex;
- (IBAction)loadImage:(id)sender;

@end
