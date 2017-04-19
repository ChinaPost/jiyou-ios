//
//  GSNetService.h
//  iFreePoster
//
//  Created by Yangtsing.Zhang on 13-7-23.
//  Copyright (c) 2013年 URoad. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol GSNetServiceDelegate;

@interface GSNetService : NSObject
+(GSNetService*) sharedInstance;

@property (nonatomic,strong) id<GSNetServiceDelegate> delegate;



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



@end




@protocol GSNetServiceDelegate <NSObject>

@required

//业务请求返回错误
-(void)netServiceError:(NSError*)error;

//业务请求返回数据
-(void)netServiceReturnData:(NSDictionary*)data;

@optional



@end
