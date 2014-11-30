//
//  KBSignup.m
//  VipTrainer
//
//  Created by kenney on 4/1/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBBasicProfileTrainerMenu.h"

@interface KBBasicProfileTrainerMenu ()
@end

@implementation KBBasicProfileTrainerMenu
@synthesize  tableMenu;
@synthesize arrayMenu;
@synthesize menuType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self decorateUI];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)decorateUI{
    self.title=@"VIP Trainer Profile";
}

#pragma Mark UITextFieldDelegate

@end
