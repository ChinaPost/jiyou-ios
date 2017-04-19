//
//  StampTranCall.m
//  Philately
//
//  Created by gdpost on 15/6/17.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "StampTranCall.h"
#import "SysBaseInfo.h"
#import <PublicFramework/OperatorMsg.h>
#import "SVProgressHUD.h"
#import "PromptError.h"
#import <PublicFramework/JSONKit.h> 

#include <arpa/inet.h>
#include <net/if.h>
#include <ifaddrs.h>
#import "SVProgressHUD.h"

@implementation StampTranCall


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
  NSTimer *timmer;
bool isOpenLoading;

-(void)jyTranCall:(SysBaseInfo *) sysBaseInfo  cstmMsg:(CstmMsg*)cstmMsg formName:(NSString*)formName business:(NSDictionary*)business delegate:(id<StampTranCallDelegate>)delegate viewController:(UIViewController*)viewController
{
    isOpenLoading=sysBaseInfo.isOpenLoading;
    sysBaseInfo.isOpenLoading=false;
    self.viewController=viewController;
    self.delegate=delegate;
    

     dispatch_async(dispatch_get_main_queue(), ^{
       
         if ([SVProgressHUD isVisible]==true) {
             
         }else
         {
             [SVProgressHUD showWithStatus:@"努力加载中..." maskType:SVProgressHUDMaskTypeClear];
         }
     });


    
    NSMutableDictionary *tranBodyDic=[[NSMutableDictionary alloc] init];
    tranBodyDic=business;
    
     NSMutableDictionary *tranheadDic=[[NSMutableDictionary alloc] init];
     [tranheadDic setValue:formName forKey:@"tranNo"];
     [tranheadDic setValue:sysBaseInfo.channelNo forKey:@"channelNo"];
     [tranheadDic setValue:sysBaseInfo.curTermType forKey:@"termType"];
    
    NSUserDefaults *userdefalut=[NSUserDefaults standardUserDefaults];
    
    NSString *logicId=[userdefalut objectForKey:@"logicId"];
    
    
     [tranheadDic setValue:logicId  forKey:@"termNo"];//sysBaseInfo.curTermNo
    
//    if (sysBaseInfo.IP==nil ||[sysBaseInfo.IP isEqualToString:@""]) {
//         sysBaseInfo.IP= [self localIPAddress];
//    }
   
     [tranheadDic setValue:sysBaseInfo.IP forKey:@"IP"];
     [tranheadDic setValue:sysBaseInfo.tranNum forKey:@"tranNum"];
    
    if (cstmMsg.cstmNo==nil ) {
        [tranheadDic setValue:@"" forKey:@"memberNo"];
    }else{
     [tranheadDic setValue:cstmMsg.cstmNo forKey:@"memberNo"];
    }
   
    
    NSMutableDictionary *sendDataDic=[[NSMutableDictionary alloc] init];
    [sendDataDic setValue:tranheadDic forKey:@"tranhead"];
      [sendDataDic setValue:tranBodyDic forKey:@"tranBody"];
    
    NSMutableDictionary *fullDic=[[NSMutableDictionary alloc] init];
    [fullDic setValue:sendDataDic forKey:@"sendData"];
    
    
    
    
    
   ServiceInvoker *serviceInvoker=[ServiceInvoker sharedInstance];
    [serviceInvoker  setDelegate:self];

     NSLog(@"hobby request %@ %@",formName,fullDic);
    [serviceInvoker callWebservice:fullDic formName:formName ];

    
    timmer  = [NSTimer scheduledTimerWithTimeInterval:35 target:self selector:@selector(timeFire) userInfo:nil repeats:NO];

}

-(void)timeFire
{
       [SVProgressHUD dismiss];
    
//    MsgReturn *msgReturn= [[MsgReturn alloc]init ];
//    msgReturn.errorCode=ERROR_TIMEOUT_ERROR ;
//    msgReturn.errorDesc=ERROR_TIMEOUT;
//    msgReturn.errorType=@"01";
//    [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel)
//     {
//         if (OKCancel) {
//             
//         }else
//         {
//             
//         }
//         return ;
//     }
//     ];
    
 

}


//业务请求返回错误
-(void)serviceInvokerError:(MsgReturn*)msgReturn
{
    if (msgReturn==nil ) {
        return;
    }
    
       [timmer invalidate];
     timmer=nil;
      dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
      });
  
  
    
   if(msgReturn.formName!=nil && [msgReturn.errorCode isEqualToString:ERROR_FAILED])
    {//交易失败
        
        
    }
    
    else
    {
        //网络错误 服务器错误  传输格式错误
        if([msgReturn.errorCode isEqualToString:ERROR_DATA_FORMAT_ERROR] || [msgReturn.errorCode isEqualToString:ERROR_SERVICE_IN_ERROR] || [msgReturn.errorCode isEqualToString:ERROR_NOT_NET])
            
        {
           
            
          
            [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel)
             {
                 if (OKCancel) {
                     
                 }else
                 {
                     
                 }
                 return ;
             }
             ];

        }
    }
       [self.delegate ReturnError:msgReturn];
    
    NSLog(@"%@ %@",msgReturn.formName,msgReturn.errorDesc);
    
}

//业务请求返回数据
-(void)serviceInvokerReturnData:(MsgReturn*)msgReturn
{
       [timmer invalidate];
    timmer=nil;
    
    if([msgReturn.errorCode isEqualToString:ERROR_SUCCESS])
    {//callWebservice成功
        
        if ([msgReturn.formName isEqual:@"JY0052"]||[msgReturn.formName isEqual:@"JY0049"]) {
            
        }
        else
        {
              dispatch_async(dispatch_get_main_queue(), ^{
                  if (isOpenLoading) {//true开着
                      
                  }else
                  {//false 关闭
                  [SVProgressHUD dismiss];
                  }
               
              });
      
        }
        
        
        
        NSMutableDictionary* map=msgReturn.map;
        NSString *businessParamString=[map objectForKey:@"businessParam"];
        NSDictionary *businessParamDic=[businessParamString objectFromJSONString];
        NSString *data=[businessParamDic objectForKey:@"data"];
        msgReturn.map=[data objectFromJSONString];
        NSMutableDictionary *returnDataDic=[[data objectFromJSONString] objectForKey:@"returnData"];
        NSMutableDictionary *returnHeadDic=[returnDataDic objectForKey:@"returnHead"];
        NSString *respCode=[returnHeadDic objectForKey:@"respCode"];
        NSString *respDesc=[returnHeadDic objectForKey:@"respDesc"];
        
        NSMutableDictionary *returnBodyDic=[returnDataDic objectForKey:@"returnBody"];
    
     
        [self.delegate ReturnData:msgReturn];
        
        
    }else{//错误码 非0000
    
           dispatch_async(dispatch_get_main_queue(), ^{
                              [SVProgressHUD dismiss];
               
           });
        
        NSLog(@"%@ %@",msgReturn.errorCode,msgReturn.errorDesc);
        
  
  
        [PromptError changeShowErrorMsg:msgReturn title:nil viewController:self.viewController block:^(BOOL OKCancel){
            if (OKCancel) {
                      [self.delegate ReturnError:msgReturn];
            }
        
        } ];
    }
    
}



//实现一个创建单例对象的类方法

static StampTranCall *objName = nil;

+ (StampTranCall *) sharedInstance{
    static dispatch_once_t oneToken = 0;
    dispatch_once(&oneToken, ^{
        objName = [[super allocWithZone: NULL] init];
    });
    return objName;
}

//重写几个方法，防止创建单例对象时出现错误
-(id) init{
    if(self = [super init])
    {
        //初始化单例对象的各种属性
    }
    return self;
}

+(id)allocWithZone: (struct _NSZone *) zone{
    return [self sharedInstance];
}

//这是单例对象遵循<NSCopying>协议时需要实现的方法
-(id) copyWithZone: (struct _NSZone *)zone{
    return self;
}


//- (NSString *)localIPAddress
//{
//    NSString *localIP = nil;
//    struct ifaddrs *addrs;
//    if (getifaddrs(&addrs)==0) {
//        const struct ifaddrs *cursor = addrs;
//        while (cursor != NULL) {
//            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
//            {
//                //NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
//                //if ([name isEqualToString:@"en0"]) // Wi-Fi adapter
//                {
//                    localIP = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
//                    break;
//                }
//            }
//            cursor = cursor->ifa_next;
//        }
//        freeifaddrs(addrs);
//    }
//    return localIP;
//}


@end
