

#import "GSConfigManager.h"


#define kQueryMessageHeaderFormName @"4475620"
#define kMainPageMenuButtonSearch @"4453261"

@implementation GSConfigManager
DEF_SINGLETON(GSConfigManager)

-(NSString*)findValueFromConfigFileByKey:(NSString*)key{
    NSString*finalStr = nil;
//    NSString*filePath = [GSBundleManager pathInGSAccountBundleForResource:@"GD_PROJ183" ofType:@"conf"];
    NSString *filePath = [self getConfigFilePath:CONFIGFILE];
    NSFileManager*manager = [NSFileManager defaultManager];
    NSData*data = [manager contentsAtPath:filePath];
    NSString*fileData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //NSLog(@"fileData%@",fileData);
        
    NSArray*dataArray = [fileData componentsSeparatedByString:@"\n"];
  
    for (int i=0; i<dataArray.count; i++) {
        NSString*trimString = [[dataArray objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSRange range1 = [trimString rangeOfString:@"|"];
        if (range1.length>0) {
            NSRange range2 = [trimString rangeOfString:key];
            if (range2.location!=NSNotFound) {
                int index = range2.length+1;
                NSString*value = [[dataArray objectAtIndex:i] substringFromIndex:index];
                finalStr = [value stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            }
            
        }
    }
    return finalStr;
}


- (NSString*)getConfigFilePath:(CONFIGFILETYPE)type{
    
    
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
     NSString * filePath=[userDefault objectForKey:@"localConfigFilePath"];
    switch (type) {
        case GDD:
        {
            return [NSString stringWithFormat:@"%@GD_D.txt",filePath];
        }
            break;
        case GDS:
        {
            return [NSString stringWithFormat:@"%@GD_S.txt",filePath];

        }
            break;
        case SYSTEMPERR:
        {
            return [NSString stringWithFormat:@"%@SYSTEMERRORTIP.txt",filePath];

        }
            break;
        case CONFIGFILE:
        {
            return [NSString stringWithFormat:@"%@GD_PROJ183.conf",filePath];
        }
            break;
        default:
            break;
    }

}
@end
