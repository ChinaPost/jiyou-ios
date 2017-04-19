//
//  ServiceEntity.h
//  Philately
//
//  Created by Mirror on 15/7/7.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceEntity : NSObject
{
    NSString* serviceKey;
    NSString* serviceCode;
    NSString* serviceName;
    NSString* serviceName_Backup1;
    NSString* serviceName_Backup2;
    NSString* serviceName_Backup3;
}

@property (nonatomic)NSString* serviceKey;
@property (nonatomic)NSString* serviceCode;
@property (nonatomic)NSString* serviceName;
@property (nonatomic)NSString* serviceName_Backup1;
@property (nonatomic)NSString* serviceName_Backup2;
@property (nonatomic)NSString* serviceName_Backup3;

@end
