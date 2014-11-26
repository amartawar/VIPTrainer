//
//  KBLabel.m
//  Peach
//
//  Created by kenney on 12/28/13.
//  Copyright (c) 2013 Kyle. All rights reserved.
//

#import "KBLabel.h"

@implementation KBLabel
@synthesize placeholderColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib { [super awakeFromNib]; self.font = [UIFont fontWithName:@"Dosis-Medium" size:self.font.pointSize]; }

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
@end
