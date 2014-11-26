//
//  KBSideMenu.m
//  VipTrainer
//
//  Created by kenney on 3/30/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBSideMenu_Trainer.h"

@interface KBSideMenu_Trainer ()

@end

@implementation KBSideMenu_Trainer

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
    self.view.translatesAutoresizingMaskIntoConstraints=NO;
    
    if([PFUser currentUser]){
        self.imageView.file = [[User currentUser] profilePicThumb];
        [self.imageView loadInBackground];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshNotifications) name:@"reloadNotifications" object:nil];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)loadNotifications{
    PFQuery *query = [Notification query];
    //[query whereKey:@"interests" containsAllObjectsInArray:DATA.user.interests];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            [DATA.notifications removeAllObjects];
            [DATA.notifications addObjectsFromArray:objects];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadNotifications" object:nil];
        }
        else{
            
        }
    }];
}
-(void)refreshNotifications{
    int chats = 0 ;
    int feedback = 0;
    int clients = 0;
    int products = 0;
    int meals = 0;
    
    for(Notification *n in DATA.notifications){
        if([n.type isEqualToString:CHAT_NOTIFICATION]){
            chats++;
        }
        if([n.type  isEqualToString:COMPLETED_WORKOUT_NOTIFICATION]){
            feedback++;
        }
        if([n.type isEqualToString:NEW_CLIENT_REQUEST_NOTIFICATION]){
            clients++;
        }
        if([n.type isEqualToString:NEW_CLIENT_REQUEST_NOTIFICATION]){
            products++;
        }
        if([n.type isEqualToString:NEW_CLIENT_REQUEST_NOTIFICATION]){
            meals++;
        }
    }
    
    if(chats)
        self.chatsTag.text = [NSString stringWithFormat:@"%i", chats];
    if(feedback)
        self.feedbackTag.text = [NSString stringWithFormat:@"%i", feedback];
    if(clients)
        self.mNewClientsTag.text = [NSString stringWithFormat:@"%i", clients];
    if(products)
        self.productsTag.text = [NSString stringWithFormat:@"%i", products];
    if(meals)
        self.mealPlansTag.text = [NSString stringWithFormat:@"%i", meals];
}

-(void)refreshCounters{
    
    //@property (weak, nonatomic) IBOutlet UILabel *mNewClientsTag;
    //@property (weak, nonatomic) IBOutlet UILabel *feedbackTag;
   // @property (weak, nonatomic) IBOutlet UILabel *productsTag;
   //@property (weak, nonatomic) IBOutlet UILabel *mealPlansTag;
    //@property (weak, nonatomic) IBOutlet UILabel *chatsTag;
    
    int clientsAwaitingAcceptance=0;
    int clientsAwaitingInitialAssessment=0;
    int clientsAwaitingWorkout=0;
    int clientsAwaitingAssessment=0;
    int clientsAwaitingProducts=0;
    int clientsAwaitingMealPlan=0;
    int clientNewChats = 0;
    
    for(Partnership *p in DATA.partnerships){
        
        
        if(p.status == CLIENT_CHOSE_TRAINER){
            
            clientsAwaitingAcceptance++;
            
        }
        else if(p.status == TRAINER_ACCEPTED_CLIENT){
            clientsAwaitingAcceptance++;
        }
        else if(p.status == CLIENT_COMPLETED_FITNESS_ASSESSMENT){
            clientsAwaitingWorkout++;
            
        }
        else if(p.status == CLIENT_FINISHED_WORKOUT){
            clientsAwaitingAssessment++;
            
        }
        
        if(p.recommendedProducts.count == 0){
            clientsAwaitingProducts++;
        }
    }
    
    self.mNewClientsTag.text = clientsAwaitingAcceptance? [NSString stringWithFormat:@"%i", clientsAwaitingAcceptance] : @"";
    self.feedbackTag.text = clientsAwaitingAssessment? [NSString stringWithFormat:@"%i", clientsAwaitingAssessment] : @"";
    self.productsTag.text = clientsAwaitingProducts? [NSString stringWithFormat:@"%i", clientsAwaitingProducts] : @"";
    self.mealPlansTag.text = clientsAwaitingMealPlan? [NSString stringWithFormat:@"%i", clientsAwaitingMealPlan] : @"";
    self.chatsTag.text = clientNewChats? [NSString stringWithFormat:@"%i", clientNewChats] : @"";
    self.workoutTag.text = clientsAwaitingWorkout? [NSString stringWithFormat:@"%i", clientsAwaitingWorkout] : @"";
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clients:(id)sender {
    [self.parentViewController performSelector:@selector(loadClients)];
}

- (IBAction)openNewClients:(id)sender {
    [self.parentViewController performSelector:@selector(loadNewClients)];
}

- (IBAction)workout:(id)sender {
    [self.parentViewController performSelector:@selector(loadNeedsWorkout)];
}

- (IBAction)chats:(id)sender {
    [self.parentViewController performSelector:@selector(loadChats)];
}

- (IBAction)profile:(id)sender {
    [self.parentViewController performSelector:@selector(loadTrainerProfile)];
}

- (IBAction)settings:(id)sender {
    [self.parentViewController performSelector:@selector(loadSettings)];
}

- (IBAction)logout:(id)sender {
    [self.parentViewController performSelector:@selector(logout)];
}



- (IBAction)feedback:(id)sender {
    [self.parentViewController performSelector:@selector(loadFeedback)];
}

- (IBAction)products:(id)sender {
    [self.parentViewController performSelector:@selector(loadNutrition)];
}
- (IBAction)meals:(id)sender {
[self.parentViewController performSelector:@selector(loadMeals)];
}
@end
