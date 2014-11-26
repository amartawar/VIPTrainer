//
//  NSArray+JSON.h
//  VipTrainer
//
//  Created by kenney on 4/6/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <Foundation/Foundation.h>

// A helper class catagory for converting an Array to JSON string

@interface NSArray (JSON)
- (NSString *)jsonStringWithPrettyPrint:(BOOL)prettyPrint;
@end
