//
//  Condition.h
//  VipTrainer
//
//  Created by kenney on 4/6/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//
//   Medical Conditions

#import <Parse/Parse.h>

@interface Condition : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *affected;
@property (nonatomic) NSString *comment;

@end
