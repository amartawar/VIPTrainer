//
//  KBSideMenu.m
//  VipTrainer
//
//  Created by kenney on 3/30/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBSideMenu_Client.h"

@interface KBSideMenu_Client ()

@end

@implementation KBSideMenu_Client

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.view.translatesAutoresizingMaskIntoConstraints=NO;
    
    
    if([PFUser currentUser]){
        self.imageView.file = [[User currentUser] profilePicThumb];
        [self.imageView loadInBackground];
    }
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshCounters{
    
}

- (IBAction)today:(id)sender {
    [self.parentViewController performSelector:@selector(loadToday)];
}

- (IBAction)week:(id)sender {
    [self.parentViewController performSelector:@selector(loadWeek)];
}

- (IBAction)chats:(id)sender {
    [self.parentViewController performSelector:@selector(loadChats)];
}

- (IBAction)profile:(id)sender {
    [self.parentViewController performSelector:@selector(loadProfile)];
}

- (IBAction)settings:(id)sender {
    [self.parentViewController performSelector:@selector(loadSettings)];
}

- (IBAction)trainer:(id)sender {
    [self.parentViewController performSelector:@selector(loadTrainer)];
}

- (IBAction)logout:(id)sender {
    [self.parentViewController performSelector:@selector(logout)];
}

- (IBAction)home:(id)sender {
    [self.parentViewController performSelector:@selector(loadLandingClient)];
}

- (IBAction)nutrition:(id)sender {
    [self.parentViewController performSelector:@selector(loadClientNutrition)];
}

- (IBAction)progress:(id)sender {
        [self.parentViewController performSelector:@selector(loadProgress)];
}

@end
