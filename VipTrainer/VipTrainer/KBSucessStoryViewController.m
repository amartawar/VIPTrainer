//
//  KBSucessStoryViewController.m
//  VipTrainer
//
//  Created by Rahul Gupta on 29/11/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBSucessStoryViewController.h"

@interface KBSucessStoryViewController ()
@property (nonatomic,strong)IBOutlet UITextField *txtTitle;
@property (nonatomic,strong)IBOutlet UIImageView *imgBefore;
@property (nonatomic,strong)IBOutlet UIImageView *imgAfter;
@property (nonatomic,strong)IBOutlet UITextView *txtSummary;
@property (strong, nonatomic) IBOutlet UILabel *lblWeightBefore;
@property (strong, nonatomic) IBOutlet UILabel *lblWeightAfter;
-(IBAction)doSaveAndNext:(id)sender;
@end

@implementation KBSucessStoryViewController

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
     self.title=@"VIP Trainer Profile";
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)doSaveAndNext:(id)sender
{
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    
    rect.origin.y -= 166;
    
    
    
    self.view.frame = rect;
    
    [UIView commitAnimations];
    
    
    
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
     if([text isEqualToString:@"\n"])
     {
         [textView resignFirstResponder];
         
         
     }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.6]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    
    rect.origin.y = 0;
    
    
    
    self.view.frame = rect;
    
    [UIView commitAnimations];

    return YES;
}
@end
