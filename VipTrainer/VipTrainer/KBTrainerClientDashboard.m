//
//  KBClientDashboard.m
//  VipTrainer
//
//  Created by kenney on 4/17/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBTrainerClientDashboard.h"
#import "Partnership.h"
#import "KBChatView.h"

@implementation KBTrainerClientDashboard{
    NSDateFormatter *dateformatter;
}



-(void)viewDidLoad{
    [super viewDidLoad];
    
    dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MMM d yyyy"];
    
    self.profilePic.file = DATA.partnership.client.profilePic;
    [self.profilePic loadInBackground];
    
    self.title = [NSString stringWithFormat:@"%@ %@", DATA.partnership.client.firstName, DATA.partnership.client.lastName];
    //self.lastNameLabel.text = DATA.partnership.client.lastName;
    self.ageLabel.text = DATA.partnership.client.birthday;
    self.startDateLabel.text = [dateformatter stringFromDate:DATA.partnership.createdAt];
    
    
    
    
}

- (IBAction)workouts:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Workout" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"workoutList2"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)mealPlans:(id)sender {
}

- (IBAction)assessments:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Workout" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"assessmentList"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)profile:(id)sender {
}
- (IBAction)chat:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Chat" bundle:nil];
    KBChatView *controller = [storyboard instantiateViewControllerWithIdentifier:@"chatView"];
    controller.partnership = DATA.partnership;
    [self.navigationController pushViewController:controller animated:YES];
}
@end
