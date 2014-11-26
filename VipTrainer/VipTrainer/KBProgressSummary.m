//
//  KBProgressSummary.m
//  VipTrainer
//
//  Created by kenney on 7/20/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBProgressSummary.h"

@interface KBProgressSummary ()

@end

@implementation KBProgressSummary{
    
    UIImagePickerController *picker;
}
@synthesize progress;

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
    
    self.neckLabel.text = [NSString stringWithFormat:@"%@ %@", DATA.selectedProgress.neck, @"in"];
    self.shouldersLabel.text = [NSString stringWithFormat:@"%@ %@", DATA.selectedProgress.shoulders, @"in"];
    self.chestLabel.text = [NSString stringWithFormat:@"%@ %@", DATA.selectedProgress.chest, @"in"];
    self.bicepsLabel.text = [NSString stringWithFormat:@"%@ %@", DATA.selectedProgress.biceps, @"in"];
    self.forearmsLabel.text = [NSString stringWithFormat:@"%@ %@", DATA.selectedProgress.forearms, @"in"];
    self.waistLabel.text = [NSString stringWithFormat:@"%@ %@", DATA.selectedProgress.waist, @"in"];
    self.thighsLabel.text = [NSString stringWithFormat:@"%@ %@", DATA.selectedProgress.thighs, @"in"];
    self.calvesLabel.text = [NSString stringWithFormat:@"%@ %@", DATA.selectedProgress.calves, @"in"];
    self.bodyFatLabel.text = [NSString stringWithFormat:@"%@ %@", DATA.selectedProgress.bodyFat, @"%"];
    self.weightLabel.text = [NSString stringWithFormat:@"%@ %@", DATA.selectedProgress.weight, @"lbs"];
    

    
    [self.imageView setFile:DATA.selectedProgress.image];
    [self.imageView loadInBackground];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePicture:(id)sender {
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
    
    if(origionalImage){
        [self.takePictureButton setTitle:@"" forState:UIControlStateNormal];
        [self.takePictureButton setTitle:@"" forState:UIControlStateDisabled];
        [self.takePictureButton setTitle:@"" forState:UIControlStateHighlighted];
    }
    
    UIImage *scaledImage =[self imageWithImage:origionalImage scaledToSize:CGSizeMake(600, 600)];

    
    NSData *profPicData = UIImageJPEGRepresentation(scaledImage, 1);
    PFFile *profPicFile = [PFFile fileWithName:@"progress.jpg" data:profPicData];
    

    
    DATA.selectedProgress.image = profPicFile;
    self.imageView.image = scaledImage;
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
- (IBAction)save:(id)sender {
    
    DATA.selectedProgress.user = CURRENTUSER;
    
    
    [self showProgress:@"Saving Progress"];
    [DATA.selectedProgress saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self hideProgress];
        if(!error){
            [self showMessage:@"Progress saved!"];
            [DATA.progresses insertObject:DATA.selectedProgress atIndex:0];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            
        }
        else{
            [self showMessage:@"Unable to save progress"];
        }
    }];
    
    
}
@end
