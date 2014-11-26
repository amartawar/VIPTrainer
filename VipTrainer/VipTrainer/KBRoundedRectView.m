//
//  RoundedRectView.m
//  Vendevor
//
//  Created by kyle barnes on 5/3/13.
//
//

#import "KBRoundedRectView.h"

@implementation KBRoundedRectView



@synthesize background_color;
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
        self.backgroundColor = [UIColor clearColor];
        self.backgroundAlpha = 1;
        self.color = white;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.backgroundAlpha = 1;
        self.color = white;
    }
    return self;
}

-(void)setColor:(Colors)color{
    self->color = color;
    [self setNeedsDisplay];
}

-(id)awakeAfterUsingCoder:(NSCoder *)aDecoder{
    self =[super awakeAfterUsingCoder:aDecoder];
    if(self){
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:10];
    //[VendevorWhite setFill];
    //[path fill];
    
    UIBezierPath *path;
    
    if(self.topLeftRounded && self.topRightRounded && self.bottomLeftRounded && self.bottomRightRounded)
        path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:1];
    
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

    switch(color){
        case green:
            
            [vipBrightGreen setFill];
            [path fill];
            
            break;
        case darkGray:
            [vipDarkGray setFill];
            [path fill];
            
            break;
        case white:
            [[UIColor whiteColor] setFill];
            [path fill];
            break;
    }
    

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
