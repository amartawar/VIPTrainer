//
//  VipNotification.m
//  
//
//  Created by kenney on 5/21/14.
//
//

#import "Notification.h"

@implementation Notification


@dynamic message;
@dynamic partnership;
@dynamic recipient;
@dynamic sender;
@dynamic type;

+(NSString *)parseClassName{
    return @"Notification";
}

@end
