//
//  Partnership.m
//  VipTrainer
//
//  Created by kenney on 4/16/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "Partnership.h"

@implementation Partnership

@dynamic trainer;
@dynamic client;
@dynamic questionnaire;
@dynamic status;
@dynamic recommendedProducts;
@dynamic trainer_accepted;
@dynamic client_accepted;
@dynamic awaitingFitnessAssessment;
@dynamic awaitingMealPlan;
@dynamic awaitingNutrition;

@dynamic lastMessage;

+(NSString *)parseClassName{
    return @"Partnership";
}



@end
