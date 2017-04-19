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
    self=[self stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    self=[self stringByReplacingOccurrencesOfString:@"\"{" withString:@"{"];
    self=[self stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
    return self;
}

+(NSString*)appDocPath{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}
@end
