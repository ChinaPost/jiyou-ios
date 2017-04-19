


#import "PersisctencesData.h"
@implementation PersisctencesData
{
    
}

 

+(bool)write:(id)obj withPath:(NSString*)path{
    NSData *freezeDrid;
    freezeDrid=[NSKeyedArchiver archivedDataWithRootObject:obj];
    NSString *str =[PersisctencesData createPath:path];
    bool result=[freezeDrid writeToFile:str atomically:YES];
    
    return result;
}




+(id)getObj:(NSString*)path{
    NSData *fileData;
    NSString*str=[PersisctencesData createPath:path];
    fileData=[NSData dataWithContentsOfFile:str];
    id returnObj=[NSKeyedUnarchiver unarchiveObjectWithData:fileData];
    return returnObj;
}



+(bool)writeArray:(NSArray*)array withPath:(NSString*)path{
    NSString *str =[PersisctencesData createPath:path];
    bool writeReult= [array writeToFile:str atomically:YES];
     return writeReult;
}
+(NSArray*)getArray:(NSString*)path{
    NSString*str=[PersisctencesData createPath:path];
    if ([[NSFileManager defaultManager]fileExistsAtPath:str]) {
        NSArray *array = [[NSArray alloc]initWithContentsOfFile:str];
        return array;
    }
    else {
        return nil;
    }       

}



+(bool)writeDic:(NSDictionary*)dic withPath:(NSString*)path{
    NSString *str =[PersisctencesData createPath:path];
 return  [dic writeToFile:str atomically:YES];
}
+(NSDictionary*)getDic:(NSString*)path{
    NSString*str=[PersisctencesData createPath:path];
    if ([[NSFileManager defaultManager]fileExistsAtPath:str]) {
        NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:str];
        return dic;
    }
    else {
        return nil;
    }       

}


+(bool)writeText:(NSString*)text withPath:(NSString*)path{
    NSString*str=[PersisctencesData createPath:path];
    return  [text writeToFile:str atomically:YES encoding:NSUTF8StringEncoding error:nil];    
}
+(NSString*)getText:(NSString*)path{
    NSString*str=[PersisctencesData createPath:path];
    return  [NSString stringWithContentsOfFile:str encoding:NSUTF8StringEncoding error:nil];
}


+(NSString*)createPath:(NSString*)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *str = [documentsDirectory stringByAppendingPathComponent:fileName];
    return str;
}



@end
