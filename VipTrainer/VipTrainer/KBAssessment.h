//
//  KBAssessment.h
//  VipTrainer
//
//  Created by kenney on 5/16/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBViewController.h"

@interface KBAssessment : KBViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic) Workout *workout;
- (IBAction)save:(id)sender;
- (IBAction)go:(id)sender;

@end
