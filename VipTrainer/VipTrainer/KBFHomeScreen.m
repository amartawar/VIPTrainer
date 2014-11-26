//
//  KBFHomeScreen.m
//  VipTrainer
//
//  Created by AmitSanvedi on 22/11/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBFHomeScreen.h"

@implementation KBFHomeScreen

-(IBAction)GoToNextScreen:(id)sender{
        UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
