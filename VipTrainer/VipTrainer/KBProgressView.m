//
//  KBProgressView.m
//  VipTrainer
//
//  Created by kenney on 7/20/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBProgressView.h"

@interface KBProgressView ()

@end

@implementation KBProgressView
@synthesize pageIndex;

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
        
    }
    return self;
}

-(void)hideKeyboard{
    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    self.muscleGroupLabel.transform = CGAffineTransformMakeTranslation(200, 0);
    self.descriptionLabel.transform = CGAffineTransformMakeTranslation(200, 0);
    self.muscleGroupLabel.alpha = 0;
    self.descriptionLabel.alpha = 0;
    
    [UIView animateWithDuration:.2 animations:^{
        self.muscleGroupLabel.transform = CGAffineTransformIdentity;
        self.descriptionLabel.transform = CGAffineTransformIdentity;
        self.muscleGroupLabel.alpha = 1;
        self.descriptionLabel.alpha = 1;
    } completion:^(BOOL finished) {
        [self.measurementField becomeFirstResponder];
    }];
}

- (void)viewDidLoad
{
    
    
    [self.measurementField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    self.title = @"Progress";
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tapGesture.delegate = self;
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
    
    DebugLog(@"Pageindex:%i", self.pageIndex);
    
    switch (self.pageIndex) {
        case 0:{
            
            self.descriptionLabel.text = @"Looking straight ahead with your shoulder's relaxed, measure around the neck just below the Adam's Apple.";
            self.muscleGroupLabel.text = @"Neck";
            self.measurementField.placeholder = @"Measurement in inches";
            
            
            
        }
            break;
        case 1:{
            self.descriptionLabel.text = @"Stretch tape measure around your body where your shoulders are most prominent.";
            self.muscleGroupLabel.text = @"Shoulders";
            self.measurementField.placeholder = @"Measurement in inches";
        }
            break;
        case 2:{
            self.descriptionLabel.text = @"Keeping tape measure horizontal, wrap it around your chest directly above your nipple line. Tape measure should be snug but not tight and arms should be relaxed by your sides.";
            self.muscleGroupLabel.text = @"Chest";
            self.measurementField.placeholder = @"Measurement in inches";
        }
            break;
        case 3:{
            self.descriptionLabel.text = @"Make a fist and curl wrist toward shoulder, flex and hold formeasurement. Wrap measuring tape around your upper arm and measure at the highest point of the bicep.";
            self.muscleGroupLabel.text = @"Biceps";
            self.measurementField.placeholder = @"Measurement in inches";
        }
            break;
        case 4:{
            self.descriptionLabel.text = @"Wrap measuring tape around the are with the largest circumference below the elbow.";
            self.muscleGroupLabel.text = @"Forearms";
            self.measurementField.placeholder = @"Measurement in inches";
        }
            break;
        case 5:{
            self.descriptionLabel.text = @"Wrap measuring tape around the narrowest part of your torso belowthe bottom of your rib cage and above belly button. Tape should be snug but not tight when standing relaxed.";
            self.muscleGroupLabel.text = @"Waist";
            self.measurementField.placeholder = @"Measurement in inches";
        }
            break;
        case 6:{
            self.descriptionLabel.text = @"Wrap measuring tape around the widest point of individual thigh, usually 2 inches below the groin.";
            self.muscleGroupLabel.text = @"Thighs";
            self.measurementField.placeholder = @"Measurement in inches";
        }
            break;
        case 7:{
            self.descriptionLabel.text = @"Wrap measuring tape around the largest part of individual calf, usually 4 inches below the knee.";
            self.muscleGroupLabel.text = @"Calves";
            self.measurementField.placeholder = @"Measurement in inches";
        }
            break;
        case 8:{
            self.descriptionLabel.text = @"";
            self.muscleGroupLabel.text = @"Percent Body Fat";
            self.measurementField.placeholder = @"Measurement in percentage";
        }
            break;
        case 9:{
            self.descriptionLabel.text = @"Looking straight ahead with your shoulder's relaxed, measure around the neck just below the Adam's Apple.";
            self.muscleGroupLabel.text = @"Weight";
            self.measurementField.placeholder = @"Measurement in lbs";
        }
            break;
        case 10:{
            //summary
        }
            break;
            
            
            [self.view layoutIfNeeded];
    }

    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)next:(id)sender {
    
    switch(self.pageIndex){
        case 0:{
            DATA.selectedProgress = [Progress object];
            DATA.selectedProgress.neck = self.measurementField.text;
        }
            break;
        case 1:{
            DATA.selectedProgress.shoulders = self.measurementField.text;
        }
            break;
        case 2:{
            DATA.selectedProgress.chest = self.measurementField.text;
        }
            break;
        case 3:{
            DATA.selectedProgress.biceps = self.measurementField.text;
        }
            break;
        case 4:{
            DATA.selectedProgress.forearms = self.measurementField.text;
        }
            break;
        case 5:{
            DATA.selectedProgress.waist = self.measurementField.text;
        }
            break;
        case 6:{
            DATA.selectedProgress.thighs = self.measurementField.text;
        }
            break;
        case 7:{
            DATA.selectedProgress.calves = self.measurementField.text;
        }
            break;
        case 8:{
            DATA.selectedProgress.bodyFat = self.measurementField.text;
        }
            break;
        case 9:{
            DATA.selectedProgress.weight = self.measurementField.text;
        }
            break;
    }
    
    
    
    
    if(self.pageIndex == 9){
        UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"progressSummary"];
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    else{
        KBProgressView *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"progressView"];
        controller.pageIndex = self.pageIndex+1;
        
        
        [UIView animateWithDuration:.2 animations:^{
            self.muscleGroupLabel.transform = CGAffineTransformMakeTranslation(-200, 0);
            self.descriptionLabel.transform = CGAffineTransformMakeTranslation(-200, 0);
            self.muscleGroupLabel.alpha = 0;
            self.descriptionLabel.alpha = 0;
        } completion:^(BOOL finished) {
            [self.navigationController pushViewController:controller animated:NO];
        }];
        
    }
    
    

    
    
    
    
}

- (IBAction)back:(id)sender {
    
    if(self.pageIndex == 0){
        
    }
    
    [self.navigationController popViewControllerAnimated:NO];
}
@end
