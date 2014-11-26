//
//  NSObject+valid.m
//  
//
//  Created by kenney on 1/29/14.
//
//

#import "NSObject+valid.h"

@implementation NSObject (valid)
-(BOOL)isValidString{
    if(self && [self isKindOfClass:[NSString class]]){
        return YES;
    }
    return NO;
}

-(BOOL)isValidNonEmptyString{
    if(self && [self isKindOfClass:[NSString class]] && [(NSString *)self length] > 0){
        return YES;
    }
    return NO;
}
@end
