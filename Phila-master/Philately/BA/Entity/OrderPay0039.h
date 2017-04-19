//
//  OrderPay0039.h
//  Philately
//
//  Created by Mirror on 15/8/3.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "StampTranCall.h"
#import "PromptError.h"
#import "SysBaseInfo.h"

@protocol OrderPay0039Delegate <NSObject>

-(void)payResult:(NSDictionary *)resultDic;

@end

@interface OrderPay0039 : NSObject<StampTranCallDelegate>

@property(nonatomic,retain)id<OrderPay0039Delegate> delegate;

-(void)orderPay:(NSDictionary*)payInfo delegate:(id<OrderPay0039Delegate>)_delegate;
@end
