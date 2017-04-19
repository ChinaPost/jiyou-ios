//
//  complaintOrderEntity.m
//  Philately
//
//  Created by Mirror on 15/7/6.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//
//投诉单实体类
#import "ComplaintOrderEntity.h"

@implementation ComplaintOrderEntity


@synthesize complaintNo	;//投诉单号
@synthesize orderNo;//关联订单号
@synthesize complaintStatus	;//投诉单状态
@synthesize errorReason	;//处理失败原因
@synthesize complaintTime	;//投诉时间
@synthesize cstmName	;//联系人
@synthesize cstmPhone	;//联系电话
@synthesize complaintContent	;//投诉内容
@synthesize opinionContent	;//回复内容
@synthesize opinionTime	;//回复时间

@end
