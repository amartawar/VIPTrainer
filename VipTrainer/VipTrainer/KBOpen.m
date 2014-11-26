//
//  KBOpen.m
//  VipTrainer
//
//  Created by kenney on 3/30/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBOpen.h"
#import "KBSplitViewController.h"

@interface KBOpen ()

@end

@implementation KBOpen

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        
        

    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    //[APPDELEGATE setGreenBackground];
    [super viewWillAppear:animated];
    
    [DATA reset];
    
    [self.navigationController setNavigationBarHidden:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disableMenu" object:nil];
}

- (void)viewDidLoad
{
    
    self.email.text = @"trainer@gmail.com";
    self.password.text = @"zxcvbnm";
    
    [self.loginButton setColor:darkGray];
    
    [PFUser logOut];
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"green.png"]];
    [super viewDidLoad];
    
    //self.navigationController.navigationBar.tintColor = vipBrightGreen;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signup:(id)sender {
    
    //[APPDELEGATE setLightBackground];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Signup" bundle:nil];
    UIViewController *controller = [storyboard instantiateInitialViewController];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)chooseClient:(id)sender {
    DATA.user.type = @"client";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Signup" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"profile"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)chooseTrainer:(id)sender {
    DATA.user.type = @"trainer";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Signup" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"profile"];
    [self.navigationController pushViewController:controller animated:YES];}

-(BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (IBAction)login:(id)sender {
    
    
    [self showProgress:@"Signing in"];
    [User logInWithUsernameInBackground:[self.email.text lowercaseString] password:self.password.text
                                    block:^(PFUser *user, NSError *error) {
                                        [self hideProgress];
                                        if (user) {
                                            
                                            KBSplitViewController *split = (KBSplitViewController *)self.navigationController.parentViewController;
                                            
                                            DATA.user = (User *)user;
                                            
                                            //[APPDELEGATE setLightBackground];
                                            [[NSNotificationCenter defaultCenter] postNotificationName:@"enableMenu" object:nil];
                                            
                                            if([DATA.user.type isEqualToString:@"trainer"]){
                                                [split loadTrainerSideMenu];
                                                
                                            

                                            }
                                            else if([DATA.user.type isEqualToString:@"client"]){
                                                [split loadClientSideMenu];
                                                
                                                /*UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Workout" bundle:nil];
                                                UIViewController *controller = [storyboard instantiateInitialViewController];
                                                [self.navigationController pushViewController:controller animated:YES];
                                                
                                                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Client" bundle:nil];
                                                UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"chooseTrainer"];
                                                [self.navigationController pushViewController:controller animated:YES];*/
                                                
                                
                                            }
    
                                            
                                            /*if(!([[user objectForKey:@"emailVerified"] boolValue] || [[user objectForKey:@"manualVerified"] boolValue])){
                                                NSString *message = [NSString stringWithFormat:@"Please Check %@ to Verify Your Email", [user objectForKey:@"email"]];
                                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Account Not Yet Verified" message:message delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
                                                [alert show];
                                            }
                                            else{
                                                
                                                
                                                [[NSUserDefaults standardUserDefaults] setObject:user.email forKey:@"usernames"];
                                                DebugLog([[NSUserDefaults standardUserDefaults] objectForKey:@"usernames"]);
                                                
                                                [[KBData sharedInstance] setUser:[[User alloc] initWithObject:user]];
                                                
                                                
                                                NSString *type = [user objectForKey:@"store_type"];
                                                DebugLog(@"Login Successful: %@", [user objectForKey:@"store_type"]);
                                                
                                                
                                                if([type isEqualToString:@"seller"])
                                                    [self performSegueWithIdentifier:@"loginToSeller" sender:nil];
                                                else if([type isEqualToString:@"buyer"])
                                                    [self performSegueWithIdentifier:@"loginToBuyer" sender:nil];
                                            }*/
                                            

                                            
                                        } else {
                                            [self showMessage:[error.userInfo valueForKey:@"error"]];
                                            DebugLog(@"FAILED TO LOGIN: %@", [error.userInfo valueForKey:@"error"]);
                                            
                                        }
                                    }];
    
    
    
    
    
    

}
@end
