//
//  NSString+Helper.m
//  PromptuApp
//
//  Created by Brandon Millman on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSString+Helper.h"

@implementation NSString (Helper)

- (NSString*)substringFrom:(NSInteger)a to:(NSInteger)b {
	NSRange r;
	r.location = a;
	r.length = b - a;
	return [self substringWithRange:r];
}

- (NSInteger)indexOf:(NSString*)substring from:(NSInteger)starts {
	NSRange r;
	r.location = starts;
	r.length = [self length] - r.location;

	NSRange index = [self rangeOfString:substring options:NSLiteralSearch range:r];
	if (index.location == NSNotFound) {
		return -1;
	}
	return index.location + index.length;
}

- (NSString*)trim {
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)startsWith:(NSString*)s {
	if([self length] < [s length]) return NO;
	return [s isEqualToString:[self substringFrom:0 to:[s length]]];
}

- (BOOL)containsString:(NSString *)aString
{
	NSRange range = [[self lowercaseString] rangeOfString:[aString lowercaseString]];
	return range.location != NSNotFound;
}

@end
