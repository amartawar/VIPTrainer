//
//  Chat.h
//  VipTrainer
//
//  Created by kenney on 4/17/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <Parse/Parse.h>
#import "Partnership.h"

@interface Rating : PFObject <PFSubclassing>
+(NSString *)parseClassName;
@property (nonatomic) User *client;
@property (nonatomic) NSNumber *rating;
@property (nonatomic) NSString *comments;
@property (nonatomic) NSString *trainer_id;


@end

