//
//  KBChatView.h
//  Peach
//
//  Created by kenney on 12/20/13.
//  Copyright (c) 2013 Kyle. All rights reserved.
//

#import <Parse/Parse.h>
#import "Partnership.h"
#import "Chat.h"

@interface KBChatView : KBViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
- (IBAction)send:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *messageField;
@property (nonatomic) NSString *otherParty;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *messageView;
- (IBAction)placeOrder:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *placeOrderButton;
@property (weak, nonatomic) IBOutlet KBLabel *noMessagesLabel;
@property (nonatomic, strong) NSArray *objects;
@property (nonatomic, strong) Partnership *partnership;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progress;
-(void)closeChat;
@end
