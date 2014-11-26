//
//  KBQuestionanaire.m
//  VipTrainer
//
//  Created by kenney on 6/26/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBQuestionnaire.h"
#import "NSArray+JSON.h"

@interface KBQuestionnaire ()

@end

@implementation KBQuestionnaire

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
    self.howOftenToggle1.delegate = self;
    self.howOftenToggle2.delegate = self;
    self.howOftenToggle3.delegate = self;
    self.howOftenToggle4.delegate = self;
    
    self.howLongToggle1.delegate = self;
    self.howLongToggle2.delegate = self;
    self.howLongToggle3.delegate = self;
    self.howLongToggle4.delegate = self;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationItem.hidesBackButton = YES;
}

-(void)KBToggle:(KBToggle*)toggle valueChanged:(BOOL)value{
    
    
    if(toggle == self.howLongToggle1){
        self.howLongToggle2.on = false;
        self.howLongToggle3.on = false;
        self.howLongToggle4.on = false;
        
    }
    if(toggle == self.howLongToggle2){
        self.howLongToggle1.on = false;
        self.howLongToggle3.on = false;
        self.howLongToggle4.on = false;
    }
    if(toggle == self.howLongToggle3){
        self.howLongToggle1.on = false;
        self.howLongToggle2.on = false;
        self.howLongToggle4.on = false;
    }
    if(toggle == self.howLongToggle4){
        self.howLongToggle2.on = false;
        self.howLongToggle3.on = false;
        self.howLongToggle1.on = false;
    }
    
    if(toggle == self.howOftenToggle1){
        self.howOftenToggle2.on = false;
        self.howOftenToggle3.on = false;
        self.howOftenToggle4.on = false;
    }
    if(toggle == self.howOftenToggle2){
        self.howOftenToggle1.on = false;
        self.howOftenToggle3.on = false;
        self.howOftenToggle4.on = false;
    }
    if(toggle == self.howOftenToggle3){
        self.howOftenToggle2.on = false;
        self.howOftenToggle1.on = false;
        self.howOftenToggle4.on = false;
    }
    if(toggle == self.howOftenToggle4){
        self.howOftenToggle2.on = false;
        self.howOftenToggle3.on = false;
        self.howOftenToggle1.on = false;
    }
    
}

- (IBAction)submit:(id)sender {
    
    
    NSMutableArray *answersArray = [[NSMutableArray alloc] init];
    
    if(self.howLongToggle1.on)
       [answersArray addObject:[NSNumber numberWithInt:0]];
    if(self.howLongToggle2.on)
        [answersArray addObject:[NSNumber numberWithInt:1]];
    if(self.howLongToggle3.on)
        [answersArray addObject:[NSNumber numberWithInt:2]];
    if(self.howLongToggle4.on)
        [answersArray addObject:[NSNumber numberWithInt:3]];
    
    if(self.howOftenToggle1.on)
        [answersArray addObject:[NSNumber numberWithInt:0]];
    if(self.howOftenToggle2.on)
        [answersArray addObject:[NSNumber numberWithInt:1]];
    if(self.howOftenToggle3.on)
        [answersArray addObject:[NSNumber numberWithInt:2]];
    if(self.howOftenToggle4.on)
        [answersArray addObject:[NSNumber numberWithInt:3]];
    
    
    if(self.question3TextView.text.length > 0)
       [answersArray addObject:self.question3TextView.text];
    
    if(self.question4TextView.text.length > 0)
        [answersArray addObject:self.question4TextView.text];
    
    if(self.question5TextView.text.length > 0)
        [answersArray addObject:self.question5TextView.text];
    
    if(self.question6TextView.text.length > 0)
        [answersArray addObject:self.question6TextView.text];
    
    if(self.question7TextView.text.length > 0)
        [answersArray addObject:self.question7TextView.text];
        
    if(self.question8TextView.text.length > 0)
        [answersArray addObject:self.question8TextView.text];
        

    
    if(answersArray.count != 8){
        [self showMessage:(@"Please answer all of the quetions")];
        return;
    }
    else{
        NSString *jsonString = [answersArray jsonStringWithPrettyPrint:YES];
        
        DATA.partnership.questionnaire = jsonString;
        DATA.partnership.status = CLIENT_COMPLETED_INTERVIEW;
        [self showProgress:@"Submitting"];
        [DATA.partnership saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [self hideProgress];
            if(!error){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thank You For Signing Up!" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert setTintColor:vipBrightGreen];
                [alert setTag:2];
                [alert show];
            }
            else{
                [self showMessage:(@"An Error Occured. Please try again")];
            }
        }];
    }
    
    
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 2){
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
