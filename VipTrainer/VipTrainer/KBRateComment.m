//
//  KBRateComment.m
//  VipTrainer
//
//  Created by kenney on 9/8/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBRateComment.h"
#import "Rating.h"

@interface KBRateComment ()

@end

@implementation KBRateComment
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
    
    
    self.profilePic.file = self.user.profilePicThumb;
    [self.profilePic loadInBackground];

    
    self.starsView.rating = [self.user.rating floatValue];
    self.trainerName.text = [NSString stringWithFormat:@"%@ %@", self.user.firstName, self.user.lastName];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)submit:(id)sender {
    
    
    PFQuery *query = [Rating query];
    [query whereKey:@"client" equalTo:CURRENTUSER];
    [query whereKey:@"trainer_id" equalTo:self.user.objectId];
    
    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if(!error){
            
            if(number > 0){
                [self showMessage:@"You have already rated this trainer!"];
            }
            else{
                float oldRating = [self.user.rating floatValue];
                float numOfRatings = [self.user.numberOfRatings floatValue];
                float newRating = ((oldRating * numOfRatings) + self.starsView.rating) /(numOfRatings+1);
                
                DebugLog(@"oldRating: %f", oldRating);
                DebugLog(@"numOfRatings: %f", numOfRatings);
                DebugLog(@"newRating: %f", newRating);
                
                [PFCloud callFunctionInBackground:@"RateTrainer"
                                   withParameters:@{@"trainer_id": self.user.objectId,
                                                    @"comments": self.commentsTextView.text,
                                                    @"rating": [NSNumber numberWithFloat:self.starsView.rating],
                                                    @"average_rating": [NSNumber numberWithFloat:newRating]}
                                            block:^(NSArray *results, NSError *error) {
                                                [self hideProgress];
                                                if(!error){
                                                    [self showMessage:@"Rating submitted"];
                                                    [self.navigationController popViewControllerAnimated:YES];
                                                }
                                                else{
                                                    [self showMessage:@"Failed to save rating"];
                                                }
                                            }];
            }

        }
        else{
            [self showMessage:@"Failed to rate trainer"];
        }
    }];
    
   
    
    
    
}
@end
