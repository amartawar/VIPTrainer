//
//  KBMedicalCell.m
//  VipTrainer
//
//  Created by kenney on 4/6/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBMedicalCell.h"

@implementation KBMedicalCell{
    BOOL isExpanded;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setExpanded:(BOOL)expanded{
    if(expanded){
        self.nameField.hidden = NO;
        self.affectedField.hidden = NO;
        self.commentsField.hidden = NO;
        self.nameLabel.hidden = YES;
        
        
        [UIView animateWithDuration:.5 animations:^{
            self.indicator.transform = CGAffineTransformMakeRotation(3.14);
        } completion:^(BOOL finished) {
        }];
    }
    else{
        self.nameField.hidden = YES;
        self.affectedField.hidden = YES;
        self.commentsField.hidden = YES;
        self.nameLabel.hidden = NO;
        [UIView animateWithDuration:.5 animations:^{
            self.indicator.transform = CGAffineTransformMakeRotation(0);
        } completion:^(BOOL finished) {
        }];
    }
}

@end
