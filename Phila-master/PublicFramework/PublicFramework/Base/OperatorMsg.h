//
//  OperatorMsg.h
//  PublicFramework
//
//  Created by gdpost on 15/5/29.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#ifndef PublicFramework_OperatorMsg_h
#define PublicFramework_OperatorMsg_h
@interface OperatorMsg :NSObject

@property (retain, nonatomic)  NSString *organName ;
//机构号
@property (retain, nonatomic)  NSString *organId ;
//操作员
@property (retain, nonatomic)  NSString *oprId ;
//渠道号
@property (retain, nonatomic)  NSString *channelId ;
//操作员所属省局
@property (retain, nonatomic)  NSString *privinceBrchNo ;
//操作员所属市局
@property (retain, nonatomic)  NSString *cityBrchNo ;
//操作员所属县局
@property (retain, nonatomic)  NSString *countyBrchNo ;

@end


#endif
