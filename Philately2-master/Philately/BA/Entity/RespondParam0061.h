//
//  RespondParam0061.h
//  Philately
//
//  Created by Mirror on 15/8/20.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RespondParam0061 : NSObject

@property (nonatomic)int checkId	;//记录编号
@property (nonatomic)NSString* orderId	;//订单编号
@property (nonatomic)int status	;//审核状态
@property (nonatomic)NSString* checkContent	;//审核意见
@property (nonatomic)NSString* createTime	;//创建时间
@property (nonatomic)NSString* updateTime	;//修改时间
@property (nonatomic)NSString* packageStatus	;//打包状态

@property (nonatomic)int recordNum	;//审核明细数量

@property (nonatomic)NSMutableArray* logId	;//明细记录编号
@property (nonatomic)NSMutableArray* itemCheckId	;//审核记录编号
@property (nonatomic)NSMutableArray* itemOrderId	;//订单编号
@property (nonatomic)NSMutableArray* itemCheckContent	;//审核意见
@property (nonatomic)NSMutableArray* itemCreateTime	;//创建时间
@property (nonatomic)NSMutableArray* userId	;//审核人编号
@property (nonatomic)NSMutableArray* userName	;//审核人姓名
@property (nonatomic)NSMutableArray* checkNum	;//审核次数
@property (nonatomic)NSMutableArray* checkStatus	;//此次审核状态
@property (nonatomic)NSMutableArray* logStatus	;//记录状态


@end
