//
//  KBWorkoutViewer.m
//  VipTrainer
//
//  Created by kenney on 5/20/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBWorkoutViewer.h"
#import "KBExerciseBuilder.h"
#import "NSDictionary+JSON.h"
#import "KBAssessment.h"
#import "KBAssessmentView.h"

@interface KBWorkoutViewer ()

@end

@implementation KBWorkoutViewer{
    int selectedRow;
}

@synthesize workout = workout;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        selectedRow = -1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.topItem.title = @"Close";
    self.title = [NSString stringWithFormat:@"Session %@", workout.sessionIndex];
    
    if(workout.status == WORKOUT_ASSESSED){
        [self.assessButton setTitle:@"View Assessment" forState:UIControlStateNormal];
        [self.assessButton setTitle:@"View Assessment" forState:UIControlStateHighlighted];
        [self.assessButton setTitle:@"View Assessment" forState:UIControlStateDisabled];
    }
    
    
    
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.table reloadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(workout){
        return workout.exercises.count;
    }
    
    return 0;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return indexPath.row == workout.exercises.count? NO : YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [DATA.selectedWorkout.exercises removeObjectAtIndex:indexPath.row];
    [self.table reloadData];
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
    
    NSData *data = [workout.exercises[indexPath.row] dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error;
    NSDictionary *exercise = [NSJSONSerialization JSONObjectWithData:data
                                                             options:kNilOptions
                                                               error:&error];
    
    if(!error){
        cell.titleLabel.text = [exercise objectForKey:@"name"];
        cell.repsTitleLabel.text = [exercise objectForKey:@"reps"];
        cell.setsTitleLabel.text = [exercise objectForKey:@"sets"];
        
        
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return selectedRow == indexPath.row? 251 : 60;
}


- (IBAction)close:(id)sender {
    
    UIView *dst = self.view;
    
    dst.transform = CGAffineTransformIdentity;
    dst.alpha = 1;
    //src.view.transform = CGAffineTransformMakeTranslation(0, 0);
    
    
    
    [UIView transitionWithView:dst duration:.12
                       options:UIViewAnimationOptionCurveEaseIn
                    animations:^{
                        
                        
                        dst.transform = CGAffineTransformMakeScale(.875, .81);
                        dst.alpha = .8;
                        //src.view.transform = CGAffineTransformMakeTranslation(0, -src.view.frame.size.height);
                        
                        
                    }
                    completion:^(BOOL finished) {
                        [self.navigationController popViewControllerAnimated:NO];
                    }];
}


-(IBAction)assess:(id)sender{
    

}


@end
