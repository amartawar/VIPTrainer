//
//  KBWorkoutBuilder.m
//  VipTrainer
//
//  Created by kenney on 4/2/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBWorkoutToday.h"
#import "KBWorkoutNavigation.h"

@implementation KBWorkoutToday{
    int selectedRow;
    BOOL firstDisplay;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        selectedRow = -1;
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    firstDisplay = true;
    if(!DATA.selectedWorkout){
        if(DATA.partnership)
            [self loadWorkout];
        else
            [self loadPartnership];
    }
    else{
        self.noWorkoutsLabel.hidden = YES;
    }

    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"grey.png"]];
}

-(void)viewDidAppear:(BOOL)animated{
    
    if(firstDisplay){
        self.view.transform = CGAffineTransformScale(self.view.transform, .6, .6);
        [UIView animateWithDuration:0.2f
                         animations:^{
                             [self.view setAlpha:1.0f];
                             [self.view setOpaque:YES];
                             self.view.transform = CGAffineTransformIdentity;
                         }];
        firstDisplay = false;
    }

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.table reloadData];
    
    if(DATA.selectedWorkout && ![self getNextIncompleteExerciseIndex]){
        [self.startButton setTitle:@"Submit" forState:UIControlStateNormal];
        [self.startButton setTitle:@"Submit" forState:UIControlStateHighlighted];
        [self.startButton setTitle:@"Submit" forState:UIControlStateDisabled];
    }
    
    if(firstDisplay)
        [self.view setAlpha:0.0f];
    
    
    
    
}

-(void)loadPartnership{
    [self showProgress:@"Loading Clients"];
    PFQuery *query = [Partnership query];
        //[query whereKey:@"interests" containsAllObjectsInArray:DATA.user.interests];
    [query whereKey:@"client" equalTo:[User currentUser]];
    [query includeKey:@"trainer"];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        [self hideProgress];
        
        DebugLog(@"loaded client?");
        
        
        if(!error){
            if(object)
                DATA.partnership = (Partnership *)object;
            [self loadWorkout];
            
            DebugLog(@"loaded client without error?");
        }
        else{
            [self showMessage:@"You do not currently have a trainer"];
        }
    }];

}


-(void)loadWorkout{
    
    [self showProgress:@"Loading Workout"];
    
    DebugLog(@"PARTNERSHIP: %i", DATA.partnership.status);
    
    if(DATA.partnership.status == TRAINER_CREATED_FITNESS_ASSESSMENT){
        PFQuery *query = [Workout query];
        //[query whereKey:@"interests" containsAllObjectsInArray:DATA.user.interests];
        [query whereKey:@"partnership" equalTo:DATA.partnership];
        [query whereKey:@"sessionIndex" equalTo:[NSNumber numberWithInt:-1]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            [self hideProgress];
            if(!error){
                if(objects.count > 0){
                    DATA.selectedWorkout = objects[0];
                    [self.table reloadData];
                    
                    self.noWorkoutsLabel.hidden = YES;
                    
                }
                else{
                    self.noWorkoutsLabel.hidden = NO;
                    self.startButton.enabled = NO;
                }
            }
            else{
                
            }
        }];
    }
    else{
        PFQuery *query = [Workout query];
        //[query whereKey:@"interests" containsAllObjectsInArray:DATA.user.interests];
        [query whereKey:@"partnership" equalTo:DATA.partnership];
        [query whereKey:@"sessionIndex" greaterThanOrEqualTo:[NSNumber numberWithInt:0]];
        [query whereKey:@"status" equalTo:[NSNumber numberWithInt:WORKOUT_CREATED]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            [self hideProgress];
            if(!error){
                if(objects.count > 0){
                    
                    DATA.selectedWorkout = objects[0];
                    [self.table reloadData];
                    
                    self.noWorkoutsLabel.hidden = YES;
                    
                }
                else{
                    self.noWorkoutsLabel.hidden = NO;
                    self.startButton.enabled = NO;
                }
            }
            else{
                
            }
        }];
    }

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    if(DATA.selectedWorkout){
        return DATA.selectedWorkout.exercises.count;
    }
    
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSIndexPath *deselectedRow;

    //If a previous row is selected, set the row to deselect (so it updates too)
    if(selectedRow != -1)
        deselectedRow = [NSIndexPath indexPathForRow:selectedRow inSection:0];
    
    //Change the selectedRow to the new row.
    if(selectedRow == indexPath.row)
        selectedRow = -1;
    else
        selectedRow = indexPath.row;
    
    if(deselectedRow && deselectedRow.row != indexPath.row)
        [self.table reloadRowsAtIndexPaths:@[deselectedRow, indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    else
        [self.table reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"exerciseCellIdentifier";
    
    KBExerciseCell *cell = [self.table dequeueReusableCellWithIdentifier:identifier];

    NSData *data = [DATA.selectedWorkout.exercises[indexPath.row] dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error;
    NSDictionary *exercise = [NSJSONSerialization JSONObjectWithData:data
                                                             options:kNilOptions
                                                               error:&error];
    
    if(!error){
        cell.titleLabel.text = [exercise objectForKey:@"name"];
        cell.repsTitleLabel.text = [exercise objectForKey:@"reps"];
        cell.setsTitleLabel.text = [exercise objectForKey:@"sets"];
        cell.descriptionLabel.text = [exercise objectForKey:@"description"];
        cell.commentsLabel.text = [exercise objectForKey:@"comments"];
        cell.finishedToggle.on = [[exercise objectForKey:@"complete"] boolValue];
        
        
        if(selectedRow == indexPath.row){
            cell.titleLabel.textColor = vipBrightGreen;
            cell.repsTitleLabel.textColor = vipBrightGreen;
            cell.setsTitleLabel.textColor = vipBrightGreen;
            
        }
        else{
            cell.titleLabel.textColor = vipDarkGray;
            cell.repsTitleLabel.textColor = vipDarkGray;
            cell.setsTitleLabel.textColor = vipDarkGray;
            
            
        }
    }
    return cell;
}

-(NSNumber *)getNextIncompleteExerciseIndex{
    for(int i = 0; i < DATA.selectedWorkout.exercises.count; i++){
        NSData *data = [DATA.selectedWorkout.exercises[i] dataUsingEncoding:NSUTF8StringEncoding];
        NSError* error;
        NSDictionary *exercise = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:&error];
        
        if(!error){
            if(![[exercise objectForKey:@"complete"] boolValue]){
                return [NSNumber numberWithInt:i];
            }
        }
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(selectedRow == indexPath.row){
        return 251;
        
    }
    else{
        return 60;
    }
    
}

- (IBAction)skip:(id)sender {
    
    if(selectedRow+1 >= DATA.selectedWorkout.exercises.count){
        [self tableView:self.table didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:selectedRow inSection:0]];
    }
    else{
        [self tableView:self.table didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:selectedRow+1 inSection:0]];
    }
}

-(void)submit{
    
    [self showProgress:@"Submitting Workout"];
    
    DATA.selectedWorkout.status = WORKOUT_COMPLETED;
    
    [PFCloud callFunctionInBackground:@"CompleteWorkout"
                       withParameters:@{@"partnership_id": DATA.partnership.objectId,
                                        @"workout_id": DATA.selectedWorkout.objectId,
                                        @"completionTime": @"10"}
                                block:^(NSArray *results, NSError *error) {
                                    [self hideProgress];
                                    if(!error){
                                        
                                        if(DATA.selectedWorkout.sessionIndex == [NSNumber numberWithInt:-1]){
                                            [self showMessage:@"Initial Assessment Submitted"];
                                            DATA.selectedWorkout = nil;
                                            DATA.partnership.status = CLIENT_COMPLETED_FITNESS_ASSESSMENT;
                                            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                                        }
                                        else{
                                            [self showMessage:@"Workout Submitted"];
                                            DATA.selectedWorkout = nil;
                                            DATA.partnership.status = CLIENT_FINISHED_WORKOUT;
                                            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                                        }
                                                                           }
                                    else{
                                        [self showMessage:@"Unable to save workout"];
                                    }
                                }];
    
    
    
    
}

- (IBAction)start:(id)sender {
    
    if(DATA.selectedWorkout){
        NSNumber *nextIncompleteIndex = [self getNextIncompleteExerciseIndex];
        if(nextIncompleteIndex){
            [((KBWorkoutNavigation *)self.navigationController) goToExercisePageForIndex:[nextIncompleteIndex intValue]];
        }
        else{
            [self submit];
        }
    }
    
}

- (IBAction)quit:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
