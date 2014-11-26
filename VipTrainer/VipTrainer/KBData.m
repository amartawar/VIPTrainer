#import "KBData.h"


@implementation KBData



static KBData *sharedInstance = nil;
@synthesize user;

// Get the shared instance and create it if necessary.
+ (KBData *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

// We can still have a regular init method, that will get called the first time the Singleton is used.
- (id)init
{
    self = [super init];
    
    if (self) {
        user = [User user];
        self.notifications = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)reset{
    DATA.selectedWorkout = nil;
    DATA.partnership = nil;
    [self.notifications removeAllObjects];
}


// We don't want to allocate a new instance, so return the current one.
+ (id)allocWithZone:(NSZone*)zone {
    return [self sharedInstance];
}

// Equally, we don't want to generate multiple copies of the singleton.
- (id)copyWithZone:(NSZone *)zone {
    return self;
}

@end