//
//  KBTrainerProfile.m
//  VipTrainer
//
//  Created by kenney on 4/6/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBTrainerSummary.h"
#import "KBRateComment.h"
#import "KBOpen.h"

@interface KBTrainerSummary ()

@end

@implementation KBTrainerSummary
@synthesize user;

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

-(void)viewWillAppear:(BOOL)animated{
    
    DebugLog(@"loading Trainer Info");
    
    [self.user refresh];
    self.specialtiesTableHeight.constant = self.user.interests.count * 44;
    self.certificationTableHeight.constant = self.user.certifications.count * 44;
    self.priceLabel.text = self.user.hourly_rate;
    
    DebugLog(@"setting height: %f", self.specialtiesTableHeight.constant);
    DebugLog(@"setting height certificationTableHeight: %f", self.certificationTableHeight.constant);
    [self.specialtiesTable layoutIfNeeded];
    [self.certificationsTable layoutIfNeeded];
    [self.view layoutSubviews];
    
    self.profilepicImage.file = self.user.profilePicThumb;
    [self.profilepicImage loadInBackground];
    
    if(DATA.partnership.trainer){
        [self.requestTrainerButton setTitle:@"Request Another Session" forState:UIControlStateNormal];
        [self.requestTrainerButton setTitle:@"Request Another Session" forState:UIControlStateDisabled];
        [self.requestTrainerButton setTitle:@"Request Another Session" forState:UIControlStateHighlighted];
    }
    else{
        
    }
    
    self.ratingView.rating = [self.user.rating floatValue];
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", self.user.firstName, self.user.lastName];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(alertView.tag == 2){
        for(UIViewController *controller in self.navigationController.viewControllers){
            if([controller isKindOfClass:[KBOpen class]]){
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Signup" bundle:nil];
                UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"questionnaire"];
                [self.navigationController pushViewController:controller animated:YES];
                return;
            }
        }
    }
    else{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Trainer" bundle:nil];
        UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"chooseTrainer"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    

    
    
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *cellIdentifier = @"specialtiesCellIdentifier";
    
    UITableViewCell *cell = [self.specialtiesTable dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if(tableView == self.specialtiesTable){
        cell.textLabel.text = self.user.interests[indexPath.row];
    }
    else{
        cell.textLabel.text = self.user.certifications[indexPath.row];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.specialtiesTable)
        return self.user.interests.count;
    else{
        return self.user.certifications.count;
    }
}

- (IBAction)requestTrainer:(id)sender {
    
    
    if(DATA.partnership.trainer){

    }
    else{
        Partnership *partnership = [Partnership object];
        partnership.client = [User currentUser];
        partnership.trainer = self.user;
        
        [self showProgress:@"Saving Trainer"];
        [partnership saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [self hideProgress];
            if(!error){
                DATA.partnership = partnership;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Trainer request sent!" message:@"We will notify you when your trainer accepts" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert setTintColor:vipBrightGreen];
                alert.tag = 2;
                [alert show];
                return;
                
            }
            else{
                
            }
        }];
    }

    
    
    
}
- (IBAction)Rate:(id)sender {
    KBRateComment *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"rate"];
    controller.user = self.user;
    
    [self.navigationController pushViewController:controller animated:YES];
}
@end
