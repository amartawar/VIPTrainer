//
//  KBAccountPrefernceViewController.m
//  VipTrainer
//
//  Created by Rahul Gupta on 29/11/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBAccountPrefernceViewController.h"

@interface KBAccountPrefernceViewController ()
@property (nonatomic,strong)IBOutlet UITextField *txtRate;
@property (nonatomic,strong)IBOutlet UITextField *txtEmail;
@property (nonatomic,strong)IBOutlet UILabel *lblSessionRate;

@end

@implementation KBAccountPrefernceViewController

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
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:self.txtEmail]) {
        
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    
    rect.origin.y -= 156;
    
    
    
    self.view.frame = rect;
    
    [UIView commitAnimations];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    
    rect.origin.y = 0;
    
    
    
    self.view.frame = rect;
    
    [UIView commitAnimations];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
