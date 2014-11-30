//
//  KBSignup.h
//  VipTrainer
//
//  Created by kenney on 4/1/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBViewController.h"
#import "KBCircleImageView.h"
#import "KBInterestsList.h"

@interface KBBasicProfileTrainerSelections : KBViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)IBOutlet UITableView *tableSelection;
@property(nonatomic,strong)NSMutableArray *arraySelections;
@property(nonatomic,assign)int selectionsFor;


@end
