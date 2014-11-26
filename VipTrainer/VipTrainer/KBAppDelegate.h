//
//  KBAppDelegate.h
//  VipTrainer
//
//  Created by kenney on 3/18/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) UIImageView *backgroundImage;
-(void)setLightBackground;//Sets the background to light green. (Unused, was an expiriment in saving memory by re-using background images)
-(void)setGreenBackground; //Sets the background to white. (mostly unused)
@end
