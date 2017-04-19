


#import <Foundation/Foundation.h>
/*应用首页商品列表查询0055*/
@interface RespondParam0055:NSObject
/* 总返回的商品数量 备注:循环域开始*/
@property ( nonatomic) int recordNum;
/* 业务代号 备注:*/
@property ( nonatomic) NSString *busiNo;
/* 商品代号 备注:*/
@property ( nonatomic) NSString *merchID;
/* 商品名称 备注:*/
@property ( nonatomic) NSString *merchName;
/* 商品价格 备注:*/
@property ( nonatomic) float merchPrice;
/* 图片ID 备注:*/
@property ( nonatomic) NSString *merchPicID;

@property ( nonatomic) NSString * merchSaleType;

/* 总返回的商品数量 备注:循环域结束*/
//@property ( nonatomic) int recordNum;

@end


