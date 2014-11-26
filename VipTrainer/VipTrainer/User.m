//
//  User.m
//  VipTrainer
//
//  Created by kenney on 4/1/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "User.h"

@implementation User


@dynamic firstName;
@dynamic lastName;
@dynamic email;
@dynamic phone;
@dynamic birthday;
@dynamic gender;
@dynamic type;
@dynamic interests;
@dynamic conditions;
@dynamic profilePic;
@dynamic profilePicThumb;
@dynamic completedProfile;
@dynamic hourly_rate;
@dynamic paypal_email;
@dynamic firstProgressPic;
@dynamic latestProgressPic;
@dynamic progresses;
@dynamic numberOfRatings;
@dynamic age;
@dynamic certifications;

-(id)init{
    self = [super init];
    if(self){
    }
    return self;
    
}

+ (User *)currentUser{
    return (User *)[PFUser currentUser];
}

@end
