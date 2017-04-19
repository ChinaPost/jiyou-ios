//
//  Device.h
//  Philately
//
//  Created by apple on 15/7/3.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Device : NSObject

/*
 02
 *  获取版本型号
 03
 *  "i386"          simulator
 04
 *  "iPod1,1"       iPod Touch
 05
 *  "iPhone1,1"     iPhone
 06
 *  "iPhone1,2"     iPhone 3G
 07
 *  "iPhone2,1"     iPhone 3GS
 08
 *  "iPad1,1"       iPad
 09
 *  "iPhone3,1"     iPhone 4
 10
 */

+(NSString *)deviceString;

+ (Device *) sharedInstance;

@property (nonatomic) int tabHeight;
@end
