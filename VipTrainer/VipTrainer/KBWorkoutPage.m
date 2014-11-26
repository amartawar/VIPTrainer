//
//  KBWorkoutPage.m
//  VipTrainer
//
//  Created by kenney on 6/29/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBWorkoutPage.h"
#import "KBWorkoutToday.h"
#import "KBWorkoutNavigation.h"
#import "NSDictionary+JSON.h"

@interface KBWorkoutPage ()

@end

@implementation KBWorkoutPage{
    NSMutableDictionary *exerciseDictionary;
    NSTimer *timer;
    int timerCount;
    BOOL paused;
}
@synthesize exerciseIndex;

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
    
    
    DebugLog(@"Navigation Controller class:%@", [self.navigationController class]);
    
    NSString *exercise = [((KBWorkoutNavigation*)self.navigationController) getExerciseAtIndex:exerciseIndex];
    
    if(!exercise){
        [self showMessage:@"Couldn't load exercise"];
        return;
    }
    
    NSData *data = [exercise dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error;
    NSDictionary *ed = [NSJSONSerialization JSONObjectWithData:data
                                                             options:kNilOptions
                                                               error:&error];
    exerciseDictionary = [NSMutableDictionary dictionaryWithDictionary:ed];
    
    if(!error){
        self.nameLabel.text = [exerciseDictionary objectForKey:@"name"];
        self.descriptionLabel.text = [exerciseDictionary objectForKey:@"description"];
        //self.com = [exerciseDictionary objectForKey:@"comments"];
        self.timeLabel.text = [exerciseDictionary objectForKey:@"time"];
        self.repsLabel.text = [exerciseDictionary objectForKey:@"reps"];
        self.setsLabel.text = [exerciseDictionary objectForKey:@"sets"];
        self.weightLabel.text = [exerciseDictionary objectForKey:@"weight"];
    }
    
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)enableTimer{
    self.playButton.enabled = YES;
    self.skipButton.enabled = YES;
    self.weightLabel.text = @"--";
    self.timeLabel.text = @"--";
}
-(void)disableTimer{
    self.playButton.enabled = NO;
    self.skipButton.enabled = NO;
    self.weightLabel.text = @"--";
    self.timeLabel.text = @"--";
}

- (void)increaseTimerCount
{
    if(!paused)
        timerCount++;
    
    int seconds = timerCount/10;
    int minutes = seconds/60;
    self.timerLabel.text = [NSString stringWithFormat:@"%d:%02d", minutes, seconds];
}

- (IBAction)startTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(increaseTimerCount) userInfo:nil repeats:YES];
    [timer fire];
    
}

- (IBAction)stopTimer
{
    [timer invalidate];
}

- (IBAction)play:(id)sender {
    if(timer){
        paused = !paused;
    }
    else{
        [self startTimer];
    }
}

- (IBAction)skip:(id)sender {
    
    if(exerciseDictionary){
        [exerciseDictionary setValue:[NSNumber numberWithBool:YES] forKey:@"complete"];
        NSString *exerciseString = [exerciseDictionary jsonStringWithPrettyPrint:YES];
        DATA.selectedWorkout.exercises[exerciseIndex] = exerciseString;
    }
    
   [((KBWorkoutNavigation*)self.navigationController) goToExercisePageForIndex:exerciseIndex+1];
}
@end
