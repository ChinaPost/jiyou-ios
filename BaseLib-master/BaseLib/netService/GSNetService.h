//
//  GSNetService.h
//  iFreePoster
//
//  Created by Yangtsing.Zhang on 13-7-23.
//  Copyright (c) 2013年 URoad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GSNetService_Marco.h"
#import "NSString+GSUtil.h"
#import "Soap.h"


#undef	AS_SINGLETON
#define AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
    static dispatch_once_t once; \
    static __class * __singleton__; \
    dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
    return __singleton__; \
}

#define WEB_SERVICE_ERROR_OR_SOAPFAULT [response isKindOfClass:[NSError class]]||[response isKindOfClass:[SoapFault class]]
#define PUSH_FILE_PATH [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),@"push_info.plist"]
#define DeviceTokenStringKEY @"deviceToken"

typedef enum{
    FULL_HEIGHT,
    SMALL_HEIGTH
}adViewSizeType;

@protocol GSDrawbackDelegate;
@protocol GSNetServiceDelegate;


@interface GSNetService : NSObject
AS_SINGLETON(GSNetService)
@property (nonatomic,strong) id<GSDrawbackDelegate,GSNetServiceDelegate> delegate;

@property (nonatomic,assign,setter = requestTimeOut:) NSInteger requestTimeout;
@property (nonatomic,strong) NSString *lastFormName;
@property (strong) NSString * errorcode;
@property (strong) NSString * errortxt;
//@property (nonatomic,assign) BOOL testValue;//lib变化检测

-(NSArray*)adViewsFromServerWithSizeType:(adViewSizeType)type;

/**
 *	将数据字典和接口号 封装成json格式的字符串
 *
 *	@param	param	数据字典
 *	@param	formName	报文接口号
 *
 *	@return	json格式的字符串
 */
+(void)encapsulateHead:(NSMutableDictionary*)param FormName:(NSString*)formName;

/**
 *	后台返回数据方法
 *
 *	@param	response	id类型数据
 *
 *	@return	id类型数据
 */
-(id)parseOutReturnData:(id)response; //可能返回字符串也可能返回字典

//+(void)sendMsg:(NSMutableDictionary*)param toServerOnFormName:(NSString*)formName
//withTarget:(id)target action:(SEL)selector userNameRequired:(BOOL)userNameRequired userPasswordRequired:(BOOL)userPasswordRequired customerIDRequired:(BOOL)customerIDRequired;

//+(void)sendMsg:(NSMutableDictionary *)param toServerOnFormName:(NSString *)formName withTarget:(id)target action:(SEL)selector;

/**
 *	报文发送方法，基于-(void)sendMsg:(NSMutableDictionary*)prama toServerOnFormName:(NSString*)formName withDelegate:(id)delegate userNameRequired:(BOOL)userNameRequired userPasswordRequired:(BOOL)userPasswordRequired customerIDRequired:(BOOL)customerIDRequired，prama、formName、delegete为下列参数。其他布尔参数均为NO;
 *
 *	@param	prama	数据字典
 *	@param	formName	接口号
 *	@param	delegate	委托
 */
-(void)sendMsg:(NSMutableDictionary*)prama toServerOnFormName:(NSString*)formName withDelegate:(id)delegate;

/**
 *	报文发送方法
 *
 *	@param	prama	报文数据字典
 *	@param	formName	接口号
 *	@param	delegate	委托
 *	@param	userNameRequired	是否需要用户名
 *	@param	userPasswordRequired	是否需要密码
 *	@param	customerIDRequired	是否需要客户代号
 */
-(void)sendMsg:(NSMutableDictionary*)prama toServerOnFormName:(NSString*)formName withDelegate:(id)delegate userNameRequired:(BOOL)userNameRequired userPasswordRequired:(BOOL)userPasswordRequired customerIDRequired:(BOOL)customerIDRequired;

/**
 *	设置超时时间
 *
 *	@param	timeoutInSeconds	时间
 */
-(void)requestTimeOut:(NSInteger)timeoutInSeconds;


/**
 *  需要加密的业务参数（JSON字符串），业务需要加密的只是业务参数，即businessParam属性的值
 *
 *  @param jsonStr 需加密的业务参数
 *
 *  @return 返回加密后的字符串
 */
-(NSString*)encDESString:(NSString*)jsonStr;

/**
 *  对后台返回的加密数据进行解密
 *
 *  @param response 根据返回数据中根据data取得的加密过的数据
 *
 *  @return 解密后的字符串
 */
-(NSString*)decDESString:(NSString*)response;

@end


@protocol GSDrawbackDelegate <NSObject>

@optional
-(void)applyDrawbackResult:(id)response;

-(void)drawBackQueryResult:(id)response;

-(void)drawBackDetailQueryResult:(id)response;

@end

@protocol GSNetServiceDelegate <NSObject>

@required

//业务请求返回错误
-(void)netServiceError:(NSError*)error;

//业务请求返回数据
-(void)netServiceReturnData:(NSDictionary*)data;

@optional

//向后台发送的完整报文,debug用
-(void)metaMsgSentToServer:(NSString*)jsonStr;

//从后台返回的完整报文,debug用
-(void)metaMsgReceivedFromServer:(id)response;

@end
