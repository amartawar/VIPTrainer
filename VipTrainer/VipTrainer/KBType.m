//
//  KBType.m
//  VipTrainer
//
//  Created by kenney on 4/4/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBType.h"

@interface KBType ()

@end

@implementation KBType

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chooseClient:(id)sender {
    DATA.user.type = @"client";
    [self performSegueWithIdentifier:@"loadBasicInfo" sender:nil];
}

- (IBAction)chooseTrainer:(id)sender {
    DATA.user.type = @"trainer";
    [self performSegueWithIdentifier:@"loadBasicInfo" sender:nil];
}
@end
