//
//  OrderPay0039.m
//  Philately
//
//  Created by Mirror on 15/8/3.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "OrderPay0039.h"
#import <AlipaySDK/AlipaySDK.h>



@implementation OrderPay0039


-(void)orderPay:(NSDictionary*)payInfo delegate:(id<OrderPay0039Delegate>)_delegate
{
    self.delegate =_delegate;
    
    NSString* n0039 =@"JY0039";
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    
    SysBaseInfo *_sysBaseInfo = [SysBaseInfo sharedInstance];
    _sysBaseInfo.IP=@"1.0.0.127";
    StampTranCall * stampTranCall = [StampTranCall sharedInstance];
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0039 business:payInfo delegate:self viewController:nil];
}
-(void) ReturnData:(MsgReturn*)msgReturn
{
    if ([msgReturn.formName isEqual:@"JY0039"]) {
        if(msgReturn.map==nil)
            return;
        
        NSLog(@"0039 %lu",(unsigned long)[msgReturn.map count]);
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        
        NSString* paySeq =[returnDataBody objectForKey:@"paySeq"];
        
        
        NSString* appScheme=@"PhilatelyScheme";
        
        if (paySeq != nil) {
            [[AlipaySDK defaultService] payOrder:paySeq fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                
                NSLog(@"reslut = %@",resultDic);
                NSString*status =[resultDic objectForKey:@"resultStatus"];
                if (self.delegate) {
                    [self.delegate payResult:resultDic];
                }
                
            }];
        }
        
    }
}
-(void) ReturnError:(MsgReturn*)msgReturn
{
    
}
@end
