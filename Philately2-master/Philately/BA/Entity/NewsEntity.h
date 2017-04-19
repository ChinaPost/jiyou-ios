//
//  NewsEntity.h
//  Philately
//
//  Created by Mirror on 15/7/6.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsEntity : NSObject
{
NSString* infoID	;//消息代号
NSString*  infoTitle	;//消息标题
NSString*  infoContent	;//消息内容
NSString*  gmtCreate	;//消息发布时间
}

@property (nonatomic)NSString* infoID	;//消息代号
@property (nonatomic)NSString*  infoTitle	;//消息标题
@property (nonatomic)NSString*  infoContent	;//消息内容
@property (nonatomic)NSString*  gmtCreate	;//消息发布时间

@end
