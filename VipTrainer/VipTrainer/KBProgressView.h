//
//  KBProgressView.h
//  VipTrainer
//
//  Created by kenney on 7/20/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBViewController.h"

@interface KBProgressView : KBViewController
@property (weak, nonatomic) IBOutlet UILabel *muscleGroupLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UITextField *measurementField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
- (IBAction)next:(id)sender;
- (IBAction)back:(id)sender;

@property (nonatomic) int pageIndex;

@end
