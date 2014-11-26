//
//  VipNotification.h
//  
//
//  Created by kenney on 5/21/14.
//
//

#import <Parse/Parse.h>

@interface Notification : PFObject <PFSubclassing>
+(NSString *)parseClassName;


@property (nonatomic) NSString *message;
@property (nonatomic) Partnership *partnership;
@property (nonatomic) User *recipient;
@property (nonatomic) User *sender;
@property (nonatomic) NSString *type;

@end
