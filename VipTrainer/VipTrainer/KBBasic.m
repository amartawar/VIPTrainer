//
//  KBSignup.m
//  VipTrainer
//
//  Created by kenney on 4/1/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBBasic.h"

@interface KBBasic ()
@property(nonatomic,strong)NSMutableArray *arrMenu;
@end

@implementation KBBasic{

    UIImagePickerController *picker;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(self.arrMenu==nil){
        self.arrMenu=[NSMutableArray array];
    }
    [self.arrMenu removeAllObjects];
    [self.arrMenu addObject:@"About Me"];
    [self.arrMenu addObject:@"Professional Experience"];
    [self.arrMenu addObject:@"Training/Sports Experience"];
    [self.arrMenu addObject:@"Area of speciality"];
    [self.arrMenu addObject:@"Certifications"];
    [self.arrMenu addObject:@"Suceess Stories"];
    [self.arrMenu addObject:@"Account Preferences"];
    [self.tblMenu reloadData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)next:(id)sender {
    
    if(![self.firstNameField.text isValidNonEmptyString]){
        [self showMessage:@"You must enter a valid first name"];
        return;
    }
    if(![self.lastNameField.text isValidNonEmptyString]){
        [self showMessage:@"You must enter a valid last name"];
        return;
    }
    if(!DATA.user.profilePicThumb){
        [self showMessage:@"You must choose a profile picture"];
        return;
    }
    if(![self.emailField.text isValidNonEmptyString]){
        [self showMessage:@"You must enter an email address"];
        return;
    }
    if(![self.ageField.text isValidNonEmptyString]){
        [self showMessage:@"You must enter your age"];
        return;
    }
    if(![self.passwordField.text isValidNonEmptyString]){
        [self showMessage:@"You must enter a password"];
        return;
    }
    if(![self.confrimPasswordField.text isValidNonEmptyString]){
        [self showMessage:@"Please confirm your password"];
        return;
    }
    if(![self.passwordField.text isEqualToString:self.confrimPasswordField.text]){
        [self showMessage:@"Passwords do not match"];
        return;
    }
    
    DATA.user.firstName = self.firstNameField.text;
    DATA.user.lastName = self.lastNameField.text;
    DATA.user.phone = self.phoneField.text;
    DATA.user.gender = self.genderControl.selectedSegmentIndex? @"female" : @"male";
    
    DATA.user.age = self.ageField.text;
    
    if([self.phoneField.text isValidNonEmptyString]){
        DATA.user.phone = self.phoneField.text;
    }
    
    DATA.user.email = self.emailField.text;
    DATA.user.password = self.passwordField.text;
    
    
    DATA.user.username = DATA.user.email;
    
    KBInterestsList *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"interestsList"];
    [controller setDelegate:self];
    [self.navigationController pushViewController:controller animated:YES];
    
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
        [self.addPictureButton setTitle:@"" forState:UIControlStateNormal];
        [self.addPictureButton setTitle:@"" forState:UIControlStateDisabled];
        [self.addPictureButton setTitle:@"" forState:UIControlStateHighlighted];
    }
    
    UIImage *scaledImage =[self imageWithImage:origionalImage scaledToSize:CGSizeMake(600, 600)];
    UIImage *scaledThumbnailImage =[self imageWithImage:origionalImage scaledToSize:CGSizeMake(200, 200)];
    
    NSData *profPicData = UIImageJPEGRepresentation(scaledImage, 1);
    PFFile *profPicFile = [PFFile fileWithName:@"picture.jpg" data:profPicData];
    
    NSData *profPicThumbData = UIImageJPEGRepresentation(scaledThumbnailImage, 1);
    PFFile *profPicThumbFile = [PFFile fileWithName:@"picture_thumb.jpg" data:profPicThumbData];
    
    DATA.user.profilePic = profPicFile;
    DATA.user.profilePicThumb = profPicThumbFile;
    self.profilePictureImage.image = scaledImage;
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

-(void)KBInterestsListSave{
    
    if(IS_CLIENT){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Client" bundle:nil];
        UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"chooseTrainer"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if(IS_TRAINER){
        UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"qualifications"];
        [self.navigationController pushViewController:controller animated:YES];
    }
}


- (IBAction)loadPicture:(id)sender {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Load Image" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Photos", @"Camera", nil];
        [alert show];
    }
    else{
        [self pickImageFromLibrary];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.arrMenu count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
    }
    cell.textLabel.text=[self.arrMenu objectAtIndex:indexPath.row];
    return cell;
}


@end
