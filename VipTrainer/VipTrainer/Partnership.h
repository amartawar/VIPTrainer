//
//  Partnership.h
//  VipTrainer
//
//  Created by kenney on 4/16/14.
//  Copyright (c) 2014 Kyle. All rights reserved.

/*
        This is the bridge between a client and a trainer.
*/

//

#import <Parse/Parse.h>
#import "User.h"

typedef enum {
    CLIENT_CHOSE_TRAINER = 1,
    CLIENT_COMPLETED_INTERVIEW,
    TRAINER_ACCEPTED_CLIENT,
    TRAINER_CREATED_FITNESS_ASSESSMENT,
    CLIENT_COMPLETED_FITNESS_ASSESSMENT,
    TRAINER_CREATED_WORKOUT,
    CLIENT_FINISHED_WORKOUT,
    TRAINER_EVALUATED_WORKOUT,
    TRAINER_DENIED_CLIENT,
    CLIENT_NEEDS_PRODUCTS
    
} Status;

@interface Partnership : PFObject <PFSubclassing>
+(NSString *)parseClassName;

@property (nonatomic) User *trainer;
@property (nonatomic) User *client;

@property (nonatomic) NSString *questionnaire;
@property (nonatomic) NSMutableArray  *recommendedProducts;

@property (nonatomic) NSInteger *trainer_accepted;
@property (nonatomic) NSInteger *client_accepted;

@property (nonatomic) NSNumber *awaitingMealPlan;
@property (nonatomic) NSNumber *awaitingNutrition;
@property (nonatomic) NSNumber *awaitingFitnessAssessment;

@property (nonatomic) int status;
@property (nonatomic) NSString *lastMessage;

@end
