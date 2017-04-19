//
//  ReservationEntity.h
//  Philately
//
//  Created by Mirror on 15/7/6.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//
//预订资格实体类
#import <Foundation/Foundation.h>

@interface ReservationEntity : NSObject
{
   NSString* bookType	;//预定类型
   NSString*  bookName	;//预定名称
   NSString*  bookAmount	;//预定金额
   NSString*  marginAmount	;//保证金额
   NSString*  otherAmount	;//其他费用
   NSString*  limitNum	;//预定上限
   NSString*  flag	;//摇号类型
}

@property (nonatomic)NSString*  bookType	;//预定类型
@property (nonatomic)NSString*  bookName	;//预定名称
@property (nonatomic)NSString*  bookAmount	;//预定金额
@property (nonatomic)NSString*  marginAmount	;//保证金额
@property (nonatomic)NSString*  otherAmount	;//其他费用
@property (nonatomic)NSString*  limitNum	;//预定上限
@property (nonatomic)NSString*  flag	;//摇号类型

@end
