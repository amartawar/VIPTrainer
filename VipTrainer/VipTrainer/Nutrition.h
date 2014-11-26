//
//  Nutrition.h
//  VipTrainer
//
//  Created by kenney on 6/27/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <Parse/Parse.h>

@interface Nutrition : PFObject <PFSubclassing>

+(NSString *)parseClassName;

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *description;
@property (nonatomic) NSString *url;
@property (nonatomic) NSString *size;
@property (nonatomic) NSNumber *price;
@property (nonatomic) PFFile *picture;


@end
