//
//  KBChooseTrainer.h
//  VipTrainer
//
//  Created by kenney on 4/2/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASStarRatingView.h"

@interface KBChooseTrainer : KBViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
- (IBAction)done:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *viewCertifications;
@property (weak, nonatomic) IBOutlet ASStarRatingView *ratingView;

@end
