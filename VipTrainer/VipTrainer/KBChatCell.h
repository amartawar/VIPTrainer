//
//  KBChatCell.h
//  Peach
//
//  Created by kenney on 12/20/13.
//  Copyright (c) 2013 Kyle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBChatCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *chatImage;
@property (weak, nonatomic) IBOutlet UILabel *chatLabel;
@property (weak, nonatomic) IBOutlet UILabel *chatName;
@property (weak, nonatomic) IBOutlet KBLabel *time;
@property (weak, nonatomic) IBOutlet KBLabel *chatProductsLabel;

@end
