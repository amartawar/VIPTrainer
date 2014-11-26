//
//  KBToggle.m
//
//
//  Created by kenney on 1/5/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//


// Mostly Legacy code. I dont think this is used anywhere

#import "KBTermsToggle.h"


@implementation KBTermsToggle{
    UIImageView *imageView;
    CAShapeLayer *circleLayer;
    UIBezierPath *path;
}
@synthesize on = _on;

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        
        circleLayer = [CAShapeLayer layer];
        
        // maskLayer.anchorPoint = CGPointMake(.5, .5);
        float width = .5;
        circleLayer.lineWidth = width;
        circleLayer.fillColor = [[UIColor clearColor] CGColor];
        circleLayer.strokeColor = [vipBrightGreen CGColor];
        
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
        path = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:5];
        
        circleLayer.path = [path CGPath];

        [self.layer addSublayer:circleLayer];

        self.adjustsImageWhenHighlighted=YES;
        [self addTarget:self action:@selector(toggleOn) forControlEvents:UIControlEventTouchUpInside];
        self.backgroundColor = [UIColor clearColor];
        
        [self setTitleColor:vipBrightGreen forState:UIControlStateNormal];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        circleLayer = [CAShapeLayer layer];
        
        // maskLayer.anchorPoint = CGPointMake(.5, .5);
        float width = 1.0;
        circleLayer.lineWidth = width;
        circleLayer.fillColor = [[UIColor clearColor] CGColor];
        circleLayer.strokeColor = [vipBrightGreen CGColor];
        
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        path = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:5];
        
        circleLayer.path = [path CGPath];
        
        [self.layer addSublayer:circleLayer];
        
        self.adjustsImageWhenHighlighted=YES;
        [self addTarget:self action:@selector(toggleOn) forControlEvents:UIControlEventTouchUpInside];
        self.backgroundColor = [UIColor clearColor];
        
        [self setTitleColor:vipBrightGreen forState:UIControlStateNormal];
    }
    return self;
}

-(void)toggleOn{
    [self setOn:!_on];
}

-(void)setOn:(BOOL)on{

    if(on){
        circleLayer.fillColor = [vipBrightGreen CGColor];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else{
        circleLayer.fillColor = [[UIColor clearColor] CGColor];
        [self setTitleColor:vipBrightGreen forState:UIControlStateNormal];
    }
    _on = on;
}
-(BOOL)isOn{
    return _on;
}

@end
