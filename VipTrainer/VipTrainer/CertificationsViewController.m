//
//  CertificationsViewController.m
//  VipTrainer
//
//  Created by Rahul Gupta on 29/11/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "CertificationsViewController.h"

@interface CertificationsViewController ()
@property(nonatomic,strong)IBOutlet UITableView *tblClassic;
@property(nonatomic,strong)IBOutlet UITextField *txtAconym;
@property(nonatomic,strong)IBOutlet UITextField *txtDescription;

@end

@implementation CertificationsViewController

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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *workoutCellIdentifier = @"cell";
    
    UITableViewCell *cell = [self.tblClassic dequeueReusableCellWithIdentifier:workoutCellIdentifier];
    UILabel *lblDesc=(UILabel*)[cell.contentView viewWithTag:2];
    
   
        NSString *str=[NSString stringWithFormat:@"%@",@"American Council On Exercise"];
    
    NSString *strSub=[NSString stringWithFormat:@"%@",@"ACE:"];
   
    
    
    NSString *strWithSuperscript=[NSString stringWithFormat:@"%@ %@",strSub,str];
    NSMutableAttributedString *subcriber = [[NSMutableAttributedString alloc] initWithString:strWithSuperscript];
    
    
        [subcriber addAttribute:NSFontAttributeName
                          value:[UIFont fontWithName:@"Helvetica-Bold" size:14.0]
                          range:NSMakeRange(0, [strSub length])];
//    
//    [subcriber addAttribute:NSFontAttributeName
//                      value:[UIFont fontWithName:@"Helvetica" size:12.0]
//                      range:NSMakeRange([strSub length], [str length])];
//    
   
    
    // change color
    //[subcriber addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange([@"ACE:" length], [str length] +1)];
    
    // super script
    NSMutableAttributedString *attString=[[NSMutableAttributedString alloc] initWithAttributedString:subcriber];
    
    //[attString addAttribute:(NSString *)kCTSuperscriptAttributeName value:@1 range:NSMakeRange([str length], [bit.priorityText length] +1)];
    lblDesc.attributedText=attString;
    return cell;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    
    rect.origin.y -= 156;
    
    
    
    self.view.frame = rect;
    
    [UIView commitAnimations];
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
