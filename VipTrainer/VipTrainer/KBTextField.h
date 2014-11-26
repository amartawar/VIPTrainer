//
//  KBTextField.h
//  Peach
//
//  Created by kenney on 1/20/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//


// Custom textfield for form validation. This only partially works, as it is not finished. Probably shouldnt use

#import <UIKit/UIKit.h>

typedef enum {
    KBTextFieldTypeNotEmpty, // 0
    KBTextFieldTypePhone, // 1
    KBTextFieldTypeName, // 2
    KBTextFieldTypeState, // 3
    KBTextFieldTypeEmail, // 4
    KBTextFieldTypePrice,  // 5
    KBTextFieldTypeDecimalNumber // 6
} KBTextFieldType;

@interface KBTextField : UITextField <UITextFieldDelegate>
@property (nonatomic, weak) id<UITextFieldDelegate> KBDelegate;
@property (nonatomic) BOOL incorrect;
@property (nonatomic) BOOL required;
@property (nonatomic) int fieldType;

-(BOOL)validate;

@end
