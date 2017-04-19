//
//  UploadFile.h
//  myFirstApp
//
//  Created by Mirror on 15/8/6.
//  Copyright (c) 2015年 Mirror. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UploagFileDelegate <NSObject>

//业务请求返回错误
-(void)serviceInvokerError:(NSString*)msgReturn;

//业务请求返回数据
-(void)serviceInvokerReturnData:(NSString*)msgReturn;

@end

@interface UploadFile : NSObject
@property(nonatomic,retain)id<UploagFileDelegate>delegate;

- (void)uploadFileWithURL:(NSURL *)url data:(NSData *)data;
@end
