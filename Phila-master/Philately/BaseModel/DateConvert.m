//
//  DateConvert.m
//  Philately
//
//  Created by gdpost on 15/7/29.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "DateConvert.h"

@implementation DateConvert


+(NSString*) convertDateFromString:(NSString*)uiDate
{
    if (uiDate==nil ||[uiDate isEqualToString:@""]) {
        return @"";
    }
    
   uiDate= [uiDate stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    if([uiDate length]==17)
    {
       uiDate= [uiDate substringToIndex:17-3];
    
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if ([uiDate length]<9) {
        [dateFormatter setDateFormat: @"yyyyMMdd"];
    }else
    {
    [dateFormatter setDateFormat: @"yyyyMMdd HH:mm"];//yyyy-MM-dd HH:mm:ss
    }
    
    NSDate *destDate= [dateFormatter dateFromString:uiDate];
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
     if ([uiDate length]<9) {
    [formatter setDateFormat:@"yyyy年MM月dd日"];
     }else
     {
          [formatter setDateFormat:@"yyyy年MM月dd日 HH时mm分"];
     }
    
    NSString *strDate = [formatter stringFromDate:destDate];
    
    return strDate;
}


+(NSString*) convertDateFromStringShort:(NSString*)uiDate
{
    if (uiDate==nil ||[uiDate isEqualToString:@""]) {
        return @"";
    }
    
    uiDate= [uiDate stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    if([uiDate length]==17)
    {
        uiDate= [uiDate substringToIndex:17-3];
        
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if ([uiDate length]<9) {
        [dateFormatter setDateFormat: @"yyyyMMdd"];
    }else
    {
        [dateFormatter setDateFormat: @"yyyyMMdd HH:mm"];//yyyy-MM-dd HH:mm:ss
    }
    
    NSDate *destDate= [dateFormatter dateFromString:uiDate];
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    if ([uiDate length]<9) {
        [formatter setDateFormat:@"yyyy年MM月dd日"];
    }else
    {
        [formatter setDateFormat:@"yyyy年MM月dd日"];
    }
    
    NSString *strDate = [formatter stringFromDate:destDate];
    
    return strDate;
}



+(BOOL)isCommonChar:(NSString*)chars
{
    if (chars==nil ||[chars isEqualToString:@""]) {
        return true;
    }
    
    NSString *regex = @"^[a-zA-Z0-9_\\-\u4e00-\u9fa5\\,\\.\\?\\;\\:\'\"\\{\\}\\[\\]\\!！，。？；：‘’“”【】｛｝\\s]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValid = [predicate evaluateWithObject:chars];
    
    
    
    return isValid;

}

@end
