//
//  KBAssessment.m
//  VipTrainer
//
//  Created by kenney on 5/16/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBAssessment.h"

@interface KBAssessment ()

@end

@implementation KBAssessment
@synthesize workout;

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

- (IBAction)go:(id)sender {
    
    NSString *text = self.textView.text;
    
    DebugLog(text);
    
    [self.textView setText:text];
    
    
    
}

- (IBAction)save:(id)sender {
    
    NSString *text = self.textView.text;
    
    [self.textView setText:text];
    
    [PFCloud callFunctionInBackground:@"AssessWorkout" withParameters:@{@"partnership_id" : DATA.partnership.objectId, @"workout_id" : workout.objectId, @"assessment" : text} block:^(NSString *result, NSError *error) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Assessment Submitted" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        alert.tag = 3;
        [alert show];
        
        if (!error) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [self showMessage:@"An Error Occurred"];
        }
    }];
}
@end
