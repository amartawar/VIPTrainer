//
//  Progress.h
//  VipTrainer
//
//  Created by kenney on 7/20/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <Parse/Parse.h>

@interface Progress : PFObject <PFSubclassing>
+(NSString *)parseClassName;

@property (nonatomic) NSString *neck;
@property (nonatomic) NSString *shoulders;
@property (nonatomic) NSString *chest;
@property (nonatomic) NSString *biceps;
@property (nonatomic) NSString *forearms;
@property (nonatomic) NSString *waist;
@property (nonatomic) NSString *thighs;
@property (nonatomic) NSString *calves;
@property (nonatomic) NSString *bodyFat;
@property (nonatomic) NSString *weight;
@property (nonatomic) PFFile *image;
@property (nonatomic) User *user;
@end
