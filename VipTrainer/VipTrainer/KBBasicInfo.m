//
//  KBBasicInfo.m
//  VipTrainer
//
//  Created by kenney on 4/6/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBBasicInfo.h"

@interface KBBasicInfo ()

@end

@implementation KBBasicInfo

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
    
    
    self.firstname_field.text = [[User currentUser] firstName];
    self.lastname_field.text = [[User currentUser] lastName];
    self.phone_field.text = [[User currentUser] phone];
    self.email_field.text = [[User currentUser] email];
    self.age_field.text = [[User currentUser] age];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)changePassword:(id)sender {
}

- (IBAction)save:(id)sender {
    
    if(![self.firstname_field.text isValidNonEmptyString]){
        [self showMessage:@"Please enter a first name"];
        return;
    }
    if(![self.lastname_field.text isValidNonEmptyString]){
        [self showMessage:@"Please enter a last name"];
        return;
    }
    if(![self.email_field.text isValidNonEmptyString]){
        [self showMessage:@"Please enter an email"];
        return;
    }
    if(![self.phone_field.text isValidNonEmptyString]){
        [self showMessage:@"Please enter a phone number"];
        return;
    }
    
    if(![self.age_field.text isValidNonEmptyString]){
        [self showMessage:@"Please enter your age"];
        return;
    }
    
        
        
    [[User currentUser] setFirstName:self.firstname_field.text];
    [[User currentUser] setLastName:self.lastname_field.text];
    [[User currentUser] setEmail:self.email_field.text];
    [[User currentUser] setPhone:self.phone_field.text];
    [[User currentUser] setAge:self.age_field.text];
    [self showProgress:@"Saving"];
    
    [[User currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self hideProgress];
        
        if(!error){
            [self showMessage:@"Saved"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            if(error.code == 203)
                [self showMessage:@"This email is already in use"];
            else
                [self showMessage:@"Failed to Save"];
        }
    }];
    
}
@end
