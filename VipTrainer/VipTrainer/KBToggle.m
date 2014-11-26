//
//  KBToggle.m
//  Peach
//
//  Created by kenney on 1/5/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBToggle.h"


@implementation KBToggle{
    UIImageView *imageView;
}
@synthesize on = _on;
@synthesize delegate;

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [imageView setContentMode:UIViewContentModeScaleToFill];
        [self addSubview:imageView];
        self.adjustsImageWhenHighlighted=YES;
        [self addTarget:self action:@selector(toggleOnAndNotifyDelegate) forControlEvents:UIControlEventTouchUpInside];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)awakeFromNib{
    if([self imageForState:UIControlStateNormal]){
        self.offImage = [self imageForState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
    }
    else{
        self.offImage = [UIImage imageNamed:@"checkbox.png"];
    }
    if([self imageForState:UIControlStateHighlighted]){
        self.onImage = [self imageForState:UIControlStateHighlighted];
        [self setImage:nil forState:UIControlStateHighlighted];
    }
    else{
        self.onImage = [UIImage imageNamed:@"checkbox_checked.png"];
    }
    if(_on)
        [imageView setImage:self.onImage];
    else
        [imageView setImage:self.offImage];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
                [imageView setContentMode:UIViewContentModeScaleToFill];
        [self addSubview:imageView];
        self.adjustsImageWhenHighlighted=YES;
        [self addTarget:self action:@selector(toggleOnAndNotifyDelegate) forControlEvents:UIControlEventTouchUpInside];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)toggleOn{
    [self setOn:!_on];
}

-(void)toggleOnAndNotifyDelegate{
    [self setOnOnAndNotifyDelegate:!_on];
}

-(void)setOn:(BOOL)on{

    if(on){
            [imageView setImage:self.onImage];
    }
    else{
            [imageView setImage:self.offImage];
    }

    _on = on;
    
}

-(void)setOnOnAndNotifyDelegate:(BOOL)on{
    
    if(on){
        [imageView setImage:self.onImage];
    }
    else{
        [imageView setImage:self.offImage];
    }
    
    _on = on;
    
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(KBToggle:valueChanged:)])
        [self.delegate KBToggle:self valueChanged:_on];
    
}


-(BOOL)isOn{
    
    return _on;
}

-(void)layoutSubviews{
    imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [super layoutSubviews];
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
