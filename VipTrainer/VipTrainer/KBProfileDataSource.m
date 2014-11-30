//
//  KBProfileDataSource.m
//  VipTrainer
//
//  Created by AmitSanvedi on 29/11/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import "KBProfileDataSource.h"

#define MENU_TRAININGSPORTS 1
#define DATA_TRAININGSPORTS_TEAMS 2
#define DATA_TRAININGSPORTS_INDIVIDUAL 3
#define DATA_TRAININGSPORTS_FITNESS 4
#define DATA_TRAININGSPORTS_STRENGTH 5
#define MENU_SPECIALITY 6
#define DATA_SPECIALITY_WEIGHTLOSS 7
#define DATA_SPECIALITY_STRENGTH 8
#define DATA_SPECIALITY_SPORTS 9
#define DATA_SPECIALITY_GENDER 10
#define DATA_SPECIALITY_PHYSICAL 11
#define DATA_SPECIALITY_WELLNESS 12
#define DATA_PROFESSIONAL_EXPERIENCE 13


@implementation KBProfileDataSource
+ (KBProfileDataSource *)sharedDataSource{
    static KBProfileDataSource *dataSource = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataSource = [[self alloc] init];
    });
    return dataSource;
}
// Public methods
- (id)init {
    if (self = [super init]) {
    }
    return self;
}

-(NSMutableArray *)getProfileMenu:(int)menuType{
    NSMutableArray *arrMenu=[NSMutableArray array];
    if(menuType==MENU_TRAININGSPORTS){
        [arrMenu addObject:[NSDictionary dictionaryWithObjects:@[@"1",@"Team Sports"] forKeys:@[@"id",@"val"]]];
        [arrMenu addObject:[NSDictionary dictionaryWithObjects:@[@"2",@"Individual Sports/Activities"] forKeys:@[@"id",@"val"]]];
        [arrMenu addObject:[NSDictionary dictionaryWithObjects:@[@"3",@"Fitness & Dance"] forKeys:@[@"id",@"val"]]];
        [arrMenu addObject:[NSDictionary dictionaryWithObjects:@[@"4",@"Strength & Conditioning"] forKeys:@[@"id",@"val"]]];
    }else if(menuType==MENU_SPECIALITY){
        [arrMenu addObject:[NSDictionary dictionaryWithObjects:@[@"1",@"Weight Loss/Management"] forKeys:@[@"id",@"val"]]];
        [arrMenu addObject:[NSDictionary dictionaryWithObjects:@[@"2",@"Strength Training"] forKeys:@[@"id",@"val"]]];
        [arrMenu addObject:[NSDictionary dictionaryWithObjects:@[@"3",@"Sports Conditioning"] forKeys:@[@"id",@"val"]]];
        [arrMenu addObject:[NSDictionary dictionaryWithObjects:@[@"4",@"Gender/Life stage"] forKeys:@[@"id",@"val"]]];
        [arrMenu addObject:[NSDictionary dictionaryWithObjects:@[@"5",@"Physical Therapy"] forKeys:@[@"id",@"val"]]];
        [arrMenu addObject:[NSDictionary dictionaryWithObjects:@[@"6",@"Wellness/Special Interest"] forKeys:@[@"id",@"val"]]];
    }
    return arrMenu;
}
-(NSMutableArray *)getProfileData:(int)dataType{
    NSMutableArray *arrData=[NSMutableArray array];
    if(dataType==DATA_TRAININGSPORTS_TEAMS){
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"1",@"Baseball"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"2",@"Basketball"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"3",@"Cross Country"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"4",@"Football"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"5",@"Hockey"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"6",@"Lacrosse"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"7",@"Soccer"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"8",@"Softball"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"9",@"Track and Field"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"10",@"Volleyball"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"11",@"Wrestling"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"12",@"Water Polo"] forKeys:@[@"id",@"val"]]];
    }else if(dataType==DATA_TRAININGSPORTS_INDIVIDUAL){
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"1",@"Boxing"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"2",@"Equestrian"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"3",@"Cycling"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"4",@"Golfing"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"5",@"Diving"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"6",@"Hiking"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"7",@"Ice Skating"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"8",@"Gymnastics"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"9",@"Kickboxing"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"10",@"MMA Mixed Martial Arts"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"11",@"Martial Arts"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"12",@"Rowing"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"13",@"Skiing"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"14",@"Snow-boarding"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"15",@"Surfing"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"16",@"Swimming"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"17",@"Running"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"18",@"Trail Running"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"19",@"Triathlon"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"20",@"Tennis"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"21",@"Tai Chi"] forKeys:@[@"id",@"val"]]];
    }else if(dataType==DATA_TRAININGSPORTS_FITNESS){
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"1",@"Aerobics"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"2",@"Pilates"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"3",@"Water Fitness"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"4",@"Walking"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"5",@"Roller Blading"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"6",@"Jogging"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"7",@"Bicycling"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"8",@"Nordic Walking"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"9",@"Dancing"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"10",@"Choreo-graphy"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"11",@"Yoga"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"12",@"Zumba (Latin Dance)"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"13",@"Stretching/Flexibility"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"14",@"Meditation"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"15",@"Mind & Body"] forKeys:@[@"id",@"val"]]];
    }else if(dataType==DATA_TRAININGSPORTS_STRENGTH){
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"1",@"Bodybuilding"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"2",@"Boot Camps"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"3",@"Cardio Machines"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"4",@"Circuit Training"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"5",@"Core Conditioning"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"6",@"TRX (Suspension Training)"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"7",@"Body Leverage/Bodyweight Training"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"8",@"Kettlebells"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"9",@"Gyrotonic, Gyrokinesis"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"10",@"Nia"] forKeys:@[@"id",@"val"]]];
    }else if(dataType==DATA_SPECIALITY_WEIGHTLOSS){
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"1",@"All"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"2",@"Weight Loss"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"3",@"Weight Management"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"4",@"Aerobics"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"5",@"Cardio Workouts"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"6",@"Core Training"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"7",@"Diet and Nutrition"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"8",@"Toning and General Fitness"] forKeys:@[@"id",@"val"]]];
    }else if(dataType==DATA_SPECIALITY_STRENGTH){
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"1",@"Weight Training"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"2",@"Strength Training"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"3",@"Bodybuilding"] forKeys:@[@"id",@"val"]]];
    }else if(dataType==DATA_SPECIALITY_SPORTS){
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"1",@"All"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"2",@"Speed and Agility Training"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"3",@"Sports Conditioning"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"4",@"Sports Nutrition"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"5",@"Plyometrics"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"6",@"Athletic Training"] forKeys:@[@"id",@"val"]]];
    }else if(dataType==DATA_SPECIALITY_GENDER){
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"1",@"Women’s fitness"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"2",@"Men's Fitness"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"3",@"Senior Fitness"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"4",@"Kid's Fitness"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"5",@"Prenatal/Postnatal Fitness"] forKeys:@[@"id",@"val"]]];
    }else if(dataType==DATA_SPECIALITY_PHYSICAL){
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"1",@"Rehabilitation"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"2",@"Physical Therapy"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"3",@"Medical Fitness for Chronic Conditions"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"4",@"Back Pain Prevention"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"5",@"Biomechanics"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"6",@"Clinical Exercise Physiologist"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"7",@"Flexibility"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"8",@"Injury Prevention"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"9",@"Postrehab/Injury Recovery"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"10",@"Kinesiology"] forKeys:@[@"id",@"val"]]];
    }else if(dataType==DATA_SPECIALITY_WELLNESS){
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"1",@"Wellness Coaching"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"2",@"Wellness/Preventive"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"3",@"Corporate Wellness"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"4",@"Executive Fitness"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"5",@"Lifestyle coaching"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"6",@"Water Fitness"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"7",@"Mind-Body Fitness"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"8",@"Fitness Education"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"9",@"Stress Management"] forKeys:@[@"id",@"val"]]];
    }else if(dataType==DATA_PROFESSIONAL_EXPERIENCE){
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"1",@"Weight Loss/Management"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"2",@"Toning and General Fitness"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"3",@"Strength Training"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"4",@"Bodybuilding"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"5",@"Speed and Agility Training"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"6",@"Sports Conditioning"] forKeys:@[@"id",@"val"]]];
        [arrData addObject:[NSDictionary dictionaryWithObjects:@[@"7",@"Post-rehab/Injury Recovery"] forKeys:@[@"id",@"val"]]];
    }
    return arrData;
}

//Private Methods

@end
