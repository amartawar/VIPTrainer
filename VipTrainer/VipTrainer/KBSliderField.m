//
//  KBSliderField.m
//  Peach
//
//  Created by kenney on 1/5/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//


//Turn back now. You dont need to use this. I will delete when I know it is safe!

#import "KBSliderField.h"

@implementation KBSliderField{
    NSArray *expandedConstraints;
    NSArray *collapsedConstraints;
    UITapGestureRecognizer *tapRecognizer;
    BOOL isChanging;
}
@synthesize textLabel;
@synthesize textField;
@synthesize clearButton;
@synthesize indicator;
@synthesize isExpanded = _isExpanded;
@synthesize delegate;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

-(void)initialize{
    
    self.textLabel = [[self subviews] objectAtIndex:0];
    self.textField = [self.subviews objectAtIndex:1];
    
    self.verticalDivider = [[UIView alloc] initWithFrame:CGRectMake(self.textLabel.frame.size.width + self.textLabel.frame.origin.x, 0, 1, self.frame.size.height)];
    [self.verticalDivider setBackgroundColor:[UIColor whiteColor]];
    [self.verticalDivider setHidden:YES];
    [self addSubview:self.verticalDivider];
    
    self.clearButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [self.clearButton setImage:[UIImage imageNamed:@"close_white.png"] forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(clearText) forControlEvents:UIControlEventTouchUpInside];
    [clearButton setHidden:YES];
    [self addSubview:self.clearButton];
    
    self.textField.delegate = self;
    
    isChanging = NO;
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped)];
    [self addGestureRecognizer:tapRecognizer];
    
    UIView *divider = self.verticalDivider;
    UILabel *label = self.textField;
    UITextField *field = self.textField;
    UIButton *clear = self.clearButton;
    
    [self.textField setValue:vipBrightGreen
                  forKeyPath:@"_placeholderLabel.textColor"];
    
    
    //expandedConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[label]-[divider(==1)]-[clear]-[field]-[indicator]-|" options:0 metrics:nil
                                                                   // views:NSDictionaryOfVariableBindings(label, divider, clear, field, indicator)];
    
    //collapsedConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[label]-[field]-[indicator]-|" options:0 metrics:nil
                                                                  //  views:NSDictionaryOfVariableBindings(label, field, indicator)];
}

//-(void)KBSliderView:(id)sliderView didEndEditing:(UITextField *)textField;
//-(void)KBSliderView:(id)sliderView didBeginEditing:(UITextField *)textField;
//-(void)KBSliderView:(id)sliderView didReturn:(UITextField *)textField;

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(self.delegate && [self.delegate respondsToSelector:@selector(KBSliderView:didEndEditing:)])
       [self.delegate KBSliderView:self didEndEditing:self.textField];
    [self setIsExpanded:NO];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(KBSliderView:didBeginEditing:)])
        [self.delegate KBSliderView:self didBeginEditing:self.textField];
    
    if(!_isExpanded)
       [self setIsExpanded:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(self.delegate && [self.delegate respondsToSelector:@selector(KBSliderView:didReturn:)])
        [self.delegate KBSliderView:self didReturn:self.textField];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
        [self setIsExpanded:NO];
    return YES;
}

-(void)tapped{
    [self setIsExpanded:!_isExpanded];
}

-(void)clearText{
    self.textField.text = @"";
}

-(BOOL)isExpanded{
    return _isExpanded;
}
-(void)setIsExpanded:(BOOL)isExpanded{
    _isExpanded = isExpanded;
    
    if(isChanging)
        return;
    
    if(isExpanded){
        isChanging = YES;
        self.verticalDivider.alpha = 0;
        self.clearButton.alpha = 0;
        self.verticalDivider.hidden = NO;
        self.clearButton.hidden = NO;
        
        self.verticalDivider.frame= CGRectMake(self.frame.size.width, 0, 1, self.frame.size.height);
        self.clearButton.frame= CGRectMake(self.verticalDivider.frame.origin.x + 8, (self.frame.size.height/2)-(self.clearButton.frame.size.height/2), self.clearButton.frame.size.width, self.clearButton.frame.size.height);
        
        [UIView animateWithDuration:.1 animations:^{
            [self setBackgroundColor:vipBrightGreen];
            [self.textField setAlpha:0];
            [self.indicator setAlpha:0];
        }completion:^(BOOL inished){
            [self.textField setValue:[UIColor whiteColor]
                          forKeyPath:@"_placeholderLabel.textColor"];
            [self.textField setTintColor:[UIColor whiteColor]];
        }];
        
        [UIView animateWithDuration:.1 delay:.1 options:nil animations:^{
            self.verticalDivider.frame= CGRectMake(self.textLabel.frame.size.width + self.textLabel.frame.origin.x, 0, 1, self.frame.size.height);
            self.clearButton.frame= CGRectMake(self.textLabel.frame.size.width + self.textLabel.frame.origin.x + 8, (self.frame.size.height/2)-(self.clearButton.frame.size.height/2), self.clearButton.frame.size.width, self.clearButton.frame.size.height);
            self.verticalDivider.alpha = 1;
            self.clearButton.alpha = 1;
            [self.textField setAlpha:1];
            [self.indicator setAlpha:1];
            self.textLabel.textColor = [UIColor whiteColor];
            self.textField.textColor = [UIColor whiteColor];
            
        }completion:^(BOOL inished){
            [self.indicator setImage:[UIImage imageNamed:@"check_white.png"]];
            [self.textField becomeFirstResponder];
            isChanging = NO;
        }];
        
    }
    else{
        isChanging = YES;
        [UIView animateWithDuration:.1 animations:^{

            self.verticalDivider.frame= CGRectMake(self.frame.size.width, 0, 1, self.frame.size.height);
            self.clearButton.frame= CGRectMake(self.verticalDivider.frame.origin.x + 8, (self.frame.size.height/2)-(self.clearButton.frame.size.height/2), self.clearButton.frame.size.width, self.clearButton.frame.size.height);
            self.verticalDivider.alpha = 0;
            self.clearButton.alpha = 0;
            self.textLabel.textColor = [UIColor darkGrayColor];
            self.textField.textColor = vipBrightGreen;
            [self.textField setAlpha:0];
            [self.indicator setAlpha:0];
            
        }completion:^(BOOL inished){
            [self.textField setValue:vipBrightGreen
                          forKeyPath:@"_placeholderLabel.textColor"];
            [self.textField setTintColor:vipBrightGreen];
            [self.indicator setImage:[UIImage imageNamed:@"edit_pencil.png"]];
            self.verticalDivider.hidden = YES;
            self.clearButton.hidden = YES;
        }];
        
        [UIView animateWithDuration:.1 delay:.1 options:nil animations:^{
            [self setBackgroundColor:[UIColor whiteColor]];
            [self.textField setAlpha:1];
            [self.indicator setAlpha:1];
            
        }completion:^(BOOL inished){
            [self.textField resignFirstResponder];
            isChanging = NO;
        }];
    }
    

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
