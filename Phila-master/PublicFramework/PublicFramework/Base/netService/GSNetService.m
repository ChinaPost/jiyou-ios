//
//  GSNetService.m
//  iFreePoster
//
//  Created by Yangtsing.Zhang on 13-7-23.
//  Copyright (c) 2013年 URoad. All rights reserved.
//

#import "GSNetService.h"

#import "JSONKit.h"
//#import "SBJson.h"
#import "CPSServerImplService.h"
//#import "GSComponetProxy.h"
//#import "POMCL.h"
//#import "GSConfigManager.h"
#import "NSString+ThreeDES.h"
#import "ErrorMsg.h"
#import "WebConfig.h"

@implementation GSNetService
{
   
    
    NSString *actionIDkey;
}


DEF_SINGLETON(GSNetService)

-(NSArray*)adViewsFromServerWithSizeType:(adViewSizeType)type{
    NSMutableArray *array=nil;

    return array;
}

//将业务参数封装为待发送报文
+(void)encapsulateHead:(NSMutableDictionary *)param FormName:(NSString *)formName{
    
    //NSString *A183USER = @"183mobileapp";//@"A-183USER";
   // NSString *A183PASS =@"qaz123456"; //@"A-183PWD";
    NSString *ChannelNo =@"06";//@"A-CHANNEL_NO";
    NSString *ChannelTrace = @"11";//@"A-CHANNEL_TRACE_IOS";
    NSString *router = @"router_144";//@"A-ROUTER_CODE";
    //    NSString *RouteCode = [@"A-ROUTER_CODE"];
    
    //    NSDictionary * headDic = [NSDictionary dictionaryWithObjectsAndKeys: @"0000000",@"H_BRCH_NO",@"00",@"H_OPER_NO",@"10000176",@"H_SEQ_NO",@"127.0.0.1",@"H_IP_ADDR",@"pts_38",@"H_TTY",@"",@"H_AUTH_OPER_NO",ChannelTrace,@"H_CHANNEL_TRACE",ChannelNo,@"H_CHANNEL_NO",@"51080100",@"H_BRCH_NO_NEW",@"XU00",@"H_OPER_NO_NEW",@"0000",@"H_SFILE_NUM", nil];
    NSMutableDictionary* userPushInfo = [NSMutableDictionary dictionaryWithContentsOfFile:PUSH_FILE_PATH];
    NSString *H_tty_String = [[NSString alloc]init];
    NSString*ttyflag =@"0";// @"A-TTY_FLAG";
    if ([ttyflag isEqualToString:@""]||ttyflag == nil) {
        H_tty_String = @"999999999999999";
    }else{
        if ([ttyflag isEqualToString:@"0"]) {
            H_tty_String = @"999999999999999";
        }else{
            if ([formName isEqualToString:@"4476480"]) {
                H_tty_String = [userPushInfo valueForKey:DeviceTokenStringKEY];
            }else{
                H_tty_String = @"999999999999999";
            }
        }

    }
  
    NSString *organ                    = @"51000601";//@"organ";
    NSString *operationId              = @"XU01";//@"operationId";
//    NSDictionary * headDic             = [NSDictionary dictionaryWithObjectsAndKeys: @"0000000",@"H_BRCH_NO",@"00",@"H_OPER_NO",@"10000176",@"H_SEQ_NO",@"127.0.0.1",@"H_IP_ADDR",H_tty_String,@"H_TTY",@"",@"H_AUTH_OPER_NO",ChannelTrace,@"H_CHANNEL_TRACE",ChannelNo,@"H_CHANNEL_NO",organ,@"H_BRCH_NO_NEW",operationId,@"H_OPER_NO_NEW",@"0000",@"H_SFILE_NUM", nil];

    NSMutableDictionary *headDic = [[NSMutableDictionary alloc]init];
    [headDic setValue:@"0000000" forKey:@"H_BRCH_NO"];
    [headDic setValue:@"00" forKey:@"H_OPER_NO"];
    [headDic setValue:ChannelTrace forKey:@"H_SEQ_NO"];
    [headDic setValue:@"127.0.0.1" forKey:@"H_IP_ADDR"];
    [headDic setValue:H_tty_String forKey:@"H_TTY"];
    [headDic setValue:@"" forKey:@"H_AUTH_OPER_NO"];
    [headDic setValue:ChannelTrace forKey:@"H_CHANNEL_TRACE"];
    [headDic setValue:ChannelNo forKey:@"H_CHANNEL_NO"];
    [headDic setValue:organ forKey:@"H_BRCH_NO_NEW"];
    [headDic setValue:operationId forKey:@"H_OPER_NO_NEW"];
    [headDic setValue:@"0000" forKey:@"H_SFILE_NUM"];
    
    [param setObject:headDic forKey:SNDMSG_HEAD_KEY];

//    NSMutableDictionary *businessParam=[NSMutableDictionary dictionaryWithCapacity:4];
//    [businessParam setObject:param forKey:PARAM_KEY];
//   // [businessParam setValue:A183USER forKey:USER_NAME_KEY];
//   // [businessParam setValue:A183PASS forKey:PASSWORD_KEY];
//    [businessParam setValue:formName forKey:FORM_NAME_KEY];
//    
//    NSString *businessParamJson = [businessParam JSONString];
//    NSMutableDictionary *finalDic=[NSMutableDictionary dictionaryWithCapacity:3];
//    [finalDic setValue:@"business" forKey:ACTION_KEY];
////    [finalDic setValue:ACTION_ID forKey:ACTION_ID_KEY];
//    [finalDic setValue:router forKey:ACTION_ID_KEY];
//    NSLog(@"businessParamJson=%@",businessParamJson);
//    [finalDic setObject:[[GSNetService sharedInstance] encDESString:businessParamJson] forKey:BUSINESS_PARAM_KEY];
//
//        [finalDic setObject:businessParamJson forKey:BUSINESS_PARAM_KEY];
    
   
}

+(id)parseOutReturnData:(id)response{
    
    if (WEB_SERVICE_ERROR_OR_SOAPFAULT) {
        if ([response isKindOfClass:[SoapFault class]]) {//将SoapFault 转成NSError
            NSError *error=[NSError errorWithDomain:nil code:0 userInfo:nil];
            return error;
        }
        
        return response;
    }
    
    NSString *returnDataStr=[response objectForKey:@"return"];
   NSString *tempString1=[returnDataStr stringWithoutESCCharater];
    NSDictionary *returnDataDic = [tempString1 objectFromJSONString];
    
    
    NSString *dataString = [returnDataDic valueForKey:@"data"];
    NSDictionary *returnDic = [[NSDictionary alloc]init];
    
    id datastr = [[GSNetService sharedInstance]decDESString:dataString];
    returnDic = [datastr objectFromJSONString];
    id data=[returnDic objectForKey:@"kk"];
//    id data = nil;
    if (data==nil) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        NSString *error = @"网关错误";
        [dic setValue:@"gateway" forKey:@"faultcode"];
        [dic setValue:error forKey:@"server_Return_Message"];
        return dic;
    }
    if (![data isKindOfClass:[NSDictionary class]]) {
        if ([data isKindOfClass:[NSString class]]) {
            return [NSDictionary dictionaryWithObject:@"server_Return_Message"];
        }
        return data;
    }
    data=[data objectForKey:@"returnData"];
    if ([data isKindOfClass:[NSString class]]) {
        return [NSDictionary dictionaryWithObject:@"server_Return_Message"];
    }
    
    //
    return data;
}


//底座新版 非手机营业厅旧版
-(id)parseOutReturnDataForNew:(id)response{
    
    if (WEB_SERVICE_ERROR_OR_SOAPFAULT) {
        if ([response isKindOfClass:[SoapFault class]]) {//将SoapFault 转成NSError
            NSError *error=[NSError errorWithDomain:nil code:0 userInfo:nil];
            return error;
        }
        
        return response;
    }
    
    NSString *returnDataStr=[response objectForKey:@"return"];
    NSString *tempString1=[returnDataStr stringWithoutESCCharater];
    NSDictionary *returnDataDic = [tempString1 objectFromJSONString];
    
    
    NSString *errcode = [returnDataDic valueForKey:@"err_code"];
    NSDictionary *returnDic = [[NSDictionary alloc]init];
    
//    id datastr = [[GSNetService sharedInstance]decDESString:dataString];
//    returnDic = [datastr objectFromJSONString];
  
    //    id data = nil;
    if (![errcode isEqualToString:@"0000"]) {
      NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
        
        NSString *error = @"网关错误";
        [userdefault setValue:@"gateway" forKey:@"errorcode"];
        [userdefault setValue:[returnDataDic valueForKey:@"err_msg"] forKey:@"errortxt"];
        [userdefault synchronize];
        return userdefault;
    }
    
     id data=[returnDataDic objectForKey:@"param"];
    
    if (![data isKindOfClass:[NSDictionary class]]) {
        if ([data isKindOfClass:[NSString class]]) {
            return [NSDictionary dictionaryWithObject:@"server_Return_Message"];
        }
        return data;
    }
    data=[data objectForKey:@"returnData"];
    if ([data isKindOfClass:[NSString class]]) {
        return [NSDictionary dictionaryWithObject:@"server_Return_Message"];
    }
    
    //
    return data;
}


-(void)sendMsg:(NSMutableDictionary*)prama toServerOnFormName:(NSString*)formName withDelegate:(id)delegate{
    
    
    //NSLog(@"outer sendMsg");
    [self sendMsg2:prama toServerOnFormName:formName withDelegate:delegate userNameRequired:YES userPasswordRequired:YES customerIDRequired:NO];
}



-(void)sendMsg:(NSMutableDictionary*)prama toServerOnFormName:(NSString*)formName withDelegate:(id)delegate userNameRequired:(BOOL)userNameRequired userPasswordRequired:(BOOL)userPasswordRequired customerIDRequired:(BOOL)customerIDRequired{
    //NSLog(@"inner sendMsg");
    if (delegate) {
        _delegate=delegate;
    }
    NSString *userName;
    NSString *password;
    if (userNameRequired) {
        userName=USER;
    }
    if (userPasswordRequired) {
        password=PASSWORD;
    }
    if (customerIDRequired) {
        NSString *customerID=@"D44_70_RD_CUST_ID";
    }
    //old  CPSServerImplService *webService=[CPSServerImplService service];
    CPSServerImplService *webService=[CPSServerImplService  serviceWithUsername:userName andPassword: password  ];
    
    webService.requestTimeout=TIMEOUT/1000;
   NSString *jsonStr=[prama JSONString];
    
    if (_delegate&&[_delegate respondsToSelector:@selector(metaMsgSentToServer:)]) {
        [_delegate metaMsgSentToServer:jsonStr];
    }
    self.lastFormName=[NSString stringWithString:formName];
    //NSLog(@"formName captured:%@",_lastFormName);
   // NSLog(@"jsonStr =%@",jsonStr);
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = true;
    [webService invoke:self action:@selector(serviceCallback:) arg0:jsonStr];
    
}



-(void)sendMsg2:(NSMutableDictionary*)prama toServerOnFormName:(NSString*)formName withDelegate:(id)delegate userNameRequired:(BOOL)userNameRequired userPasswordRequired:(BOOL)userPasswordRequired customerIDRequired:(BOOL)customerIDRequired{
    //NSLog(@"inner sendMsg");
    if (delegate) {
        _delegate=delegate;
    }
    NSString *userName;
    NSString *password;
    if (userNameRequired) {
        userName=USER;
    }
    if (userPasswordRequired) {
        password=PASSWORD;
    }
    if (customerIDRequired) {
        NSString *customerID=@"D44_70_RD_CUST_ID";
    }
    //old  CPSServerImplService *webService=[CPSServerImplService service];
    CPSServerImplService *webService=[CPSServerImplService  serviceWithUsername:userName andPassword: password  ];
    
    webService.requestTimeout=TIMEOUT/1000;
    
    NSString *jsonStr=[prama JSONString];
//    NSLog(@"formnsme[%@], jsonstr:[%@]",formName,jsonStr);
    if (_delegate&&[_delegate respondsToSelector:@selector(metaMsgSentToServer:)]) {
        [_delegate metaMsgSentToServer:jsonStr];
    }
    self.lastFormName=[NSString stringWithString:formName];
    //NSLog(@"formName captured:%@",_lastFormName);
   
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = true;
    [webService invoke:self  action:@selector(serviceCallback:) arg0:jsonStr];
    
    
}


//-(void)requestTimeOut:(NSInteger)timeoutInSeconds{
//    staticRequestTimeout=timeoutInSeconds;
//}

#pragma mark - netService callBack

-(void)serviceCallback:(id)response{
    
    //NSLog(@"response:%@",response);
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = false;

    if (_delegate) {
        //NSLog(@"_delegate exist");
        if ([_delegate respondsToSelector:@selector(metaMsgReceivedFromServer:)]) {
            [_delegate metaMsgReceivedFromServer:response];
        }
        if ([response isKindOfClass:[NSError class]]) {
            if ([_delegate respondsToSelector:@selector(netServiceError:)]) {
                
                //-1005
            // NSError* error = [NSError errorWithDomain:@"SoapRequest" code:400 userInfo: [NSDictionary dictionaryWithObjectsAndKeys: @"net cound not connect", NSLocalizedDescriptionKey,nil]];
                
                
                
                NSLog(@"GSNetService serviceCallback:\n%@",[response userInfo]);
                [_delegate netServiceError:response];
            }
        }else if([self serverReturnError:response])
        {
            if ([_delegate respondsToSelector:@selector(netServiceError:)]) {
                NSMutableDictionary *serverReturnDic=[NSMutableDictionary dictionaryWithDictionary:response];
                [serverReturnDic setValue:_lastFormName forKey:FORM_NAME_KEY];//添加接口号
                NSString *faultString = [serverReturnDic valueForKey:@"faultstring"];
                if (faultString) {
                    [serverReturnDic setValue:faultString forKey:@"faultString"];
                }
                NSError *error=[NSError errorWithDomain:@"服务器异常" code:0 userInfo:serverReturnDic];
                NSLog(@"netService Error Occured:\n%@",[error userInfo]);
                
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults  setValue:ERROR_SERVICE_IN_ERROR forKey:@"errorcode"];
                [userDefaults  setValue:ERROR_TEXT_SERVICE_FAILED forKey:@"errortxt"];
                [userDefaults synchronize];
                
                [_delegate netServiceError:error];
            }
        }
        else
        {
            //id returnData=[self parseOutReturnDataForNew:response];
            
            
            
            //NSLog(@"netServiceReturnData implented");
            if ([_delegate respondsToSelector:@selector(netServiceReturnData:)]) {
                NSMutableDictionary *finalDic=[NSMutableDictionary dictionaryWithDictionary:response];
                if (_lastFormName!=nil) {
                    [finalDic setObject:_lastFormName forKey:@"formName"];
                }
               // NSLog(@"returnBackData=%@---->%@",_lastFormName,finalDic);
                [_delegate netServiceReturnData:finalDic];
            }
        }
    }
}
//业务数据加密
-(NSString*)encDESString:(NSString*)jsonStr{

    NSString *EncryptKey = @"12345678";//@"A-ENCRYPT_KEY";//底座加密密钥
    return [jsonStr DESEncrypt:EncryptKey];
}
//后台数据返回解密
-(id)decDESString:(NSString*)response{
    NSString *EncryptKey = @"12345678";//@"A-ENCRYPT_KEY";//底座加密密钥
    NSString *turnString = [response stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *removeString = [turnString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    id datastr;
//#ifdef SIMULATE_DATA
//    datastr= removeString;
//#else
    datastr= [removeString DESDecrypt:EncryptKey];
//#endif
    
    NSLog(@"dataStr %@",datastr);
    return response;
}
-(BOOL)serverReturnError:(id)response{
    BOOL errorOccured=NO;
    if ([response isKindOfClass:[NSDictionary class]]) {
        if ([response objectForKey:@"faultcode"]) {
            errorOccured=YES;
        }
    }else
        errorOccured=NO;
    return errorOccured;
}
@end
