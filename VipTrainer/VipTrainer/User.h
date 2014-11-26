//
//  User.h
//  VipTrainer
//
//  Created by kenney on 4/1/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <Parse/Parse.h>

@interface User : PFUser <PFSubclassing>

+(User *)currentUser;

@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSString *email;
@property (nonatomic) NSString *phone;
@property (nonatomic) NSString *birthday;
@property (nonatomic) NSString *gender;
@property (nonatomic) NSString *type;
@property (nonatomic) NSMutableArray *certifications;//Medical Conditions
@property (nonatomic) NSArray *interests;
@property (nonatomic) NSMutableArray *conditions;//Medical Conditions
@property (nonatomic) PFFile *profilePic;
@property (nonatomic) PFFile *profilePicThumb;
@property (nonatomic) NSString *age;
@property (nonatomic) PFFile *firstProgressPic;

@property (nonatomic) PFFile *latestProgressPic;


@property (nonatomic) NSNumber *completedProfile;

@property (nonatomic) NSNumber *rating;
@property (nonatomic) NSNumber *numberOfRatings;
@property (nonatomic) NSString *hourly_rate;
@property (nonatomic) NSString *paypal_email;





@property (nonatomic) NSMutableArray *progresses;//Medical Conditions



@end
