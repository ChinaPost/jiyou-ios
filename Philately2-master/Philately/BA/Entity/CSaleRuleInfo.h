//
//  CSaleRuleInfo.h
//  Philately
//
//  Created by gdpost on 15/8/27.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSaleRuleInfo : NSObject
{
    NSMutableArray  *strDefMerchID;  //当前默认选中的商品编号
    NSMutableArray  *strReqMerchID;  //必选框/折类型对应的商品编号，没有必填则为空
    bool    bIsLessSelOne;  //框/折是否至少选择一个， true:是 false:否
}
@property(nonatomic)NSMutableArray  *strDefMerchID;  //当前默认选中的商品编号
@property(nonatomic)NSMutableArray  *strReqMerchID;  //必选框/折类型对应的商品编号，没有必填则为空
@property(nonatomic)bool    bIsLessSelOne;  //框/折是否至少选择一个， true:是 false:否

-(void)getSaleRuleInfo:(NSMutableArray*)merchID withGxhBiaozhi:(NSMutableArray*)gxhBiaozhi withSaleRule:(NSString*)gxhSaleRule;
@end
