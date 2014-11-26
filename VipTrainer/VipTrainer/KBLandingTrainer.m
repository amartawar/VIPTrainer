//
//  KBLandingTrainer.m
//  VipTrainer
//
//  Created by kenney on 6/27/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBLandingTrainer.h"
#import "KBSplitViewController.h"
#import "KBRatingViewer.h"

@interface KBLandingTrainer ()

@end

@implementation KBLandingTrainer{
    
}

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
    self.profilePic.file = [[User currentUser] profilePicThumb];
    [self.profilePic loadInBackground];
    
    [self loadClients];
    
    self.ratingView.rating = [[[User currentUser] rating] floatValue];
    
    
    self.title = [NSString stringWithFormat:@"%@ %@", [[User currentUser] firstName], [[User currentUser] lastName]];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)loadClients{
    [self showProgress:@"Loading Clients"];
    
    [DATA.partnerships removeAllObjects];
    
    
    PFQuery *query = [Partnership query];
    //[query whereKey:@"interests" containsAllObjectsInArray:DATA.user.interests];
    [query whereKey:@"trainer" equalTo:[User currentUser]];
    [query includeKey:@"client"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [self hideProgress];
        
        
        if(!error){
            
            DATA.partnerships = [NSMutableArray arrayWithArray:objects];
            
            int clientsAwaitingAcceptance=0;
            int clientsAwaitingWorkout=0;
            int clientsAwaitingAssessment=0;
            
            for(Partnership *p in objects){
                
                
                if(p.status == CLIENT_CHOSE_TRAINER){
            
                    clientsAwaitingAcceptance++;
                    
                }
                else if(p.status == CLIENT_COMPLETED_FITNESS_ASSESSMENT){
                    clientsAwaitingWorkout++;
                    
                }
                else if(p.status == CLIENT_FINISHED_WORKOUT){
                    clientsAwaitingAssessment++;
                    
                }
            }
            
            self.clientsCounter.text = [NSString stringWithFormat:@"%i", clientsAwaitingWorkout+clientsAwaitingAssessment];
            self.myNewClientsCounter.text = [NSString stringWithFormat:@"%i", clientsAwaitingAcceptance];
        }
        else{
            [self showMessage:@"Couldn't load clients"];
        }
    }];
    
}





- (IBAction)newClients:(id)sender {
    
}

- (IBAction)clients:(id)sender {
    KBSplitViewController *split = (KBSplitViewController *)self.navigationController.parentViewController;
    [split loadClients];
}

- (IBAction)nutrition:(id)sender {
    KBSplitViewController *split = (KBSplitViewController *)self.navigationController.parentViewController;
    [split loadNutrition];
}
- (IBAction)loadRatingPage:(id)sender {
    
    KBRatingViewer *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ratingViewer"];
    controller.trainer_id = CURRENTUSER.objectId;
    [self.navigationController pushViewController:controller animated:YES];
}
@end
