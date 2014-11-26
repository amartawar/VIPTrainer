//
//  KBWorkoutNavigation.m
//  VipTrainer
//
//  Created by kenney on 6/29/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBWorkoutNavigation.h"

@interface KBWorkoutNavigation ()

@end

@implementation KBWorkoutNavigation
@synthesize currentExerciseIndex;

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*)getExerciseAtIndex:(int)index{
    if(index < DATA.selectedWorkout.exercises.count){
        return DATA.selectedWorkout.exercises[index];
    }
    else
        return nil;
}

-(void)goToExercisePageForIndex:(int)index{
    
    if(index < DATA.selectedWorkout.exercises.count){
        
        KBWorkoutPage *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"workoutPage"];
        controller.exerciseIndex = index;
        [self pushViewController:controller animated:YES];
    }
    else{
        [self popToRootViewControllerAnimated:YES];
    }
}

@end
