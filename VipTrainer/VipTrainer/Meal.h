
@interface Meal : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *description;
@property (nonatomic) NSString *calories;

-(id)initWithDictionary:(NSDictionary *)dictionary;
-(NSString *)getMealString;
@end
