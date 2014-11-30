//
//  KBProfileDataSource.h
//  VipTrainer
//
//  Created by AmitSanvedi on 29/11/14.
//  Copyright (c) 2014 Kyle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBProfileDataSource : NSObject
+ (KBProfileDataSource *)sharedDataSource;
-(NSMutableArray *)getProfileMenu:(int)menuType;
-(NSMutableArray *)getProfileData:(int)dataType;

@end
