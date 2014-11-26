//
//  KBPricing.m
//  VipTrainer
//
//  Created by kenney on 4/16/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBPricing.h"

@interface KBPricing ()

@end

@implementation KBPricing

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

- (IBAction)done:(id)sender {
    
    if(self.hourlyRateField.text.length == 0){
        [self showMessage:@"Please enter an hourly rate"];
        return;
    }
    
    if(self.paypalEmailField.text.length == 0){
        [self showMessage:@"Please enter a paypal address"];
        return;
    }
    
    CURRENTUSER.paypal_email = self.paypalEmailField.text;
    CURRENTUSER.hourly_rate = self.hourlyRateField.text;
    
    [self showProgress:@"Saving"];
    
    [CURRENTUSER saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self hideProgress];
        if(!error){
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else{
            [self showMessage:@"Unable to save"];
        }
    }];
    
    
}
@end
