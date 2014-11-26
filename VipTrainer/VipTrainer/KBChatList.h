//
//  KBChatList.h
//  Peach
//
//  Created by kenney on 12/28/13.
//  Copyright (c) 2013 Kyle. All rights reserved.
//

#import <Parse/Parse.h>
#import "Chat.h"

@interface KBChatList : KBViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *chats;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progress;
@property (weak, nonatomic) IBOutlet UILabel *noChatsLabel;
@property (nonatomic, strong) NSMutableArray *chatNames;
@end
