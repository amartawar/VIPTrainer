//
//  KBViewController.h
//  VipTrainer
//
//  Created by kenney on 4/3/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

//Awesome custom view controller that adds pop-up messages, pop-up progress spinners, and auto-handles keyboard popping up.

// Put your view contents into a scrollview, and add vertical spacing constraint from the bottom most view to the bottom of the scrollview, give it an IBOutlet named "contentToBottom", and watch as your view magically moves up with the keyboard.



#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface KBViewController : UIViewController



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentToBottom;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *table;

@property (nonatomic) BOOL shouldRefresh;

-(BOOL)save;
-(void)showMessage:(NSString *)message;
-(void)showProgress:(NSString *)message;
-(void)hideProgress;
-(void)addDefaultBackground;
@property (nonatomic) MBProgressHUD *hud;
@property (nonatomic) BOOL *scrollUsingTable;
@end
