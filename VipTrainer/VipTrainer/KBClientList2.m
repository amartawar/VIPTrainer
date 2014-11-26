//
//  KBClientList.m
//  VipTrainer
//
//  Created by kenney on 4/6/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBClientList2.h"
#import "Partnership.h"
#import "KBTrainerClientDashboard.h"
#import "KBWorkoutBuilder.h"


@interface KBClientList2 ()

@end

@implementation KBClientList2{
    NSMutableDictionary *partnerships;
    
    BOOL firstDisplay;
}
@synthesize filterByType;

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
        partnerships = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadClients];
    self.title = @"Clients";
	// Do any additional setup after loading the view.
}

-(void)loadClients{
    [self showProgress:@"Loading Clients"];
    
    [partnerships removeAllObjects];
    [self.table reloadData];
    
    
    PFQuery *query = [Partnership query];
    //[query whereKey:@"interests" containsAllObjectsInArray:DATA.user.interests];
    [query whereKey:@"trainer" equalTo:[User currentUser]];
    [query includeKey:@"client"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [self hideProgress];
        
        
        if(!error){
            
            for(Partnership *p in objects){
                
                if(filterByType && [filterByType intValue] == CLIENT_NEEDS_PRODUCTS){
                    if([partnerships objectForKey:@"products"]){
                        [[partnerships objectForKey:@"products"] addObject:p];
                    }
                    else{
                        NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:p, nil];
                        [partnerships setObject:array forKey:@"products"];
                    }
                }
                else if((p.status == CLIENT_COMPLETED_INTERVIEW && [filterByType intValue] == CLIENT_COMPLETED_INTERVIEW) || (p.status == CLIENT_COMPLETED_INTERVIEW && !filterByType)){
                    if([partnerships objectForKey:@"new"]){
                        [[partnerships objectForKey:@"new"] addObject:p];
                    }
                    else{
                        NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:p, nil];
                        [partnerships setObject:array forKey:@"new"];
                    }
                }
                else if((p.status == TRAINER_ACCEPTED_CLIENT && ([filterByType intValue] == TRAINER_ACCEPTED_CLIENT || [filterByType intValue] == CLIENT_COMPLETED_INTERVIEW )) || (p.status == TRAINER_ACCEPTED_CLIENT && !filterByType)){
                    if([partnerships objectForKey:@"fitness_assessment"]){
                        [[partnerships objectForKey:@"fitness_assessment"] addObject:p];
                    }
                    else{
                        NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:p, nil];
                        [partnerships setObject:array forKey:@"fitness_assessment"];
                    }
                }
                else if((p.status == TRAINER_CREATED_FITNESS_ASSESSMENT && ([filterByType intValue] == TRAINER_CREATED_FITNESS_ASSESSMENT || [filterByType intValue] == TRAINER_CREATED_FITNESS_ASSESSMENT )) || (p.status == TRAINER_CREATED_FITNESS_ASSESSMENT && !filterByType)){
                    if([partnerships objectForKey:@"created_fitness_assessment"]){
                        [[partnerships objectForKey:@"created_fitness_assessment"] addObject:p];
                    }
                    else{
                        NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:p, nil];
                        [partnerships setObject:array forKey:@"created_fitness_assessment"];
                    }
                }
                else if((p.status == CLIENT_COMPLETED_FITNESS_ASSESSMENT && [filterByType intValue] == CLIENT_COMPLETED_FITNESS_ASSESSMENT) || (p.status == CLIENT_COMPLETED_FITNESS_ASSESSMENT && !filterByType)){
                    
                    if([partnerships objectForKey:@"workout"]){
                        [[partnerships objectForKey:@"workout"] addObject:p];
                    }
                    else{
                        NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:p, nil];
                        [partnerships setObject:array forKey:@"workout"];
                    }
                }
                else if((p.status == TRAINER_CREATED_WORKOUT && [filterByType intValue] == TRAINER_CREATED_WORKOUT) || (p.status == TRAINER_CREATED_WORKOUT && !filterByType)){
                    
                    if([partnerships objectForKey:@"created_workout"]){
                        [[partnerships objectForKey:@"created_workout"] addObject:p];
                    }
                    else{
                        NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:p, nil];
                        [partnerships setObject:array forKey:@"created_workout"];
                    }
                    
                }
                else if((p.status == CLIENT_FINISHED_WORKOUT && [filterByType intValue] == CLIENT_FINISHED_WORKOUT) || (p.status == CLIENT_FINISHED_WORKOUT && !filterByType)){
                    
                    if([partnerships objectForKey:@"assess"]){
                        [[partnerships objectForKey:@"assess"] addObject:p];
                    }
                    else{
                        NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:p, nil];
                        [partnerships setObject:array forKey:@"assess"];
                    }
                    
                }
                else if((p.status == TRAINER_EVALUATED_WORKOUT && [filterByType intValue] == TRAINER_EVALUATED_WORKOUT) || (p.status == TRAINER_EVALUATED_WORKOUT && !filterByType)){
                    if([partnerships objectForKey:@"completed"]){
                        [[partnerships objectForKey:@"completed"] addObject:p];
                    }
                    else{
                        NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:p, nil];
                        [partnerships setObject:array forKey:@"completed"];
                    }
                }
                else{
                    if([partnerships objectForKey:@"in_progress"]){
                        [[partnerships objectForKey:@"in_progress"] addObject:p];
                    }
                    else{
                        NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:p, nil];
                        [partnerships setObject:array forKey:@"in_progress"];
                    }
                }
                

            }
            
            if(partnerships.count > 0)
                self.noClientsLabel.hidden = YES;
            else
                self.noClientsLabel.hidden = NO;
            
            [self.table reloadData];
        }
        else{
            [self showMessage:@"Couldn't load clients"];
        }
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 36;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSString *key = [[partnerships allKeys] objectAtIndex:section];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.table.frame.size.width, 36)];
    view.backgroundColor = [UIColor clearColor];
    
    KBLabel *label = [[KBLabel alloc] init];
    [label setTextAlignment:NSTextAlignmentCenter];
    
    if([key isEqualToString:@"new"]){
        label.text = @"New Clients";
        label.textColor = vipHighlightGreen;
    }
    else if([key isEqualToString:@"fitness_assessment"]){
        label.text = @"Awaiting Initial Assessment";
        label.textColor = vipHighlightGreen;
    }
    else if([key isEqualToString:@"assess"]){
        label.text = @"Awaiting Workout Review";
        label.textColor = vipHighlightYellow;
    }
    else if([key isEqualToString:@"created_fitness_assessment"]){
        label.text = @"Initial Assessment In Progress";
        label.textColor = vipGray;
    }
    else if([key isEqualToString:@"created_workout"]){
        label.text = @"Workout in Progress";
        label.textColor = vipGray;
    }
    else if([key isEqualToString:@"workout"]){
        label.text = @"Awaiting Workout";
        label.textColor = vipHighlightRed;
    }
    else if([key isEqualToString:@"completed"]){
        label.text = @"Completed Workout";
        label.textColor =  vipGray;
    }
    else if([key isEqualToString:@"products"]){
        label.text = @"Recommend Products";
        label.textColor =  vipHighlightYellow;
    }
    else if([key isEqualToString:@"in_progress"]){
        label.text = @"In Progress";
        label.textColor =  vipLightGray;
    }

    
    //label.textColor = [UIColor whiteColor];
    [label sizeToFit];
    
    label.frame = CGRectOffset(label.frame, (self.table.frame.size.width/2)-(label.frame.size.width/2), 8);
    
    [view addSubview:label];
    
    return view;
}

-(void)viewWillAppear:(BOOL)animated{
    firstDisplay = true;
    
    if(self.shouldReload){
        self.shouldReload = NO;
        [self loadClients];
    }
    
    if(partnerships.count > 0)
        self.noClientsLabel.hidden = YES;
    else
        self.noClientsLabel.hidden = NO;
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
    static NSString *productCollectionCellIdentifier = @"clientCell";
    
    KBClientCell *cell = [self.table dequeueReusableCellWithIdentifier:productCollectionCellIdentifier];
    
    if(!cell){
        
    }
    
    
    NSString *key = [[partnerships allKeys] objectAtIndex:indexPath.section];
    Partnership *partnership = [[partnerships objectForKey:key] objectAtIndex:indexPath.row];
    //cell.firstNameLabel.text = partnership.client.firstName;
    
    if([key isEqualToString:@"new"]){
        //cell.backgroundColor = vipHighlightGreen;
    }
    else if([key isEqualToString:@"assess"]){
        //cell.backgroundColor = vipHighlightYellow;
    }
    else if([key isEqualToString:@"workout"]){
        //label.text = @"Awaiting Workout";
        //cell.backgroundColor = vipHighlightRed;
    }
    else if([key isEqualToString:@"completed"]){
        //label.text = @"Completed Workout";
        //cell.backgroundColor =  [UIColor whiteColor];
    }
    
    cell.imageView.image = nil;
    cell.lastNameLabel.text = [NSString stringWithFormat:@"%@ %@", partnership.client.firstName, partnership.client.lastName ];
    cell.image.file = partnership.client.profilePicThumb;
    [cell.image loadInBackground];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *key = [[partnerships allKeys] objectAtIndex:indexPath.section];
    DATA.partnership = [[partnerships objectForKey:key] objectAtIndex:indexPath.row];
    if(filterByType && [filterByType intValue] == CLIENT_NEEDS_PRODUCTS){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Trainer" bundle:nil];
        UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"nutritionList"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if(DATA.partnership.status == CLIENT_COMPLETED_INTERVIEW){
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Client" bundle:nil];
        UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"viewClient2"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    else if(DATA.partnership.status == CLIENT_COMPLETED_FITNESS_ASSESSMENT){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Workout" bundle:nil];
        UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"workoutList2"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    
    else if(DATA.partnership.status == TRAINER_ACCEPTED_CLIENT){
         UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Workout" bundle:nil];
        KBWorkoutBuilder *viewController = [storyboard instantiateViewControllerWithIdentifier:@"workoutBuilder"];
        
        Workout *workout = [Workout object];
        workout.exercises = [[NSMutableArray alloc] init];
        workout.sessionIndex = [NSNumber numberWithInt:-1];
        workout.partnership = DATA.partnership;
        DATA.selectedWorkout = workout;
        
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
    else if(DATA.partnership.status == CLIENT_FINISHED_WORKOUT){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Workout" bundle:nil];
        UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"workoutList2"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Client" bundle:nil];
        UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"viewClient2"];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return partnerships.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[partnerships objectForKey:[[partnerships allKeys] objectAtIndex:section] ] count];
}


@end
