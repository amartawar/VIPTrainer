//
//  KBWorkoutNavigation.h
//  VipTrainer
//
//  Created by kenney on 6/29/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBWorkoutPage.h"

@interface KBWorkoutNavigation : UINavigationController

-(NSString*)getNextExercise;
-(NSString*)getExerciseAtIndex:(int)index;
-(void)goToExercisePageForIndex:(int)index;

@property (nonatomic) int currentExerciseIndex;

@end
