//
//  Commons.h
//  VipTrainer
//
//  Created by kenney on 3/18/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#ifndef VipTrainer_Commons_h
#define VipTrainer_Commons_h

#define SESSIONS_PER_HOUR 6;

//Used instead of NSLog, so I can quickly turn logging on/off. comment out one or the other
#define DebugLog(...) NSLog(__VA_ARGS__)
//#define DebugLog(...) //

//VipTrainer Color schemes
#define vipBrightGreen [UIColor colorWithRed:90.0/255.0 green:204.0/255.0 blue:76.0/255.0	 alpha:1]
#define vipLightGreen [UIColor colorWithRed:181.0/255.0 green:255.0/255.0 blue:171.0/255.0	 alpha:1]

#define vipGray [UIColor colorWithRed:230.0/255.0 green:239.0/255.0 blue:236.0/255.0	 alpha:1]

#define vipHighlightGreen [UIColor colorWithRed:156.0/255.0 green:224.0/255.0 blue:158.0/255.0	 alpha:1]
#define vipHighlightYellow  [UIColor colorWithRed:247.0/255.0 green:224.0/255.0 blue:160.0/255.0	 alpha:1]
#define vipHighlightRed [UIColor colorWithRed:237.0/255.0 green:153.0/255.0 blue:153.0/255.0	 alpha:1]


#define vipDarkGray [UIColor colorWithRed:48.0/255.0 green:48.0/255.0 blue:48.0/255.0	 alpha:1]
#define vipLightGray [UIColor colorWithRed:119.0/255.0 green:119.0/255.0 blue:119.0/255.0	 alpha:1]

//Quick Access for the Static Classes
#define APPDELEGATE ((KBAppDelegate *)[[UIApplication sharedApplication] delegate])
#define DATA ((KBData *)[KBData sharedInstance])
#define CURRENTUSER ([User currentUser])

#define USER_IS_BUYER YES

#define NEW_CLIENT_REQUEST_NOTIFICATION @"trainer_request"
#define TRAINER_ACCEPTED_NOTIFICATION @"trainer_accepted"
#define CREATED_WORKOUT_NOTIFICATION @"workout_created"
#define COMPLETED_WORKOUT_NOTIFICATION @"workout_completed"
#define COMPLETED_ASSESSMENT_NOTIFICATION @"assessment_completed"
#define CHAT_NOTIFICATION @"chat"
#define PRODUCT_RECOMMENDED_NOTIFICATION @"product_recommended"
#define MEAL_PLAN_NOTIFICATION @"mealplan"


//So I dont have to type this out anytime I want to check whether a user is client or trainer
#define IS_CLIENT [DATA.user.type isEqualToString:@"client"]
#define IS_TRAINER [DATA.user.type isEqualToString:@"trainer"]

//Has a 4" screen vs a 3.5" screen
#define HAS_RETINA [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568.0

#endif
