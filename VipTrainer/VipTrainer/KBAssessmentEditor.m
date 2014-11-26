//
//  KBAssessmentEditor.m
//  VipTrainer
//
//  Created by kenney on 7/29/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBAssessmentEditor.h"
#import "NSDictionary+JSON.h"

@interface KBAssessmentEditor ()

@end

@implementation KBAssessmentEditor{
    NSMutableDictionary *exerciseDictionary;
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
    
    NSString *exercise = [DATA.selectedWorkout.exercises objectAtIndex:self.exerciseIndex];
    
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
        //self.com = [exerciseDictionary objectForKey:@"comments"];
        self.timeLabel.text = [exerciseDictionary objectForKey:@"time"];
        self.repsLabel.text = [exerciseDictionary objectForKey:@"reps"];
        self.setsLabel.text = [exerciseDictionary objectForKey:@"sets"];
        self.weightLabel.text = [exerciseDictionary objectForKey:@"weight"];
        self.clientCommentsLabel.text = [exerciseDictionary objectForKey:@"client_comments"];
        self.assessmentView.text = [exerciseDictionary objectForKey:@"trainer_comments"];
    }
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [exerciseDictionary setObject:self.assessmentView.text forKey:@"trainer_comments"];
    [DATA.selectedWorkout.exercises replaceObjectAtIndex:self.exerciseIndex withObject:[exerciseDictionary jsonStringWithPrettyPrint:YES]];
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

@end
