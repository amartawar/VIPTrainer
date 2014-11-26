//
//  KBClientList.m
//  VipTrainer
//
//  Created by kenney on 4/6/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBWorkoutList2.h"
#import "Partnership.h"
#import "KBTrainerClientDashboard.h"
#import "KBWorkoutCell.h"
#import "KBWorkoutBuilder.h"
#import "KBWorkoutViewer.h"
#import "KBAssessment.h"
#import "KBAssessmentView.h"

@interface KBWorkoutList2 ()

@end

@implementation KBWorkoutList2{
    NSMutableArray *workouts;
    BOOL firstDisplay;
}

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
        workouts = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    DebugLog(@"view did load");
    [self loadWorkouts];
	// Do any additional setup after loading the view.
}

-(void)loadWorkouts{
    [workouts removeAllObjects];
    [self showProgress:@"Loading Workouts"];
    
    PFQuery *query = [Workout query];
    [query whereKey:@"partnership" equalTo:DATA.partnership];
    [query whereKey:@"sessionIndex" greaterThanOrEqualTo:[NSNumber numberWithInt:0]];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [self hideProgress];
        if(!error){
            [workouts addObjectsFromArray:objects];
            if(objects.count == 0)
                self.noClientsLabel.hidden = NO;
            else
                 self.noClientsLabel.hidden = YES;
            
            [self.table reloadData];
        }
        else{
            
        }
    }];
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    firstDisplay = true;
    self.title = @"Workouts";
    
    if(self.shouldRefresh){
        [self loadWorkouts];
    }
    else{
        if(workouts.count == 0)
            self.noClientsLabel.hidden = NO;
        else
            self.noClientsLabel.hidden = YES;
    }
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

- (IBAction)newWorkout:(id)sender {
    
    KBWorkoutBuilder *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"workoutBuilder"];
    
    Workout *workout = [Workout object];
    workout.exercises = [[NSMutableArray alloc] init];
    workout.sessionIndex = [NSNumber numberWithInt:workouts.count];
    workout.status = WORKOUT_CREATED;
    workout.partnership = DATA.partnership;
    DATA.selectedWorkout = workout;
    
    [self.navigationController pushViewController:viewController animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *workoutCellIdentifier = @"workoutCell";
    
    KBWorkoutCell *cell = [self.table dequeueReusableCellWithIdentifier:workoutCellIdentifier];
    
    if(!cell){
        
    }
    
    Workout *workout = [workouts objectAtIndex:indexPath.row];
    
    //cell.firstNameLabel.text = partnership.client.firstName;
    
    if(workout.status  == WORKOUT_CREATED){
        //cell.backgroundColor = vipHighlightGreen;
        
        cell.workoutCheckbox.on = NO;
        cell.assessmentCheckbox.on = NO;
    }
    else if(workout.status  == WORKOUT_COMPLETED){
        cell.workoutCheckbox.on = YES;
        cell.assessmentCheckbox.on = NO;
        //cell.backgroundColor = vipHighlightYellow;
    }
    else if(workout.status  == WORKOUT_ASSESSED){
        cell.workoutCheckbox.on = YES;
        cell.assessmentCheckbox.on = YES;
        //label.text = @"Awaiting Workout";
        //cell.backgroundColor = vipHighlightRed;
    }

    
    cell.imageView.image = nil;
    cell.sessionName.text = [NSString stringWithFormat:@"%@", workout.sessionIndex];
    //cell.lastNameLabel.text = [NSString stringWithFormat:@"%@ %@", partnership.client.firstName, partnership.client.lastName ];
    //cell.image.file = workout
    //[cell.image loadInBackground];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Workout *workout = [workouts objectAtIndex:indexPath.row];
    
    if(workout.status  == WORKOUT_CREATED){
        KBWorkoutViewer *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"workoutViewer"];
        controller.workout = workout;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if(workout.status  == WORKOUT_COMPLETED){
        
        KBAssessmentView *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"assessmentView"];
        DATA.selectedWorkout = workout;
        [self.navigationController pushViewController:controller animated:YES];
        
    }
    else if(workout.status  == WORKOUT_ASSESSED){
        KBWorkoutViewer *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"workoutViewer"];
        controller.workout = workout;
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return workouts.count;
}
@end
