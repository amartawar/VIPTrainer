/*
 
 The main chat interface for chatting with a single person.
 
 See "Chat.storyboard"
 
 */

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "KBChatView.h"
#import "KBChatCell.h"





@implementation KBChatView{
    UIRefreshControl *refresh; //Drag to refresh
    CGSize keyboardSize;
    CGRect lastFrame;
    NSDateFormatter *formatter;
    UIFont *labelFont;
}
@synthesize partnership;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.objects = [[NSArray alloc] init];
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"h:mm a"];
        labelFont = [UIFont fontWithName:@"Dosis-Medium" size:13.0];
        //Optionally for time zone converstions
        
        
        
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self animateTextField:textField up:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self animateTextField:textField up:NO];
}


//This is for moving the entire view up when the keyboard is shown. This class does not use KBViewController to handle keyboard.
- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    
    
    
    CGPoint newPoint = [textField.superview convertPoint:textField.frame.origin toView:self.view];
    int movementDistance;
    if(HAS_RETINA)
        movementDistance = -216;
    else
        movementDistance = -216;
    const float movementDuration = 0.3f; // tweak as needed
    
    if(up)
        lastFrame = self.view.frame;
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView animateWithDuration:.3 animations:^{
        if(up)
            self.view.frame = CGRectMake(0, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height+movementDistance);
        else
            self.view.frame = lastFrame;
    } completion:^(BOOL finished){
        
        [self scrollToBottom];
    }];
    
}

//Scrolls to the bottom of the chat list
-(void)scrollToBottom{
    if(self.objects.count > 1)
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.objects.count-1 inSection:0] atScrollPosition: UITableViewScrollPositionTop animated: YES];
}

- (void) animateTextFieldUp: (BOOL) up
{
    const int movementDistance = keyboardSize.height; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    
    if(up)
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    else
        self.view.frame = lastFrame;
    [UIView commitAnimations];
}

//Dynamic table view height for text that takes up more than one line.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellText = [[self.objects objectAtIndex:indexPath.row] objectForKey:@"message"];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    CGSize labelSize = [cellText sizeWithFont:labelFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];


    return labelSize.height + 44;
}


-(void)closeChat{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}



- (void)viewDidLoad {
    
    if(IS_CLIENT){
        [partnership.trainer fetchIfNeeded];
        
        self.title = partnership.trainer.firstName;
        
        DATA.chat_other_image = partnership.trainer.profilePicThumb; // The static class DATA holds the 2 images for the chat, so it isnt constantly downloaded.
        [DATA.chat_other_image getData]; //Downloads the actual image data from parse
        DATA.chat_my_image = [[User currentUser] profilePicThumb];
    }
    if(IS_TRAINER){
        [partnership.client fetchIfNeeded];
        [self.navigationItem setRightBarButtonItem:nil];
        self.title = partnership.client.firstName;
       DATA.chat_other_image = partnership.client.profilePicThumb;
        //[DATA.chat_other_image getData];
        DATA.chat_my_image = [[User currentUser] profilePicThumb];
    }
    
    refresh = [[UIRefreshControl alloc] init];
    
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    
    [refresh addTarget:self action:@selector(loadData)forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:refresh];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadData)
                                                 name:@"refreshCurrentChat"
                                               object:nil];
    
    
    [self loadData];
    
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



 - (void)loadData {
     DebugLog(@"loading data");
     [self.progress startAnimating];
     
     PFQuery *query = [Chat query];
     [query whereKey:@"partnership" equalTo:self.partnership];
     
 // If Pull To Refresh is enabled, query against the network by default.
     query.cachePolicy = kPFCachePolicyNetworkOnly;
 
 // If no objects are loaded in memory, we look to the cache first to fill the table
 // and then subsequently do a query against the network.
     if (self.objects.count == 0) {
         query.cachePolicy = kPFCachePolicyCacheThenNetwork;
     }
 
     [query orderByAscending:@"createdAt"];
 
     [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
         [self.progress stopAnimating];
         if(!error){
                self.objects = objects;
                 [self.tableView reloadData];
                 [refresh endRefreshing];
             if(objects.count > 0){
                self.noMessagesLabel.hidden = YES;
             }
             else{
                 self.noMessagesLabel.hidden = NO;
             }
             
             [self scrollToBottom];
         }
         
     }];
 }

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.messageField resignFirstResponder];
    return YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.objects.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:TRUE];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    Chat *chat = self.objects[indexPath.row];
    static NSString *myCellIdentifier = @"myCell"; // The cell identifier for OUR cell
    static NSString *otherCellIdentifier = @"otherCell"; // the cell identifier for the other person's cell
    
    KBChatCell *cell;
    
    if(USER_IS_BUYER){ //This might be changed to IS_CLIENT or IS_TRAINER. If the cells are backwards, this is why
        
        if([chat.sender.objectId isEqualToString:[[User currentUser] objectId]]){

            cell = (KBChatCell *)[tableView dequeueReusableCellWithIdentifier:myCellIdentifier];
            if (cell == nil) {
                cell = [[KBChatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCellIdentifier];
            }
            cell.chatLabel.text = chat.message;
            cell.chatImage.file = DATA.chat_my_image;
            cell.time.text =[formatter stringFromDate:chat.createdAt];
            
            
        }
        else{
            cell = (KBChatCell *)[tableView dequeueReusableCellWithIdentifier:otherCellIdentifier];
            if (cell == nil) {
                cell = [[KBChatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:otherCellIdentifier];
            }
            cell.chatLabel.text = chat.message;
            cell.chatImage.file = DATA.chat_other_image;
            cell.time.text =[formatter stringFromDate:chat.createdAt];
        }
        
    }
    else{ //If we are the "Seller" (trainer), OUR cell is the partnership.trainer, theirs is partnership.client.
        if([chat.sender.objectId isEqualToString:[[PFUser currentUser] objectId]]){

            cell = (KBChatCell *)[tableView dequeueReusableCellWithIdentifier:myCellIdentifier];
            if (cell == nil) {
                cell = [[KBChatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCellIdentifier];
            }
            cell.chatLabel.text = chat.message;
            cell.chatImage.file = DATA.chat_my_image;
                        cell.time.text =[formatter stringFromDate:chat.createdAt];
        }
        else{
            cell = (KBChatCell *)[tableView dequeueReusableCellWithIdentifier:otherCellIdentifier];
            if (cell == nil) {
                cell = [[KBChatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:otherCellIdentifier];
            }
            cell.chatLabel.text = chat.message;
            cell.chatImage.file = DATA.chat_other_image;
            cell.time.text =[formatter stringFromDate:chat.createdAt];
        }
    }
    [cell.chatImage loadInBackground]; //downloads the image from parse
    return cell;

    
}



//Sends the message. Connected to the send button
- (IBAction)send:(id)sender {
    
    if(self.messageField.text.length > 0){
        [self showProgress:@"sending"];
        
        Chat *chat = [Chat object];
        chat.partnership = partnership;
        chat.message = self.messageField.text;
        chat.sender = [User currentUser];
        
        if(IS_CLIENT)
            chat.recipient= partnership.trainer;
        if(IS_TRAINER)
            chat.recipient = partnership.client;
        
        [chat saveInBackgroundWithBlock:^(BOOL successful, NSError *error){
            [self hideProgress];
            if(!error){
                self.messageField.text = @"";
                [self loadData];
            }
            else{
                [self showMessage:[[error userInfo] objectForKey:@"error"]];
            }
        }];
    }

}

-(void)showMessage:(NSString *)message{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.yOffset = 150.f;
    hud.labelFont = [UIFont fontWithName:@"Dosis-Medium" size:12];
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}


-(void)showProgress:(NSString *)message{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.yOffset = 150.f;
    hud.labelFont = [UIFont fontWithName:@"Dosis-Medium" size:12];
    hud.removeFromSuperViewOnHide = YES;
}

-(void)hideProgress{
    [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow  animated:YES];
}
@end