//
//  KBSideMenu.h
//  VipTrainer
//
//  Created by kenney on 3/30/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBCircleImageView.h"

@interface KBSideMenu_Trainer : UIViewController

- (IBAction)clients:(id)sender;
- (IBAction)openNewClients:(id)sender;
- (IBAction)workout:(id)sender;
- (IBAction)chats:(id)sender;
- (IBAction)profile:(id)sender;
- (IBAction)settings:(id)sender;
- (IBAction)logout:(id)sender;
- (IBAction)feedback:(id)sender;
- (IBAction)products:(id)sender;
- (IBAction)meals:(id)sender;
@property (weak, nonatomic) IBOutlet KBCircleImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *mNewClientsTag;
@property (weak, nonatomic) IBOutlet UILabel *feedbackTag;
@property (weak, nonatomic) IBOutlet UILabel *productsTag;
@property (weak, nonatomic) IBOutlet UILabel *mealPlansTag;
@property (weak, nonatomic) IBOutlet UILabel *chatsTag;
@property (weak, nonatomic) IBOutlet UILabel *workoutTag;

-(void)refreshCounters;



-(void)open;
@end
