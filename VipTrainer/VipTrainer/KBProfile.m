//
//  KBProfile.m
//  VipTrainer
//
//  Created by kenney on 4/6/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBProfile.h"
#import "KBRatingViewer.h"
#import "KBInterestsList.h"

@interface KBProfile ()

@end

@implementation KBProfile{
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        
    }
    return self;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [APPDELEGATE setLightBackground];
    
    if([PFUser currentUser]){
        self.profilePic.file = [[User currentUser] profilePicThumb];
        [self.profilePic loadInBackground];
    }
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"grey.png"]];
}


- (IBAction)basicInfo:(id)sender {
}
- (IBAction)loadTargets:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Signup" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"interestsList"];
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)loadRatings:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Trainer" bundle:nil];
    KBRatingViewer *controller = [storyboard instantiateViewControllerWithIdentifier:@"ratingViewer"];
    controller.trainer_id = CURRENTUSER.objectId;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)loadFinancials:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Signup" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"pricing"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)loadQualifications:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Signup" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"qualifications"];
    [self.navigationController pushViewController:controller animated:YES];
    
    
}
@end
