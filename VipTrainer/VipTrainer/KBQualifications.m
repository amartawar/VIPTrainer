//
//  KBQualifications.m
//  VipTrainer
//
//  Created by kenney on 4/16/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBQualifications.h"

@interface KBQualifications ()

@end

@implementation KBQualifications

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

- (IBAction)next:(id)sender {
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"pricing"];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
