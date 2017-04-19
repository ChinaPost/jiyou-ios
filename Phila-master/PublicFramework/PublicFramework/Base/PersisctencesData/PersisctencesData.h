
#import <Foundation/Foundation.h>


@interface PersisctencesData : NSObject


+(bool)write:(id)obj withPath:(NSString*)path;
+(id)getObj:(NSString*)path;

+(bool)writeArray:(NSArray*)array withPath:(NSString*)path;
+(NSArray*)getArray:(NSString*)path;

+(bool)writeDic:(NSDictionary*)dic withPath:(NSString*)path;
+(NSDictionary*)getDic:(NSString*)path;

+(bool)writeText:(NSString*)text withPath:(NSString*)path;
+(NSString*)getText:(NSString*)path;



@end

