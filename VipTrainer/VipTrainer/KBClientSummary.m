//
//  KBViewClient.m
//  VipTrainer
//
//  Created by kenney on 5/21/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBClientSummary.h"
#import "KBChatView.h"
#import "KBClientList2.h"

@interface KBClientSummary ()

@end

@implementation KBClientSummary

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
    
    self.profilePicture.imageView.file = DATA.partnership.client.profilePic;
    self.firstNameLabel.text = DATA.partnership.client.firstName;
    self.lastNameLabel.text = DATA.partnership.client.lastName;
    
    self.ageLabel.text = DATA.partnership.client.age;
    self.emailLabel.text = DATA.partnership.client.email;
    self.phoneNumber.text = DATA.partnership.client.phone;
    
    [self.profilePicture loadInBackground];
    
    self.medicalTableHeight.constant = DATA.partnership.client.conditions.count?  DATA.partnership.client.conditions.count * 60 : 60;
    
    [self.medicalTable layoutIfNeeded];
    [self.view layoutIfNeeded];
    
    if(DATA.partnership.status != CLIENT_COMPLETED_INTERVIEW)
        self.acceptToolbar.hidden = YES;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)accept:(id)sender {
    
    NSString *message = [NSString stringWithFormat:@"Accept %@?", DATA.partnership.client.firstName];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Accept",nil];
    [alert setTintColor:vipBrightGreen];
    alert.tag = 2;
    [alert show];
}

- (IBAction)decline:(id)sender {
    
    NSString *message = [NSString stringWithFormat:@"Decline %@?", DATA.partnership.client.firstName];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Decline",nil];
    [alert setTintColor:vipBrightGreen];
    alert.tag = 3;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(alertView.tag == 2 && buttonIndex == [alertView firstOtherButtonIndex]){
        DATA.partnership.status = TRAINER_ACCEPTED_CLIENT;
        
        [self showProgress:@"Accepting Client"];
        
        DATA.partnership.status = TRAINER_ACCEPTED_CLIENT;
        DATA.partnership.awaitingNutrition = [NSNumber numberWithBool:YES];
        DATA.partnership.awaitingFitnessAssessment = [NSNumber numberWithBool:YES];
        DATA.partnership.awaitingMealPlan = [NSNumber numberWithBool:YES];
        
        [DATA.partnership saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [self hideProgress];
            
            if(!error){
                [self showMessage:@"Client Accepted"];
                [self closeWithRefresh];
            }
            else{
                [self showMessage:@"Failed to Accept Client"];
            }
        }];
        
    }
    else if(alertView.tag == 3 && buttonIndex == [alertView firstOtherButtonIndex]){
        
        DATA.partnership.status = TRAINER_DENIED_CLIENT;
        
        [self showProgress:@"Declining Client"];
        [DATA.partnership saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [self hideProgress];
            
            if(!error){
                [self showMessage:@"Client Declined"];
                [self closeWithRefresh];
            }
            else{
                [self showMessage:@"Failed to Decline Client"];
            }
        }];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return DATA.partnership.client.conditions.count? DATA.partnership.client.conditions.count :  1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"clientSummaryMedicalCellIdentifier";
    
    UITableViewCell *cell = [self.medicalTable dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if(DATA.partnership.client.conditions.count == 0)
        cell.textLabel.text = @"No Medical Conditions";
    else
        cell.textLabel.text = DATA.partnership.client.conditions[indexPath.row];
    
    return cell;
}

-(void)closeWithRefresh{
    
    //Checks if the view controller above is the client list, and tells it to refresh
    for(int i = 0; i < self.navigationController.viewControllers.count; i++){
        UIViewController *v = self.navigationController.viewControllers[i];
        if(v.class == self.class){
            if([self.navigationController.viewControllers[i-1] isKindOfClass:KBClientList2.class]){
                KBClientList2 *controller = self.navigationController.viewControllers[i-1];
                controller.shouldReload = YES;
            }
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)chat:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Chat" bundle:nil];
    KBChatView *controller = [storyboard instantiateViewControllerWithIdentifier:@"chatView"];
    controller.partnership = DATA.partnership;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
