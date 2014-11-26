//
//  KBClientList.m
//  VipTrainer
//
//  Created by kenney on 4/6/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBAssessmentView.h"
#import "Partnership.h"
#import "KBAssessmentViewCell.h"
#import "KBAssessmentEditor.h"
#import "KBClientList2.h"


@interface KBAssessmentView ()

@end

@implementation KBAssessmentView{
    BOOL firstDisplay;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Clients";
    self.scrollUsingTable = YES;
	// Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated{
    firstDisplay = true;
    self.saveButton.enabled = YES;
    [self.table reloadData];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.transform = CGAffineTransformTranslate(cell.transform, -50, 0);
    cell.alpha = 0;
    
    if(firstDisplay){
        
        int cellsAbove = 0;
        for(int i = 0; i < indexPath.section; i++){
            
            int numberInSection = [self tableView:tableView numberOfRowsInSection:i];
            
            cellsAbove += numberInSection;
        }
        
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *AssessmentViewCellIdentifier = @"assessmentViewCell";
    
    KBAssessmentViewCell *cell = [self.table dequeueReusableCellWithIdentifier:AssessmentViewCellIdentifier];
    
    NSData *data = [DATA.selectedWorkout.exercises[indexPath.row] dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error;
    NSDictionary *exercise = [NSJSONSerialization JSONObjectWithData:data
                                                             options:kNilOptions
                                                               error:&error];
    
    if(!error){
        cell.titleLabel.text = [exercise objectForKey:@"name"];
        
        if([[exercise objectForKey:@"trainer_comments"] isValidNonEmptyString]){
            cell.checkbox.on = YES;
        }
        else{
            cell.checkbox.on = NO;
            self.saveButton.enabled = NO;
        }
    }
    if(!cell){
        
    }
    

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KBAssessmentEditor *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"assessmentEditor"];
    controller.exerciseIndex = indexPath.row;
    [self.navigationController pushViewController:controller animated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return DATA.selectedWorkout.exercises.count;
}

- (IBAction)save:(id)sender {
    DATA.selectedWorkout.status = WORKOUT_ASSESSED;
    [self showProgress:@"Saving Assessment"];
    [DATA.selectedWorkout saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if(!error){
            [self updatePartnership];
        }
        else{
            [self hideProgress];
            [self showMessage:@"Unable to save assessment"];
        }
    }];
}

-(void)updatePartnership{
    DATA.partnership.status = TRAINER_EVALUATED_WORKOUT;
    [DATA.partnership saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self hideProgress];
        if(!error){
            [self showMessage:@"Assessment Saved"];
            
            
            for(UIViewController *vc in self.navigationController.viewControllers){
                if([vc isKindOfClass:[KBClientList2 class]]){
                    ((KBClientList2 *)vc).shouldReload = YES;
                }
            }
            
            
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [self showMessage:@"Unable to save assessment"];
        }
    }];
}


@end
