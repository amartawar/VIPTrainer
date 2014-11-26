//
//  Chat.h
//  VipTrainer
//
//  Created by kenney on 4/17/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <Parse/Parse.h>
#import "Partnership.h"

@interface Chat : PFObject <PFSubclassing>
+(NSString *)parseClassName;
@property (nonatomic) Partnership *partnership;
@property (nonatomic) User *sender;
@property (nonatomic) User *recipient;
@property (nonatomic) NSString *message;



@end

