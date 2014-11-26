//
//  Assessment.h
//  VipTrainer
//
//  Created by kenney on 5/21/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <Parse/Parse.h>

@interface Assessment : PFObject <PFSubclassing>
+(NSString *)parseClassName;
@property (nonatomic) Partnership *partnership;
@property (nonatomic) NSString *workout_id;
@property (nonatomic) NSString *workout_index;
@property (nonatomic) NSString *assessment;
@end
