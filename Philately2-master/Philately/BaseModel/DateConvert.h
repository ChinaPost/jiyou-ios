//
//  DateConvert.h
//  Philately
//
//  Created by gdpost on 15/7/29.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateConvert : NSObject

+(NSString*) convertDateFromString:(NSString*)uiDate;
+(NSString*) convertDateFromStringShort:(NSString*)uiDate;
+(BOOL)isCommonChar:(NSString*)chars;
@end
