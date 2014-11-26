//
//  KBRoundedRectOutline.m
//  Peach
//
//  Created by kenney on 1/15/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBRoundedRectOutline.h"

@implementation KBRoundedRectOutline{
    UIImageView *imageView;
    CAShapeLayer *circleLayer;
    UIBezierPath *path;
}

-(void)awakeFromNib{
    
    circleLayer = [CAShapeLayer layer];
    
    // maskLayer.anchorPoint = CGPointMake(.5, .5);
    float width = self.ringWidth? self.ringWidth : 1.0;
    float roundness = self.cornerRadius? self.cornerRadius : 0;
    circleLayer.strokeColor = self.ringColor? [self.ringColor CGColor] : [vipBrightGreen CGColor];
    circleLayer.fillColor = self.backgroundColor? [self.backgroundColor CGColor]  : [[UIColor clearColor] CGColor];
    
    circleLayer.lineWidth = width;
    
    CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    path = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:roundness];
    
    circleLayer.path = [path CGPath];
    
    //[self.layer addSublayer:circleLayer];
    [self.layer insertSublayer:circleLayer atIndex:0];
    
    
    self.backgroundColor = [UIColor clearColor];
    
    [super awakeFromNib];
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        
           }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
@end