//
//  KBCircleImageView.m
//  Peach
//
//  Created by kenney on 1/9/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBCircleImageView.h"

@implementation KBCircleImageView{
    CAShapeLayer *circleLayer;
    UIBezierPath *path;
}
@synthesize file = _file;
@synthesize imageView;
@synthesize showRing = _showRing;
@synthesize ringColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib{
    
    self.roundness = 0.001f;
    
    
    self.imageView = [[PFImageView alloc] initWithFrame:self.frame];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.imageView setBackgroundColor:[UIColor clearColor]];
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.layer addSublayer:self.imageView.layer];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    circleLayer = [CAShapeLayer layer];
    
    // maskLayer.anchorPoint = CGPointMake(.5, .5);
    float width = self.ringWidth? self.ringWidth : 5.0;
    
    circleLayer.lineWidth = width;
    circleLayer.fillColor = [[UIColor clearColor] CGColor];
    
    DebugLog(@"color:%@",self.ringColor);
    
    circleLayer.strokeColor = self.ringColor? [self.ringColor CGColor] : [[UIColor blackColor] CGColor];
    
    CGPoint circleCenter = CGPointMake(self.frame.size.width/2,self.frame.size.height/2);
    float circleRadius = self.frame.size.width/2;
    
    if(self.roundness){
        path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0,0,self.frame.size.width, self.frame.size.height)
                                          cornerRadius:self.roundness];
    }
    else{
        path = [UIBezierPath bezierPath];
        [path addArcWithCenter:circleCenter
                        radius:circleRadius
                    startAngle:0.0
                      endAngle:M_PI * 2.0
                     clockwise:YES];
    }
    
    circleLayer.path = [path CGPath];
    maskLayer.path = [path CGPath];
    
    self.layer.mask = maskLayer;
    
    if(self.showRing)
        [self.layer addSublayer:circleLayer];
}



-(BOOL)showRing{
    return _showRing;
}

-(void)setShowRing:(BOOL)showRing{
    
    
    if(_showRing && !showRing)
        [circleLayer removeFromSuperlayer];
    else if(!_showRing && showRing)
        [self.layer addSublayer:circleLayer];
    _showRing = showRing;
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if(self){
        
    }
    return self;
}

/*-(void)setRingColor:(UIColor *)color{
    DebugLog(@"called");
    circleLayer.strokeColor = [color CGColor];
}*/

-(void)setImage:(UIImage *)image{
    self.imageView.image = image;
}

-(UIImage *)image{
    return self.imageView.image;
}


-(void)setFile:(PFFile *)file{
    _file = file;
    self.imageView.file = _file;
    [self.imageView loadInBackground];

}

- (void)loadInBackground{
    
    [self.imageView loadInBackground];
    //[self.imageView loadInBackground:^(UIImage *image, NSError *errlr){
        //[self.imageView setImage:[UIImage imageNamed:@"app2_120.png"]];
    //}];
}



@end
