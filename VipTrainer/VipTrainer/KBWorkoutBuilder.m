//
//  KBWorkoutBuilder.m
//  VipTrainer
//
//  Created by kenney on 4/16/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBWorkoutBuilder.h"
#import "KBExerciseBuilder.h"
#import "KBWorkoutList2.h"

@interface KBWorkoutBuilder ()

@end

@implementation KBWorkoutBuilder{
    int selectedRow;
}

//@synthesize workout = workout;

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
    
    if(DATA.partnership.status == TRAINER_ACCEPTED_CLIENT)
        self.title = [NSString stringWithFormat:@"Initial Assessment"];
    else
        self.title = [NSString stringWithFormat:@"Session %@", DATA.selectedWorkout.sessionIndex];
        
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.table reloadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.table setEditing:NO];
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
    
    if(DATA.selectedWorkout){
        return DATA.selectedWorkout.exercises.count+1;
    }
    
    return 0;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    DebugLog(@"can edit");
    return indexPath.row == DATA.selectedWorkout.exercises.count? NO : YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    DebugLog(@"commitEditingStyle");
    [DATA.selectedWorkout.exercises removeObjectAtIndex:indexPath.row];
     DebugLog(@"commitEditingStyle 2");
    [self.table reloadData];
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DebugLog(@"didselectRow");
    
    //Selected Add Exercise Cell
    if(indexPath.row == DATA.selectedWorkout.exercises.count){
        [self add:nil];
        return;
    }
    
    KBExerciseBuilder *builder = [self.storyboard instantiateViewControllerWithIdentifier:@"exerciseBuilder"];
    [builder setExerciseIndex:indexPath.row];
    [self.navigationController pushViewController:builder animated:YES];
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *exerciseCellIdentifier = @"exerciseCellIdentifier";
    static NSString *newExerciseCellIdentifier = @"newExerciseCellIdentifier";
    
    if(indexPath.row == DATA.selectedWorkout.exercises.count){
        UITableViewCell *cell = [self.table dequeueReusableCellWithIdentifier:newExerciseCellIdentifier];
        return cell;
        
        
    }else{
        KBExerciseCell *cell = [self.table dequeueReusableCellWithIdentifier:exerciseCellIdentifier];
        
        NSData *data = [DATA.selectedWorkout.exercises[indexPath.row] dataUsingEncoding:NSUTF8StringEncoding];
        NSError* error;
        NSDictionary *exercise = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:&error];
        
        if(!error){
            cell.titleLabel.text = [exercise objectForKey:@"name"];
            cell.repsTitleLabel.text = [exercise objectForKey:@"reps"];
            cell.setsTitleLabel.text = [exercise objectForKey:@"sets"];
        }
        return cell;
    }
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row == DATA.selectedWorkout.exercises.count? 44 : 60;
    
}


/*- (IBAction)close:(id)sender {
    
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
}*/

- (IBAction)add:(id)sender {
    
    KBExerciseBuilder *builder = [self.storyboard instantiateViewControllerWithIdentifier:@"exerciseBuilder"];
    [builder setExerciseIndex:DATA.selectedWorkout.exercises.count];
    [self.navigationController pushViewController:builder animated:YES];
    

}

- (IBAction)addRest:(id)sender {
}

-(IBAction)closeWithRefresh:(id)sender{
    DebugLog(@"closeWithRefresh");
    //Checks if the view controller above is the client list, and tells it to refresh
    for(int i = 0; i < self.navigationController.viewControllers.count; i++){
        UIViewController *v = self.navigationController.viewControllers[i];
        if(v.class == self.class){
            if([self.navigationController.viewControllers[i-1] isKindOfClass:KBWorkoutList2.class]){
                DebugLog(@"found class");
                ((KBViewController*)self.navigationController.viewControllers[i-1]).shouldRefresh = YES;
            }
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}




- (IBAction)save:(id)sender {
    [self showProgress:@"Saving Workout"];
    
    [DATA.selectedWorkout saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self hideProgress];
        if(!error){
            
            
            if(DATA.partnership.status == TRAINER_ACCEPTED_CLIENT){
                
                DATA.partnership.status = TRAINER_CREATED_FITNESS_ASSESSMENT;
                [DATA.partnership saveInBackground];
                [self closeWithRefresh:nil];
                
            }
            else{
                DATA.partnership.status = TRAINER_CREATED_WORKOUT;
                [DATA.partnership saveInBackground];
                [self closeWithRefresh:nil];
            }
            
        }
        else{
            [self showMessage:@"Unable to save"];
        }
    }];
}
@end
