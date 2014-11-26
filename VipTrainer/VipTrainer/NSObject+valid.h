//
//  NSObject+valid.h
//  
//
//  Created by kenney on 1/29/14.
//
//

//Helper Category so we can quickly tell whether or not a returned object is a valid, non-null, non-emptry string


#import <Foundation/Foundation.h>

@interface NSObject (valid)
-(BOOL)isValidString;
-(BOOL)isValidNonEmptyString;
@end
