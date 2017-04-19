//
//  SysBaseInfo.h
//  Philately
//
//  Created by gdpost on 15/6/17.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SysBaseInfo :NSObject

//sysBaseInfo.appID=@"stampStore_IOS";
//sysBaseInfo.appVersion=@"1.0";
//sysBaseInfo.appConfigVersion=@"1.0";
//sysBaseInfo.curTermType=@"02";//终端类型 02ios
//sysBaseInfo.curTermNo=@"";//当时终端号 android ios为空
//sysBaseInfo.channelNo=@"16";//渠道号 android ios 16
//sysBaseInfo.IP=@"";
//sysBaseInfo.tranNum=@"";//终端流水号 暂时为空

@property (strong, nonatomic)  NSString *appID;
@property (strong, nonatomic)  NSString *appVersion;
@property (strong, nonatomic)  NSString *appConfigVersion;
@property (strong, nonatomic) NSString *curTermType;
@property (strong, nonatomic) NSString  *curTermNo;
@property (strong, nonatomic) NSString  *channelNo;
@property (strong, nonatomic) NSString  *IP;
@property (strong, nonatomic) NSString  *tranNum;

@property ( nonatomic) bool  *isOpenLoading;//false关  true开着

+ (SysBaseInfo *) sharedInstance;
@end
