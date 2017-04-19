//
//  NSString+GSUtil.m
//  iFreePoster
//
//  Created by Yangtsing.Zhang on 13-7-31.
//  Copyright (c) 2013年 URoad. All rights reserved.
//

#import "NSString+GSUtil.h"

@implementation NSString (GSUtil)

-(NSString*)stringWithoutESCCharater{
    if (self==nil) {
        return nil;
    }
    NSString *temp;
    temp=[self stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    temp=[self stringByReplacingOccurrencesOfString:@"\"{" withString:@"{"];
    temp=[self stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
    return temp;
}

+(NSString*)appDocPath{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}
@end
