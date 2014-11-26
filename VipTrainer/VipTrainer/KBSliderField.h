//
//  KBSliderField.h
//  //
//  Created by kenney on 1/5/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//


//Not used at all. Legacy code. Dont worry about this class

#import <UIKit/UIKit.h>

@protocol KBSliderViewDelegate <NSObject>
-(void)KBSliderView:(id)sliderView didEndEditing:(UITextField *)textField;
-(void)KBSliderView:(id)sliderView didBeginEditing:(UITextField *)textField;
-(void)KBSliderView:(id)sliderView didReturn:(UITextField *)textField;
@end

@interface KBSliderField : UIView <UITextFieldDelegate>
@property (nonatomic, strong) IBOutlet UILabel *textLabel;
@property (nonatomic, strong) IBOutlet UITextField *textField;
@property (nonatomic, strong) IBOutlet UIButton *clearButton;
@property (nonatomic, strong) IBOutlet UIImageView *indicator;
@property (nonatomic, strong) IBOutlet UIView *bottomDivider;
@property (nonatomic, strong) IBOutlet UIView *topDivider;
@property (nonatomic, strong) IBOutlet UIView *verticalDivider;
@property (nonatomic, weak) id<KBSliderViewDelegate> delegate;
@property (nonatomic) BOOL isExpanded;

@end
