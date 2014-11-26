//
//  KBExerciseBuilder.m
//  VipTrainer
//
//  Created by kenney on 4/16/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBExerciseBuilder.h"
#import "NSDictionary+JSON.h"

@interface KBExerciseBuilder ()

@end

@implementation KBExerciseBuilder{
    UIImagePickerController *picker;
}

@synthesize exerciseIndex = exercise_index;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)tapOff:(id)sender {
    [self.view endEditing:YES];
    DebugLog(@"tapped off");
}

-(void)hideKeyboard
{
    [self.view endEditing:YES];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UIControl class]]) {
        // we touched a button, slider, or other UIControl
        return NO; // ignore the touch
    }
    return YES; // handle the touch
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tapGesture.delegate = self;
    // prevents the scroll view from swallowing up the touch event of child buttons
    tapGesture.cancelsTouchesInView = NO;
    tapGesture.delaysTouchesBegan = NO;
    tapGesture.delaysTouchesEnded = NO;
    
    [self.scrollView addGestureRecognizer:tapGesture];
    
    [self loadWorkout];
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setExerciseIndex:(int)exerciseIndex{
    exercise_index = exerciseIndex;
    [self loadWorkout];
}

-(void)loadWorkout{
    
    if(self.exerciseIndex >= DATA.selectedWorkout.exercises.count)
        return;
    
    NSData *data = [DATA.selectedWorkout.exercises[self.exerciseIndex] dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error;
    NSDictionary *exercise = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:&error];
    
    if(!self.nameField)
        return;
    
    if(!error){
        self.nameField.text = [exercise objectForKey:@"name"];
        self.descriptionField.text = [exercise objectForKey:@"description"];
        self.setsField.text = [exercise objectForKey:@"sets"];
        self.repsField.text = [exercise objectForKey:@"reps"];
        self.weightField.text = [exercise objectForKey:@"weight"];
        self.timeField.text = [exercise objectForKey:@"time"];
        self.commentsField.text = [exercise objectForKey:@"comments"];
    }
}

- (IBAction)save:(id)sender {
    
    
    if(![self.nameField.text isValidNonEmptyString]){
       [self showMessage:@"Please enter an exercise name"];
        return;
    }
    
    NSMutableDictionary *exercise = [[NSMutableDictionary alloc] init];
    [exercise setObject:self.nameField.text forKey:@"name"];
    [exercise setObject:self.descriptionField.text forKey:@"description"];
    [exercise setObject:self.setsField.text forKey:@"sets"];
    [exercise setObject:self.repsField.text forKey:@"reps"];
    [exercise setObject:self.weightField.text forKey:@"weight"];
    [exercise setObject:self.timeField.text forKey:@"time"];
    [exercise setObject:self.commentsField.text forKey:@"muscles"];
    [exercise setObject:self.commentsField.text forKey:@"comments"];
    
    NSString *json = [exercise jsonStringWithPrettyPrint:YES];
    
    if(self.exerciseIndex >= DATA.selectedWorkout.exercises.count)
        [DATA.selectedWorkout.exercises addObject:json];
    else
        DATA.selectedWorkout.exercises[self.exerciseIndex] = json;
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)presets:(id)sender {
}



- (IBAction)loadImage:(id)sender {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Load Image" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Photos", @"Camera", nil];
        alert.tag = 0;
        [alert show];
    }
    else{
        [self pickImageFromLibrary];
    }
}

-(void)pickImageFromCamera{
    
    [self.view endEditing:YES];
    
    picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:nil];
    
}

-(void)pickImageFromLibrary{
    
    [self.view endEditing:YES];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *) Picker

didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    //DATA.selectedItem.image0 = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.exerciseImage.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.addImageIcon.hidden = YES;

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *) Picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(alertView.tag == 0){
        if(buttonIndex == 1){
            [self pickImageFromLibrary];
        }
        else if(buttonIndex == 2){
            [self pickImageFromCamera];
        }
    }
}

- (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize
{
    
    
    if(!image)
        return nil;
    
    float sf;
    if(image.size.width > image.size.height)
        sf = image.size.width / newSize.width;
    else
        sf = image.size.height / newSize.height;
    
    float newWidth = image.size.width / sf;
    float newHeight = image.size.height / sf;
    UIGraphicsBeginImageContext( CGSizeMake(newWidth, newHeight) );
    [image drawInRect:CGRectMake(0,0,newWidth,newHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
