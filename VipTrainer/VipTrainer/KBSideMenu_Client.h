//
//  KBSideMenu.h
//  VipTrainer
//
//  Created by kenney on 3/30/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBCircleImageView.h"

@interface KBSideMenu_Client : UIViewController

- (IBAction)today:(id)sender;
- (IBAction)week:(id)sender;
- (IBAction)chats:(id)sender;
- (IBAction)profile:(id)sender;
- (IBAction)settings:(id)sender;
- (IBAction)trainer:(id)sender;
- (IBAction)logout:(id)sender;
- (IBAction)home:(id)sender;
- (IBAction)nutrition:(id)sender;
- (IBAction)progress:(id)sender;
@property (weak, nonatomic) IBOutlet KBCircleImageView *imageView;

-(void)refreshCounters;

-(void)open;
@end
