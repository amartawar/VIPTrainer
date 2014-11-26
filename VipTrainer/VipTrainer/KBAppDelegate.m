//
//  KBAppDelegate.m
//  VipTrainer
//
//  Created by kenney on 3/18/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBAppDelegate.h"
#import "User.h"
#import "Workout.h"
#import "Partnership.h"
#import "Chat.h"
#import "Assessment.h"
#import "Notification.h"
#import "Nutrition.h"
#import "Progress.h"
#import "MealPlan.h"
#import "Rating.h"

@implementation KBAppDelegate{
    UIImage *greenImage;
    UIImage *greyImage;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //Registers the custom Parse classes. This tells Parse that they exist.
    [User registerSubclass];
    [Workout registerSubclass];
    [Partnership registerSubclass];
    [Chat registerSubclass];
    [Assessment registerSubclass];
    [Notification registerSubclass];
    [Nutrition registerSubclass];
    [Progress registerSubclass];
    [MealPlan registerSubclass];
    [Rating registerSubclass];
    
    //Sets our Parse account info
    [Parse setApplicationId:@"P0ajC9cGQ9vuszdDokkN5ypzVucPRoVyDD6D3TS0"
                  clientKey:@"3qLUIsx1DJG8k3xyEQP4vT5xWnwlDWSqZWxV0coh"];
    
    //Some UI Tweaks for themeing
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITextField appearance] setTintColor:vipDarkGray];
    [[UITextView appearance] setTintColor:vipDarkGray];
    [[UISegmentedControl appearance] setTintColor:vipBrightGreen];
    
    //These are loaded for the setBackground functions. Not really used
    greenImage = [UIImage imageNamed:@"green_background.png"];
    greyImage = [UIImage imageNamed:@"lightgrey_background.png"];
    self.backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"green_background.png"]];
    [self.backgroundImage setContentMode:UIViewContentModeScaleAspectFill];
    [self.backgroundImage setFrame:self.window.frame];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    //Changes NavigationBar text color to white
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"FontNAme" size:14], NSFontAttributeName, nil]];
    
    //Sets our NavigationBar Tint
    [[UINavigationBar appearance] setBarTintColor:vipBrightGreen];
    
    //[self.window insertSubview:self.backgroundImage belowSubview:self.window.rootViewController.view];
    
    return YES;
}

-(void)setLightBackground{
   // [self.backgroundImage setImage:greyImage];
}
-(void)setGreenBackground{
   // [self.backgroundImage setImage:greenImage];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
