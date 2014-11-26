//
//  KBViewController.m
//  VipTrainer
//
//  Created by kenney on 4/3/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBViewController.h"

@interface KBViewController ()

@end

@implementation KBViewController{
    float upHeight;
    float downHeight;
}

@synthesize shouldRefresh;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self.view setBackgroundColor:[UIColor clearColor]];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    
    tapGesture.delegate = self;
    tapGesture.cancelsTouchesInView = NO;
    [self.scrollView addGestureRecognizer:tapGesture];
    
    
    if (self.navigationController && [self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        
        
        /*if(self.navigationController.viewControllers.count == 1){
            
            UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(menu)];
            [menuButton setTintColor:vipBrightGreen];
            self.navigationItem.leftBarButtonItem = menuButton;
        }*/


    }
    
}

-(void)menu{
       [[NSNotificationCenter defaultCenter] postNotificationName:@"openMenu" object:nil];
}

-(void)hideKeyboard
{
    [self.view endEditing:YES];
}

-(void)addDefaultBackground{

}

-(void)KBSliderView:(id)sliderView didEndEditing:(UITextField *)textField{
    
    [self animateTextField: textField up: NO];
}
-(void)KBSliderView:(id)sliderView didBeginEditing:(UITextField *)textField{
    
    [self animateTextField: textField up: YES];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void)textViewDidBeginEditing:(UITextView *)textField
{
    [self animateTextView: textField up: YES];
}


- (void)textViewDidEndEditing:(UITextView *)textField
{
    [self animateTextView: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    
    
    if(up){
        
        self.contentToBottom.constant =  upHeight;
        
        
        if(self.scrollUsingTable){

            [self.table layoutIfNeeded];
            CGPoint newPoint = [textField.superview convertPoint:textField.frame.origin toView:self.table];
            
            [UIView animateWithDuration:.3 animations:^{
                [self.table setContentOffset:CGPointMake(0, newPoint.y - upHeight)];
            }completion:^(BOOL finished){
                
            }];
            
            
        }
        else{
            [self.scrollView layoutIfNeeded];
            CGPoint newPoint = [textField.superview convertPoint:textField.frame.origin toView:self.scrollView];
            
            
            
            [UIView animateWithDuration:.3 animations:^{
                [self.scrollView setContentOffset:CGPointMake(0, newPoint.y - upHeight + 100)];
            }completion:^(BOOL finished){
                
            }];
        }
        
        

    }
    
    else{
        self.contentToBottom.constant = downHeight;
        
        if(self.scrollUsingTable)
           [self.table layoutIfNeeded];
        else
            [self.scrollView layoutIfNeeded];
    }
    
    
}

- (void) animateTextView: (UITextView*) textView up: (BOOL) up
{
    
    
    if(up){
        
        
        if(self.scrollUsingTable){
            self.contentToBottom.constant =  upHeight;
            [self.table layoutIfNeeded];
            CGPoint newPoint = [textView.superview convertPoint:textView.frame.origin toView:self.table];
            
            
            
            [UIView animateWithDuration:.3 animations:^{
                [self.table setContentOffset:CGPointMake(0, newPoint.y - upHeight)];
            }completion:^(BOOL finished){
                
            }];
        }
        else{
            self.contentToBottom.constant =  upHeight;
            [self.scrollView layoutIfNeeded];
            CGPoint newPoint = [textView.superview convertPoint:textView.frame.origin toView:self.scrollView];
            
            
            
            [UIView animateWithDuration:.3 animations:^{
                [self.scrollView setContentOffset:CGPointMake(0, newPoint.y - upHeight)];
            }completion:^(BOOL finished){
                
            }];
        }
        

    }
    
    else{
        self.contentToBottom.constant = downHeight;
        
        if(self.scrollUsingTable)
            [self.table layoutIfNeeded];
        else
            [self.scrollView layoutIfNeeded];
    }
    
    
}



-(void)viewWillAppear:(BOOL)animated{
    
    downHeight = self.contentToBottom.constant;
    upHeight = downHeight + 116;
}

-(BOOL)save{return NO;}

-(void)showMessage:(NSString *)message{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.yOffset = 150.f;
    hud.labelFont = [UIFont fontWithName:@"Dosis-Medium" size:12];
    hud.userInteractionEnabled = NO;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}


-(void)showProgress:(NSString *)message{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.yOffset = 150.f;
    hud.labelFont = [UIFont fontWithName:@"Dosis-Medium" size:12];
    hud.removeFromSuperViewOnHide = YES;
}

-(void)hideProgress{
    [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow  animated:YES];
}


@end
