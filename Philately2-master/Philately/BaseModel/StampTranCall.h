//
//  StampTranCall.h
//  Philately
//
//  Created by gdpost on 15/6/17.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CstmMsg.h"
#import "SysBaseInfo.h"
#import <ServiceInvoker.h>

@protocol StampTranCallDelegate;

@interface StampTranCall : NSObject<ServiceInvokerDelegate>
{
  
}
+ (StampTranCall *) sharedInstance;

@property (strong, nonatomic) id<StampTranCallDelegate>  delegate;
@property (strong, nonatomic) UIViewController *viewController;
-(void)jyTranCall:(SysBaseInfo *) sysBaseInfo  cstmMsg:(CstmMsg*)cstmMsg  formName:(NSString*)formName business:(NSDictionary*)business delegate:(id<StampTranCallDelegate>)delegate viewController:(UIViewController*)viewController;

@end



@protocol StampTranCallDelegate<NSObject>

@required

//业务请求返回数据
-(void) ReturnData:(MsgReturn*)msgReturn;
-(void) ReturnError:(MsgReturn*)msgReturn;

@end