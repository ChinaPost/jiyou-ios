//
//  UploadFile.m
//  myFirstApp
//
//  Created by Mirror on 15/8/6.
//  Copyright (c) 2015年 Mirror. All rights reserved.
//

#import "UploadFile.h"
#import <PublicFramework/MsgReturn.h>
#import <PublicFramework/ErrorMsg.h>

@implementation UploadFile
// 拼接字符串
static NSString *boundaryStr = @"--";   // 分隔字符串
static NSString *randomIDStr;           // 本次上传标示字符串
static NSString *uploadID;              // 上传(php)脚本中，接收文件字段

- (instancetype)init
{
    self = [super init];
    if (self) {
        randomIDStr = @"itcast";
        uploadID = @"uploadFile";
    }
    return self;
}

#pragma mark - 私有方法
- (NSString *)topStringWithMimeType:(NSString *)mimeType uploadFile:(NSString *)uploadFile
{
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendFormat:@"%@%@\n", boundaryStr, randomIDStr];
    [strM appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\n", uploadID, uploadFile];
    [strM appendFormat:@"Content-Type: %@\n\n", mimeType];
    
    NSLog(@"%@", strM);
    return [strM copy];
}

- (NSString *)bottomString
{
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendFormat:@"%@%@\n", boundaryStr, randomIDStr];
    [strM appendString:@"Content-Disposition: form-data; name=\"submit\"\n\n"];
    [strM appendString:@"Submit\n"];
    [strM appendFormat:@"%@%@--\n", boundaryStr, randomIDStr];
    
    NSLog(@"%@", strM);
    return [strM copy];
}

#pragma mark - 上传文件
- (void)uploadFileWithURL:(NSURL *)url data:(NSData *)data
{
    // 1> 数据体
//    NSString *topStr = [self topStringWithMimeType:@"image/png" uploadFile:@"1.png"];
//    NSString *bottomStr = [self bottomString];
    
    NSMutableData *dataM = [NSMutableData data];
//    [dataM appendData:[topStr dataUsingEncoding:NSUTF8StringEncoding]];
    [dataM appendData:data];
//    [dataM appendData:[bottomStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 1. Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:30.0f];
    
    // dataM出了作用域就会被释放,因此不用copy
    request.HTTPBody = dataM;
    
    // 2> 设置Request的头属性
    request.HTTPMethod = @"POST";
    
//    // 3> 设置Content-Length
//    NSString *strLength = [NSString stringWithFormat:@"%ld", (long)dataM.length];
//    [request setValue:strLength forHTTPHeaderField:@"Content-Length"];
//    
//    // 4> 设置Content-Type
//    NSString *strContentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", randomIDStr];
//    [request setValue:strContentType forHTTPHeaderField:@"Content-Type"];
    
    // 3> 连接服务器发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
            
            
            //交易失败  回调
            MsgReturn *msgReturn=[[MsgReturn alloc ] init ];
            msgReturn.errorCode=ERROR_FAILED;
            msgReturn.errorDesc=@"文件上传失败";
            msgReturn.formName=@"fileUp";
            
            [self.delegate serviceInvokerError:msgReturn];
            
        }else{
            
            NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
            
            NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            NSLog(@"%@", responseString);
            //                                   NSDictionary *returnDataDic=[self jsonString2Dic:[responseString base64DecodedData] ];
            NSDictionary *returnDataDic=[self jsonString2Dic:[responseString dataUsingEncoding:NSUTF8StringEncoding] ];
            
            
            NSString *code = [returnDataDic objectForKey:@"returnCode"];
            
            if ([code isEqualToString:@"0000"]) {
                
                NSString *desc = [returnDataDic objectForKey:@"returnDesc"];
                NSMutableDictionary *date = [returnDataDic objectForKey:@"returnDate"];
                
                NSString *imageId = [date objectForKey:@"imageId"];
                
                
                
                
                //交易成功  回调
                MsgReturn *msgReturn=[[MsgReturn alloc ] init ];
                msgReturn.errorCode=ERROR_SUCCESS;
                msgReturn.errorDesc=@"文件上传成功";
                msgReturn.formName=@"fileUp";
                msgReturn.map=date;
                [self.delegate serviceInvokerReturnData:msgReturn];
            }else
            {
                //交易失败  回调
                MsgReturn *msgReturn=[[MsgReturn alloc ] init ];
                msgReturn.errorCode=ERROR_FAILED;
                msgReturn.errorDesc=@"文件上传失败";
                msgReturn.formName=@"fileUp";
                
                [self.delegate serviceInvokerError:msgReturn];
            }   
            
        }
    }];
}

// 将JSON串转化为字典或者数组
- (id)jsonString2Dic:(NSDate *)jsonData{
    
    //  NSData *jsonData=[jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    
    if (jsonObject != nil && error== nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
    
}

@end
