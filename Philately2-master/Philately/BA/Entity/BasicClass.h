//
//  BasicClass.h
//  Philately
//
//  Created by Mirror on 15/7/10.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreImage/CoreImage.h>
#import <UIKit/UIKitDefines.h>
#import <UIKit/UIColor.h>
#import <UIKit/UIGeometry.h>
#import <UIKit/UIImage.h>
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>

@interface BasicClass : NSObject

+ (BOOL)checkUserIdCard: (NSString *) idCard;

//md5加密
+ (NSString *)md5Digest:(NSString *)str;
//计算图片的大小
+ (long)imgSize:(UIImage*)img;

//手机号码验证
- (BOOL)validateMobile:(NSString *)mobileNum;
//判断uiimage 图片的格式
+(NSString *)typeForImageData:(NSData *)data;
//压缩图片
+(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

//压缩图片 到指定大小
+ (UIImage*)scaleImage:(UIImage *)image toSize:(CGSize)targetSize;

@end
 