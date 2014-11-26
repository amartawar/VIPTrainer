//
/*
    This class lists all of the chat threads sorted by date.
 
    See "Chat.storyboard"

*/

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "KBChatView.h"
#import "KBChatList.h"
#import "KBChatCell.h"


@implementation KBChatList{
    NSDateFormatter *formatter;
    NSDateFormatter *dateformatter;
    NSMutableArray *sections;
    NSMutableArray *sectionNames;
    BOOL firstDisplay;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        self.chats = [[NSMutableArray alloc] init];
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"h:mm a"];
        dateformatter = [[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"MMM d yyyy"];
        
        sections = [[NSMutableArray alloc] init];
        sectionNames = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)closeChat{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UIViewController

- (void)viewDidLoad {

    //This is sent out by AppDelegate when a push notification is recieved
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadChats)
                                                 name:@"refreshAllChats"
                                               object:nil];
    
    [super viewDidLoad];
    [self reloadChats];

}


//Reloads the chat data from parse and refreshes the view
-(void)reloadChats{
    self.title = @"Chats";
    
    [self.progress startAnimating];
    PFQuery *query = [Partnership query];
    
    if(IS_CLIENT){
        [query whereKey:@"client" equalTo:[User currentUser]];
    }
    else{
        [query whereKey:@"trainer" equalTo:[User currentUser]];
    }
    
    [query includeKey:@"client"];
    [query includeKey:@"trainer"];
    [query orderByDescending:@"createdAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        [self.chats removeAllObjects];
        self.chats = results;
        [self sortChats];
        [self.tableView reloadData];
        [self.progress stopAnimating];
        
        //Shows "No Chats" if there are 0 chats.
        if(self.chats.count ==0)
            self.noChatsLabel.hidden=NO;
        else
             self.noChatsLabel.hidden=YES;
        
    }];
}


//Takes each chat object, and sorts into an array of "Sections" which contain arrays of "chat threads" for each date.
-(void)sortChats{
    
    
    [sections removeAllObjects];
    [sectionNames removeAllObjects];
    
    //Group by date
    NSMutableArray *datesStrings = [[NSMutableArray alloc] init];
    for(int i = 0; i < self.chats.count; i++){
        PFObject *chatObject = [self.chats objectAtIndex:i];
        NSString *dateString = [dateformatter stringFromDate:[chatObject updatedAt]];
        
        if(![datesStrings containsObject:dateString]){
            [datesStrings addObject:dateString];
            NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:chatObject, nil];
            [sections addObject:array];
        }
        else{
            [[sections objectAtIndex:[datesStrings indexOfObject:dateString]] addObject:chatObject];
        }
    }
    
    sectionNames = datesStrings;

}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    firstDisplay = true;
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return sectionNames.count;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.transform = CGAffineTransformTranslate(cell.transform, -50, 0);
    cell.alpha = 0;
    
    if(firstDisplay){
        
        int cellsAbove = 0;
        for(int i = 0; i < indexPath.section; i++){
            
            int numberInSection = [self tableView:tableView numberOfRowsInSection:i];
            
            cellsAbove += numberInSection;
        }
        
        cellsAbove += indexPath.row;
        
        //This is the animation when you load the chatlist that makes them "flow" in. firstDisplay is a flag for whether or not the view has been shown.
        [UIView animateWithDuration:.2 delay:cellsAbove*.08 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            cell.transform = CGAffineTransformIdentity;
            cell.alpha = 1;
        } completion:^(BOOL finished) {
            firstDisplay = false;
        }];
    }
    else{
        
        //This is the animation when you scroll the chatlist to reveal new cells.
        [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            cell.transform = CGAffineTransformIdentity;
            cell.alpha = 1;
        } completion:^(BOOL finished) {}];
        
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 40)];
    view.backgroundColor = vipLightGray;
    
    
    KBLabel *label = [[KBLabel alloc] init];
    [label setTextAlignment:NSTextAlignmentCenter];
    label.text =[sectionNames objectAtIndex:section];
    label.textColor = [UIColor whiteColor];
    [label sizeToFit];
    
    label.frame = CGRectOffset(label.frame, (self.tableView.frame.size.width/2)-(label.frame.size.width/2), 0);
    
    [view addSubview:label];
    
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[sections objectAtIndex:section] count];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self showProgress:@"Deleting Thread"];
    
    PFObject *chatThread =[[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if(USER_IS_BUYER){
        chatThread[@"hideBuyer"] = [NSNumber numberWithBool:YES];
    }
    else{
        chatThread[@"hideSeller"] = [NSNumber numberWithBool:YES];
    }
    
    [chatThread saveInBackgroundWithBlock:^(BOOL succeed, NSError *error){
        [self hideProgress];
        [self reloadChats];
    }];
    
    
    
    /*[[[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] deleteInBackgroundWithBlock:^(BOOL succeed, NSError *error){
        [self hideProgress];
        [self reloadChats];
    }];*/
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *otherCell = @"otherCell";
    
    Partnership *chat = [[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    KBChatCell *cell = (KBChatCell *)[tableView dequeueReusableCellWithIdentifier:otherCell];
    if (cell == nil) {
        cell = [[KBChatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:otherCell];
    }
    
    // Configure the cell
    
    if(IS_CLIENT)
        cell.chatImage.file = chat.trainer.profilePicThumb;
    if(IS_TRAINER)
        cell.chatImage.file = chat.client.profilePicThumb;
    
    [cell.chatImage loadInBackground];
    
    if(IS_CLIENT)
        cell.chatName.text  = chat.trainer.firstName;
    if(IS_TRAINER)
        cell.chatName.text  = chat.client.firstName;
    
    //cell.chatProductsLabel.text = [chat objectForKey:@"productName"];
    cell.chatLabel.text = chat.lastMessage;
    cell.time.text =[formatter stringFromDate:[chat updatedAt]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //DATA.chatThread = [[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row ];
    //DebugLog(@"chatThread:%@", DATA.chatThread);
    
    
    KBChatView *chatview = [self.storyboard instantiateViewControllerWithIdentifier:@"chatView"];
    chatview.partnership = [[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row ];
    [self.navigationController pushViewController:chatview animated:YES];
    
    //[self performSegueWithIdentifier:@"chatViewFromList" sender:nil];
    
    
}

@end