//
//  KBRateComment.h
//  VipTrainer
//
//  Created by kenney on 9/8/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBViewController.h"
#import "ASStarRatingView.h"

@interface KBRateComment : KBViewController
@property (weak, nonatomic) IBOutlet UITextView *commentsTextView;
@property (weak, nonatomic) IBOutlet ASStarRatingView *starsView;
@property (weak, nonatomic) IBOutlet PFImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *trainerName;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentToBottom;
- (IBAction)submit:(id)sender;
@property (nonatomic, strong) User *user;
@end
