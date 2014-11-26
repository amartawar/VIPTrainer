//
//  NSDictionary+JSON.h
//  VipTrainer
//
//  Created by kenney on 4/6/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <Foundation/Foundation.h>

// A helper class catagory for converting an NSDictionary to JSON string

@interface NSDictionary (JSON)
-(NSString*) jsonStringWithPrettyPrint:(BOOL) prettyPrint;
@end
