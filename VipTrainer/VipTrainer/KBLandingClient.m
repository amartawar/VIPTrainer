//
//  KBLandingClient.m
//  VipTrainer
//
//  Created by kenney on 6/27/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBLandingClient.h"
#import "KBSplitViewController.h"
#import "KBProgressList.h"

@interface KBLandingClient ()

@end

@implementation KBLandingClient{
    UIImagePickerController *picker;
    int pictureSelectionIndex;
}

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
    
    if(!DATA.partnership)
       [self loadPartnership];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    

    
    [self refreshProgressViews];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)refreshProgressViews{
    if(DATA.progresses.count > 0){
        self.firstProgressImage.file = [[DATA.progresses lastObject] image];
        [self.firstProgressImage loadInBackground];
        self.firstPicButton.hidden = YES;
    }
    
    if(DATA.progresses.count > 1){
        self.secondProgressImage.file = [[DATA.progresses firstObject] image];
        [self.secondProgressImage loadInBackground];
        [self.secondPicButton setTitle:@"" forState:UIControlStateNormal];
        [self.secondPicButton setTitle:@"" forState:UIControlStateHighlighted];
        
        int startWeight = [[[DATA.progresses lastObject] weight] intValue];
        int endWeight = [[[DATA.progresses firstObject] weight] intValue];
        
        if(startWeight > endWeight)
            self.progressLabel.text = [NSString stringWithFormat:@"You lost %i lbs", startWeight-endWeight];
        else if(endWeight > startWeight)
            self.progressLabel.text = [NSString stringWithFormat:@"You gained %i lbs", startWeight-endWeight];
        else
            self.progressLabel.text = @"";
    }
    else
        self.progressLabel.text = @"";
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)loadPartnership{
    [self showProgress:@"Loading Clients"];
    PFQuery *query = [Partnership query];
    //[query whereKey:@"interests" containsAllObjectsInArray:DATA.user.interests];
    [query whereKey:@"client" equalTo:[User currentUser]];
    [query includeKey:@"trainer"];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        [self hideProgress];
        
        if(!error){
            if(object)
                DATA.partnership = (Partnership *)object;
            
            [self loadProgress];
        }
        else{
            [self showMessage:@"You do not currently have a trainer"];
        }
        
    }];
    
}

-(void)loadProgress{
    [self showProgress:@"Loading Progress History"];
    
    [DATA.progresses removeAllObjects];
    PFQuery *query = [Progress query];
    [query whereKey:@"user" equalTo:CURRENTUSER];
    [query  orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [self hideProgress];
        if(!error){
            DATA.progresses = objects;
            [self refreshProgressViews];
            
            
        }
        else{
            
        }
    }];
}



- (IBAction)chat:(id)sender {
    KBSplitViewController *split = (KBSplitViewController *)self.navigationController.parentViewController;
    [split loadChats];
}

- (IBAction)assessment:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Workout" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"assessmentList"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)diet:(id)sender {
    
}

- (IBAction)nutrition:(id)sender {
    
    KBSplitViewController *split = (KBSplitViewController *)self.navigationController.parentViewController;
    [split loadClientNutrition];
    
    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"clientNutrition"];
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)workout:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Workout" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"todayWorkout"];
    [self.navigationController presentViewController:controller animated:YES completion:nil];
}

- (IBAction)addProgress:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Progress" bundle:nil];
    KBProgressList *controller = [storyboard instantiateInitialViewController];
    controller.isModal = YES;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)takeFirstPic:(id)sender {
    pictureSelectionIndex = 0;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Load Image" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Photos", @"Camera", nil];
        [alert show];
    }
    else{
        [self pickImageFromLibrary];
    }
}

- (IBAction)takeProgressPic:(id)sender {
    pictureSelectionIndex = 1;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Load Image" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Photos", @"Camera", nil];
        [alert show];
    }
    else{
        [self pickImageFromLibrary];
    }
}


-(void)pickImageFromCamera{
    
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:nil];
    
}

-(void)pickImageFromLibrary{
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *) Picker

didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    
    UIImage *origionalImage =[info objectForKey:UIImagePickerControllerOriginalImage];
    
    if(pictureSelectionIndex == 0){
        if(origionalImage){
            
            [self.firstPicButton setTitle:@"" forState:UIControlStateNormal];
            [self.firstPicButton setTitle:@"" forState:UIControlStateDisabled];
            [self.firstPicButton setTitle:@"" forState:UIControlStateHighlighted];
            
            UIImage *scaledImage =[self imageWithImage:origionalImage scaledToSize:CGSizeMake(200, 200)];
            
            NSData *picData = UIImageJPEGRepresentation(scaledImage, 1);
            PFFile *picFile = [PFFile fileWithName:@"firstProgressPic.jpg" data:picData];
            
            DATA.user.firstProgressPic = picFile;
            
            [self showProgress:@"Saving Image"];
            [DATA.user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                [self hideProgress];
                if(!error){
                    [self showMessage:@"Image Saved"];
                }
                else{
                    [self showMessage:@"Couldn't save image"];
                }
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            
            self.firstProgressImage.image = scaledImage;
        }
        

    }
    else{
        if(origionalImage){
            
            [self.progressPicButton setTitle:@"" forState:UIControlStateNormal];
            [self.progressPicButton setTitle:@"" forState:UIControlStateDisabled];
            [self.progressPicButton setTitle:@"" forState:UIControlStateHighlighted];
            
            UIImage *scaledImage =[self imageWithImage:origionalImage scaledToSize:CGSizeMake(200, 200)];
            
            NSData *picData = UIImageJPEGRepresentation(scaledImage, 1);
            PFFile *picFile = [PFFile fileWithName:@"latestProgressPic.jpg" data:picData];
            
            DATA.user.latestProgressPic = picFile;
            
            [self showProgress:@"Saving Image"];
            [DATA.user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                [self hideProgress];
                if(!error){
                    [self showMessage:@"Image Saved"];
                }
                else{
                    [self showMessage:@"Couldn't save image"];
                }
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            
            self.secondProgressImage.image = scaledImage;
            
        }

    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *) Picker {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize
{
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


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        [self pickImageFromLibrary];
    }
    else if(buttonIndex == 2){
        [self pickImageFromCamera];
    }
}



@end
