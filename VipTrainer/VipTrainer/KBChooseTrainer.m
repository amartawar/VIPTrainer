//
//  KBChooseTrainer.m
//  VipTrainer
//
//  Created by kenney on 4/2/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBChooseTrainer.h"
#import "KBChooseTrainerCell.h"
#import "Partnership.h"
#import "User.h"
#import "KBOpen.h"
#import "KBTrainerSummary.h"

@implementation KBChooseTrainer{
    NSArray *trainerArray;
     BOOL firstDisplay;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        trainerArray = [[NSArray alloc] init];
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self loadTrainers];
}

-(void)viewWillAppear:(BOOL)animated{
    firstDisplay = true;
}

-(void)loadTrainers{
    
    [self showProgress:@"Finding Trainers"];
    PFQuery *query = [User query];
    //[query whereKey:@"interests" containsAllObjectsInArray:DATA.user.interests];
    [query whereKey:@"type" equalTo:@"trainer"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [self hideProgress];
        if(!error){
            trainerArray = objects;
            
            DebugLog(@"trainerARray count:%i", trainerArray.count);
            
            [self.table reloadData];
        }
        else{
            
        }
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *productCollectionCellIdentifier = @"chooseTrainerCell";
    
    KBChooseTrainerCell *cell = [self.table dequeueReusableCellWithIdentifier:productCollectionCellIdentifier];
    
    if(!cell){
        
    }
    cell.image.file = nil;
    
    User *trainer = trainerArray[indexPath.row];
    
    cell.firstNameLabel.text = [NSString stringWithFormat:@"%@ %@", trainer.firstName, trainer.lastName];
    
    double rate = [trainer.hourly_rate doubleValue];
    double sessionPrice = rate / SESSIONS_PER_HOUR;
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    NSString *numberAsString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:sessionPrice]];
    cell.priceLabel.text = numberAsString;
    
    if(trainer.profilePicThumb){
        cell.image.file = trainer.profilePicThumb;
        [cell.image loadInBackground];
    }
    
    cell.ratingView.rating = [trainer.rating floatValue];
    cell.viewCertificationsButton.tag = indexPath.row;
    [cell.viewCertificationsButton addTarget:self action:@selector(showCertifications:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;

}

-(void)showCertifications:(UIButton *)sender{
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Trainer" bundle:nil];
    KBTrainerSummary *controller = [storyboard instantiateViewControllerWithIdentifier:@"viewTrainer"];
    controller.user = trainerArray[indexPath.row];
    
    [self.navigationController pushViewController:controller animated:YES];
    
    /*Partnership *partnership = [Partnership object];
    partnership.client = [User currentUser];
    partnership.trainer = trainerArray[indexPath.row];
    
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
    }];*/
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return trainerArray.count;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.transform = CGAffineTransformTranslate(cell.transform, -50, 0);
    cell.alpha = 0;
    
    if(firstDisplay){
        
        int cellsAbove = 0;
        cellsAbove += indexPath.row;
        
        [UIView animateWithDuration:.2 delay:cellsAbove*.08 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            cell.transform = CGAffineTransformIdentity;
            cell.alpha = 1;
        } completion:^(BOOL finished) {
            firstDisplay = false;
        }];
    }
    else{
        [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            cell.transform = CGAffineTransformIdentity;
            cell.alpha = 1;
        } completion:^(BOOL finished) {}];
        
    }
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
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Dashboard" bundle:nil];
        UIViewController *controller = [storyboard instantiateInitialViewController];
        [self.navigationController pushViewController:controller animated:YES];
    }
    

    

}
@end
