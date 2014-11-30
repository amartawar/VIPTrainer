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

@interface KBBasicProfileTrainerMenu : KBViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)IBOutlet UITableView *tableMenu;
@property(nonatomic,strong)NSMutableArray *arrayMenu;
@property(nonatomic,assign)int menuType;
@end
