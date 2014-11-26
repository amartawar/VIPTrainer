//
//  KBSplitViewController.h
//  VendevorIpad
//
//  Created by kyle barnes on 5/26/13.
//  Copyright (c) 2013 Kyle Barnes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBSideMenu_Trainer.h"
#import "KBSideMenu_Client.h"
@interface KBSplitViewController : UIViewController



@property (nonatomic, retain) IBOutlet UIView*   masterView;
@property (nonatomic, retain) IBOutlet UIView*   detailView;
@property (weak, nonatomic) IBOutlet UIView *splitView;
@property (weak, nonatomic) IBOutlet UIButton *Menu_Button;

@property (nonatomic, retain) UIViewController*   masterViewController;
@property (nonatomic, retain) UIViewController*   detailViewController;

- (void)addMasterController:(UIViewController*)controller animated:(BOOL)anim;
- (void)addDetailController:(UIViewController*)controller animated:(BOOL)anim;

-(void)loadClientSideMenu;
-(void)loadTrainerSideMenu;

- (IBAction)ShowMaster:(UISwipeGestureRecognizer *)recognizer;
- (IBAction)HideMaster;
- (IBAction)Toggle_Menu:(id)sender;
-(IBAction)toggleFullscreen:(id)sender;
- (IBAction)fullscreen:(id)sender;
- (IBAction)close:(id)sender;

-(void)loadClients;
-(void)loadNutrition;
-(void)loadChats;
-(void)loadLandingClient;
-(void)loadClientNutrition;
-(void)setLastControllerIndex:(int) index;
-(void)loadProgress;

-(void)loadTrainerProfile;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *masterWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *masterPositionConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailPositionConstraint;

-(void)transitionUpToController:(UIViewController*)controller animated:(BOOL)animated up:(BOOL)up;

@end
