//
//  KBClientList.h
//  VipTrainer
//
//  Created by kenney on 4/6/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBClientCell.h"

@interface KBClientList2 : KBViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UILabel *noClientsLabel;
@property (weak, nonatomic) IBOutlet NSNumber *filterByType;

@property (nonatomic) BOOL shouldReload;

@end
