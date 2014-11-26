//
//  KBTextField.m
//  Peach
//
//  Created by kenney on 1/20/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBTextField.h"

@implementation KBTextField
@synthesize KBDelegate = _KBDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.fieldType = KBTextFieldTypeNotEmpty;
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    if(self.delegate){
        self.KBDelegate = self.delegate;
        self.delegate = self;
        self.autocorrectionType = UITextAutocorrectionTypeNo;
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(self.KBDelegate && [self.KBDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)])
        [self.KBDelegate textFieldDidBeginEditing:textField];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if(self.fieldType == KBTextFieldTypePrice){
        NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
        [fmt setNumberStyle:NSNumberFormatterCurrencyStyle]; // to get commas (or locale equivalent)
        [fmt setMaximumFractionDigits:2]; // to avoid any decimal
        
        textField.text = [fmt stringFromNumber:@([textField.text floatValue])];
    }
    

    
    if(self.KBDelegate && [self.KBDelegate respondsToSelector:@selector(textFieldDidEndEditing:)])
        [self.KBDelegate textFieldDidEndEditing:textField];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(self.fieldType == KBTextFieldTypePrice){
        textField.text = [[textField.text componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet]] componentsJoinedByString:@""];
    }
    
    DebugLog(@"kbtextfield did begin");
    
    if(self.KBDelegate && [self.KBDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)])
        return [self.KBDelegate textFieldShouldBeginEditing:textField];
    else
        return YES;
    
    
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
        if(self.KBDelegate && [self.KBDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)])
            return [self.KBDelegate textFieldShouldEndEditing:textField];
        else
            return YES;
}
-(BOOL)textFieldShouldClear:(UITextField *)textField{
    if(self.KBDelegate && [self.KBDelegate respondsToSelector:@selector(textFieldShouldClear:)])
        return [self.KBDelegate textFieldShouldClear:textField];
    else
        return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(self.KBDelegate && [self.KBDelegate respondsToSelector:@selector(textFieldShouldReturn:)])
        return [self.KBDelegate textFieldShouldReturn:textField];
    else
        return YES;
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    DebugLog(@"delegate:%@", [self.delegate class]);
    DebugLog(@"KBDelegate:%@", [self.KBDelegate class]);
    DebugLog(@"fieldType:%i", self.fieldType);
    if(self.fieldType == KBTextFieldTypePhone){
            DebugLog(@"shouldChange phone");
            // All digits entered
            if (range.location == 12) {
                return NO;
            }
            
            // Reject appending non-digit characters
            if (range.length == 0 &&
                ![[NSCharacterSet decimalDigitCharacterSet] characterIsMember:[string characterAtIndex:0]]) {
                return NO;
            }
            
            // Auto-add hyphen before appending 4rd or 7th digit
            if (range.length == 0 &&
                (range.location == 3 || range.location == 7)) {
                textField.text = [NSString stringWithFormat:@"%@-%@", textField.text, string];
                return NO;
            }
            
            // Delete hyphen when deleting its trailing digit
            if (range.length == 1 &&
                (range.location == 4 || range.location == 8))  {
                range.location--;
                range.length = 2;
                textField.text = [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }
    else if(self.fieldType == KBTextFieldTypePrice){
        DebugLog(@"shouldChange price");
        //NSString *pattern = @"[0-9]*[.][0-9][0-9]";
        //NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:nil error:nil];
        //regex
        
        //float dollars = [DATA.selectedItem.wholesalePrice floatValue];
       // NSString *someString = [NSString stringWithFormat:@"$%.2lf", dollars];
        
        //[[self.wholesalePrice_field.text componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet]] componentsJoinedByString:@""];
        
        
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        NSString *expression = @"^([0-9]+)?(\\.([0-9]{1,2})?)?$";
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:nil];
        NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString
                                                            options:0
                                                              range:NSMakeRange(0, [newString length])];
        
        if (numberOfMatches == 0){
            DebugLog(@"does not match");
            return NO;
        }
    }
    else if(self.fieldType == KBTextFieldTypeDecimalNumber){
         DebugLog(@"shouldChange decimal");
        return [string isEqualToString:@""] ||
        ([string stringByTrimmingCharactersInSet:
          [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet]].length > 0);
    }
    
    
    DebugLog(@"should replace none");
    
    if(self.KBDelegate)
        DebugLog(@"KBDelegate not nil");
    else
        DebugLog(@"KBDelegate NIL");
    
    if([self.KBDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)])
        DebugLog(@"KBDelegate responds");
    else
        DebugLog(@"KBDelegate does NOT respond");
    
    if(self.KBDelegate && [self.KBDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]){
        DebugLog(@"returning delegat abswer");
        return [self.KBDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    else{
        DebugLog(@"returning yes");
        return YES;
    }
    
}

-(BOOL)validate{
     DebugLog(@"validate");
    switch(self.fieldType){
        case KBTextFieldTypeNotEmpty:{
            
            if(self.text.length > 0)
                return YES;
            else
                return NO;
        }
        case KBTextFieldTypeEmail:{
            
            if(self.text.length > 0)
                return [self NSStringIsValidEmail:self.text];
            else
                return NO;
        }

        break;
        case KBTextFieldTypeName:{
            if(self.text.length > 0)
                return [self NSStringIsValidName:self.text];
            else
                return NO;
        }
        break;
        case KBTextFieldTypePhone:{
            
            NSString *phonestring = [self.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
            if(phonestring.length == 10)
                return YES;
            else
                return NO;
        }
        break;
        case KBTextFieldTypeState:{
            if(self.text.length > 0)
                return YES;
            else
                return NO;
        }
        case KBTextFieldTypePrice:{
            
            if(self.text.length > 0)
                return [self NSStringIsValidPrice:self.text];
            else
                return NO;
        }
        break;
        
    }
    return TRUE;
}

-(BOOL)NSStringIsValidPrice:(NSString *)checkString{
    NSString *expression = @"^([0-9]+)?(\\.([0-9]{1,2})?)?$";
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:checkString
                                                        options:0
                                                          range:NSMakeRange(0, [checkString length])];
    if (numberOfMatches == 0)
        return NO;
    else
        return YES;
}

-(BOOL) NSStringIsValidName:(NSString *)checkString{
   // NSString *phoneRegex = @"#([\s\-_]|^)([a-z0-9-_]+)#i"
    
    
    return TRUE;
}

-(BOOL) NSStringIsValidPhone:(NSString *)checkString{
    NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
    NSPredicate *predicate  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [predicate evaluateWithObject:checkString];
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}


@end
