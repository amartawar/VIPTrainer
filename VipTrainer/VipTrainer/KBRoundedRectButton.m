//
//  RoundedRectButton.m
//  VendevorIpad
//
//  Created by kyle barnes on 5/22/13.
//  Copyright (c) 2013 Kyle Barnes. All rights reserved.
//

#import "KBRoundedRectButton.h"

@implementation KBRoundedRectButton

@synthesize Background_Color;
@synthesize Highlighted_Color;
@synthesize Disabled_Color;
@synthesize backgroundAlpha;
@synthesize bottomLeftRounded;
@synthesize bottomRightRounded;
@synthesize topLeftRounded;
@synthesize topRightRounded;
@synthesize color;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(buttonPressed:forEvent:) forControlEvents:UIControlEventTouchUpInside];
        self.Background_Color = self.backgroundColor;
        self.backgroundColor = [UIColor clearColor];
        self.Disabled_Color = vipLightGray;
        self.backgroundAlpha = 1;
        self.color = darkGray;

    }
    return self;
}
-(id)init{
    self = [super init];
    if(self){
        self.Background_Color = self.backgroundColor;
        self.Highlighted_Color = vipLightGreen;
        self.Disabled_Color = vipLightGray;
        self.backgroundColor = [UIColor clearColor];
        self.backgroundAlpha = 1;
        self.color = darkGray;

    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addTarget:self action:@selector(buttonReleased:forEvent:) forControlEvents:UIControlEventTouchCancel];
        [self addTarget:self action:@selector(buttonReleased:forEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(buttonReleased:forEvent:) forControlEvents:UIControlEventTouchUpOutside];
        [self addTarget:self action:@selector(buttonPressed:forEvent:) forControlEvents:UIControlEventTouchDown];
        self.Background_Color = self.backgroundColor;
        self.Highlighted_Color = vipLightGreen;
        self.Disabled_Color = vipLightGray;
        self.backgroundColor = [UIColor clearColor];
        self.backgroundAlpha = 1;
        self.color = darkGray;
        
       // [self setAll];
    }
    return self;
}

- (IBAction)buttonPressed:(id)sender forEvent:(UIEvent *)event
{
    self.highlighted = true;
    [self setNeedsDisplay];
}
- (IBAction)buttonReleased:(id)sender forEvent:(UIEvent *)event
{
    self.highlighted = false;
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
}

- (void)drawRect:(CGRect)rect{
    
    
    UIBezierPath *path;
    
    if(self.topLeftRounded && self.topRightRounded && self.bottomLeftRounded && self.bottomRightRounded)
        path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:3];
    
    else if(self.topLeftRounded && self.topRightRounded && self.bottomLeftRounded && !self.bottomRightRounded)
        path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:(UIRectCornerTopLeft| UIRectCornerTopRight| UIRectCornerBottomLeft) cornerRadii:CGSizeMake(3, 3)];
    
    else if(self.topLeftRounded && self.topRightRounded && !self.bottomLeftRounded && self.bottomRightRounded)
        path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:(UIRectCornerTopLeft| UIRectCornerTopRight| UIRectCornerBottomRight) cornerRadii:CGSizeMake(3, 3)];
    
    else if(self.topLeftRounded && self.topRightRounded && !self.bottomLeftRounded && !self.bottomRightRounded)
        path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:(UIRectCornerTopLeft| UIRectCornerTopRight) cornerRadii:CGSizeMake(3, 3)];
    
    else if(self.topLeftRounded && !self.topRightRounded && self.bottomLeftRounded && self.bottomRightRounded)
        path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:(UIRectCornerTopLeft| UIRectCornerBottomLeft| UIRectCornerBottomRight) cornerRadii:CGSizeMake(3, 3)];
    
    else if(self.topLeftRounded && !self.topRightRounded && self.bottomLeftRounded && !self.bottomRightRounded)
        path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:(UIRectCornerTopLeft| UIRectCornerBottomLeft) cornerRadii:CGSizeMake(3, 3)];
    
    else if(self.topLeftRounded && !self.topRightRounded && !self.bottomLeftRounded && self.bottomRightRounded)
        path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:(UIRectCornerTopLeft| UIRectCornerBottomRight) cornerRadii:CGSizeMake(3, 3)];
    
    else if(self.topLeftRounded && !self.topRightRounded && !self.bottomLeftRounded && !self.bottomRightRounded)
        path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:(UIRectCornerTopLeft) cornerRadii:CGSizeMake(3, 3)];
    
    else if(!self.topLeftRounded && self.topRightRounded && self.bottomLeftRounded && self.bottomRightRounded)
        path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:(UIRectCornerTopRight| UIRectCornerBottomLeft| UIRectCornerBottomRight) cornerRadii:CGSizeMake(3, 3)];
    
    else if(!self.topLeftRounded && self.topRightRounded && self.bottomLeftRounded && !self.bottomRightRounded)
        path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:(UIRectCornerTopRight| UIRectCornerBottomLeft) cornerRadii:CGSizeMake(3, 3)];
    
    else if(!self.topLeftRounded && self.topRightRounded && !self.bottomLeftRounded && self.bottomRightRounded)
        path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:(UIRectCornerTopRight| UIRectCornerBottomRight) cornerRadii:CGSizeMake(3, 3)];
    
    else if(!self.topLeftRounded && self.topRightRounded && !self.bottomLeftRounded && !self.bottomRightRounded)
        path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:(UIRectCornerTopRight) cornerRadii:CGSizeMake(3, 3)];
    
    else if(!self.topLeftRounded && !self.topRightRounded && self.bottomLeftRounded && self.bottomRightRounded)
        path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:(UIRectCornerBottomLeft| UIRectCornerBottomRight) cornerRadii:CGSizeMake(3, 3)];
    
    else if(!self.topLeftRounded && !self.topRightRounded && self.bottomLeftRounded && !self.bottomRightRounded)
        path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:(UIRectCornerBottomLeft) cornerRadii:CGSizeMake(3, 3)];
    
    else if(!self.topLeftRounded && !self.topRightRounded && !self.bottomLeftRounded && self.bottomRightRounded)
        path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:(UIRectCornerBottomRight) cornerRadii:CGSizeMake(3, 3)];
    
    else if(!self.topLeftRounded && !self.topRightRounded && !self.bottomLeftRounded && !self.bottomRightRounded)
        path = [UIBezierPath bezierPathWithRect:rect];
    
    
    if(self.isHighlighted){
        [Highlighted_Color setFill];
        [path fill];
    }
    else if(!self.isEnabled){
        [Disabled_Color setFill];
        [path fill];
    }
    else{
        switch(self.color){
            case green:
                
                [vipBrightGreen setFill];
                [path fill];
                
                break;
            case darkGray:
                [vipLightGray setFill];
                [path fill];
                
                break;
            case white:
                [[UIColor whiteColor] setFill];
                [path fill];
                break;
        }    }
    

    
    
}
    -(void)setTop{
        self.topLeftRounded = YES;
        self.topRightRounded = YES;
    }
    -(void)setBottom{
        self.bottomLeftRounded = YES;
        self.bottomRightRounded = YES;
    }
    -(void)setAll{
        self.topLeftRounded = YES;
        self.topRightRounded = YES;
        self.bottomLeftRounded = YES;
        self.bottomRightRounded = YES;
    }
@end
