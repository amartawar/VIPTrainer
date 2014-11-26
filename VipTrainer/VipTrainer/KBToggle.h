//
//  KBToggle.h
//  
//
//  Created by kenney on 1/5/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//


/*

 
    A really clean toggle button. use On or setOn instead of selected.
 
 */
#import <UIKit/UIKit.h>

@protocol KBToggleDelegate <NSObject>
-(void)KBToggle:(id)toggle valueChanged:(BOOL)value;
@end


@interface KBToggle : UIButton
@property (nonatomic) BOOL on;
@property (nonatomic, strong) UIImage *onImage;
@property (nonatomic, strong) UIImage *offImage;
@property (nonatomic, weak) id<KBToggleDelegate> delegate;
@end
