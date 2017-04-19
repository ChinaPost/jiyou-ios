//
//  ProductItem.h
//  Philately
//
//  Created by Mirror on 15/7/15.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <Foundation/Foundation.h>

//换货商品
@interface ProductItem : NSObject
@property (nonatomic)NSString* merchID;//商品代号
@property (nonatomic)NSString* merchPicID;//图片URL
@property (nonatomic)NSString* merchName;//商品名称
@property (nonatomic)NSString* normsType;//商品规格
@property (nonatomic)NSString* normsPrice;//模式单价
@property (nonatomic)NSString* merchNum;//商品购买数量
@property (nonatomic)NSString* isReplace;//是否是换货商品，0否，1是
@end
