//
//  KBInterestsRowCell.m
//  Peach
//
//  Created by kenney on 1/5/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBInterestsRowCell.h"

@implementation KBInterestsRowCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if(selected)
        [self.checkbox setImage:[UIImage imageNamed:@"checkbox_checked.png"]];
    else
        [self.checkbox setImage:[UIImage imageNamed:@"checkbox.png"]];
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
