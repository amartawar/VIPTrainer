//
//  KBAssessmentEditor.h
//  VipTrainer
//
//  Created by kenney on 7/29/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBViewController.h"

@interface KBAssessmentEditor : KBViewController
@property (weak, nonatomic) IBOutlet UILabel *setsLabel;
@property (weak, nonatomic) IBOutlet UILabel *repsLabel;
@property (weak, nonatomic) IBOutlet UILabel *restLabel;
@property (weak, nonatomic) IBOutlet UILabel *completionTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UITextField *clientCommentsLabel;
@property (weak, nonatomic) IBOutlet UITextView *assessmentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentToBottom;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic) int exerciseIndex;

@end
