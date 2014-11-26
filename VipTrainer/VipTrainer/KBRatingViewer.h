//
//  KBRatingViewer.h
//  VipTrainer
//
//  Created by kenney on 9/8/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBViewController.h"
#import "ASStarRatingView.h"

@interface KBRatingViewer : KBViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UILabel *numberOfRatingsLabel;
@property (weak, nonatomic) IBOutlet ASStarRatingView *starView;
@property (nonatomic) NSString *trainer_id;

@end
