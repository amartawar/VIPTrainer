//
//  NSString+Helper.h
//  PromptuApp
//
//  Created by Brandon Millman on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//



// Some helper functions for common string tasks

#import <Foundation/Foundation.h>

@interface NSString (Helper)

- (NSString*)substringFrom:(NSInteger)a to:(NSInteger)b;

- (NSInteger)indexOf:(NSString*)substring from:(NSInteger)starts;

- (NSString*)trim;

- (BOOL)startsWith:(NSString*)s;

- (BOOL)containsString:(NSString*)aString;

@end