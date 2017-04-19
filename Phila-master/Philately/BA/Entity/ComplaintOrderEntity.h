//
//  complaintOrderEntity.h
//  Philately
//
//  Created by Mirror on 15/7/6.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//
//投诉单实体类
#import <Foundation/Foundation.h>

@interface ComplaintOrderEntity : NSObject
{
    NSString* complaintNo	;//投诉单号
    NSString* orderNo ;//关联订单号
    NSString* complaintStatus	;//投诉单状态
    NSString* errorReason	;//处理失败原因
    NSString* complaintTime	;//投诉时间
    NSString* cstmName	;//联系人
    NSString* cstmPhone	;//联系电话
    NSString* complaintContent	;//投诉内容
    NSString* opinionContent	;//回复内容
    NSString* opinionTime	;//回复时间
}

@property (nonatomic) NSString* complaintNo	;//投诉单号
@property (nonatomic) NSString* orderNo ;//关联订单号
@property (nonatomic) NSString* complaintStatus	;//投诉单状态
@property (nonatomic) NSString* errorReason	;//处理失败原因
@property (nonatomic) NSString* complaintTime	;//投诉时间
@property (nonatomic) NSString* cstmName	;//联系人
@property (nonatomic) NSString* cstmPhone	;//联系电话
@property (nonatomic) NSString* complaintContent	;//投诉内容
@property (nonatomic) NSString* opinionContent	;//回复内容
@property (nonatomic) NSString* opinionTime	;//回复时间

@end
