//
//  RespondParam0050.h
//  Philately
//
//  Created by Mirror on 15/7/21.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RespondParam0050 : NSObject

@property (nonatomic)int recordNum;
@property (nonatomic)NSString* shoppingCartID;
@property (nonatomic)NSString* busiNo;
@property (nonatomic)NSString* merchID;
@property (nonatomic)NSString* merchPicID;
@property (nonatomic)NSString* merchName;
@property (nonatomic)NSString* brchNo;
@property (nonatomic)NSString* normsType;
@property (nonatomic)NSString* buyPrice;
@property (nonatomic)NSString* buyNum;
@property (nonatomic)NSString* limitBuy;
@property (nonatomic)NSString* gmtCreate;
@property (nonatomic)NSString* gmtModify;
@property (nonatomic)NSString* needAutonym;
@property (nonatomic)NSString* needVerification;
@property (nonatomic)NSString* canPost;



@end

@interface SendParam0050 : NSObject

@property (nonatomic)NSString* cstmNo;
@property (nonatomic)NSString* cstmName;
@property (nonatomic)NSString* merchID;
@property (nonatomic)NSString* templateId;//模板Id
@property (nonatomic)NSString* isEt;//是否有边饰
@property (nonatomic)NSString* sxNo;//生肖编号
@property (nonatomic)NSString* xzNo;//星座编号
@property (nonatomic)NSString* gxhMerchNum;//购买数量

@property (nonatomic)NSString*picNum;//上传的图片数量
@property (nonatomic)NSMutableArray* contentId;//附图id 数组
@property (nonatomic)NSMutableArray* original;//图片URL地址 数组
@property (nonatomic)NSMutableArray* type;//图片类型 数组


@property (nonatomic)NSString* recordNum;//规格循环域 数量
@property (nonatomic)NSMutableArray* normsType;//规格
@property (nonatomic)NSMutableArray* merchNum;//规格数量

@property (nonatomic)NSString* addMerchNum;//加入购物车的商品数量
@property (nonatomic)NSMutableArray* gxhMerchID;//商品代号 数组
@property (nonatomic)NSMutableArray* gxhBiaozhi;//个性化标志 数组
@end



