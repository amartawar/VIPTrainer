//
//  KBLabel.m
//  Peach
//
//  Created by kenney on 12/28/13.
//  Copyright (c) 2013 Kyle. All rights reserved.
//

#import "KBButton.h"

@implementation KBButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib]; self.titleLabel.font = [UIFont fontWithName:@"Dosis-Medium" size:self.titleLabel.font.pointSize];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
@end
