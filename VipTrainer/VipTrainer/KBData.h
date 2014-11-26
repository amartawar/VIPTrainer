/*
    
        A Static class for persistantly storing some key session information between viewcontrollers.
    
 
        This can be accessed with the DATA keyword (defined in commons.h)
 
 */








#import <Foundation/Foundation.h>
#import "User.h"
#import "Workout.h"
#import "Partnership.h"
#import "Progress.h"


@interface KBData : NSObject
+(id)sharedInstance;

-(void)reset;//Resets the data, but makes sure any array or object are initialized. Use for logging out

@property (nonatomic) User *user; //The current user. Only really used for Signup before Parse.currentUser is set.
@property (nonatomic) Partnership *partnership; // The current partnership. This is the relationship between Client and Trainer. See "Partnership.h" for details
@property (nonatomic) Workout *selectedWorkout; //The current workout. This is used by the client when they are on the "Today's workout" page.
@property (nonatomic) NSMutableArray *notifications;
@property (nonatomic) NSMutableArray *partnerships;
@property (nonatomic) Progress *selectedProgress;
@property (nonatomic) NSMutableArray *progresses;


@property (nonatomic, strong) PFObject *chatThread; // The currently viewed chat thread. this is set by ChatList and used by ChatView.
@property (nonatomic, strong) PFFile *chat_my_image; //Your profile picture used for all the chat views
@property (nonatomic, strong) PFFile *chat_other_image; //The person you are chatting with's picture.


@end
