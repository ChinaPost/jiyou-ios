


#import <Foundation/Foundation.h>
/*商品列表查询0025*/
@interface RespondParam0025:NSObject
/* 最大记录数 备注:*/
@property ( nonatomic) int totalNum;
/* 本次返回的记录数 备注:循环域开始*/
@property ( nonatomic) int recordNum;
/* 商品代号 备注:*/
@property ( nonatomic) NSString *merchID;
/* 商品名称 备注:*/
@property ( nonatomic) NSString *merchName;
/* 商品类别代号 备注:*/
@property ( nonatomic) NSString *merchType;
/* 商品价格 备注:*/
@property ( nonatomic) float merchPrice;
/* 图片ID 备注:*/
@property ( nonatomic) NSString *merchPicID;
@property (nonatomic) NSString *merchSaleType;
@property ( nonatomic) NSString *busiNo;
/* 本次返回的记录数 备注:循环域结束*/
//@property ( nonatomic) int recordNum;
@end


