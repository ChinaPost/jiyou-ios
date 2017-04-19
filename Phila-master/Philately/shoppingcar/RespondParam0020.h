


#import <Foundation/Foundation.h>
/*会员已购商品查询0020*/
@interface RespondParam0020:NSObject
/* 返回的记录数 备注:循环域开始*/
@property ( nonatomic) int recordNum;
/* 商品规格 备注:单张、四方连*/
@property ( nonatomic) NSString *merchNorms;
/* 已购数量 备注:*/
@property ( nonatomic) int buyNum;
/* 库存数量 备注:*/
@property ( nonatomic) int stockNum;
/* 限购数量 备注:*/
@property ( nonatomic) int limitNum;
/* 返回的记录数 备注:循环域结束*/
//@property ( nonatomic) int recordNum;
@end


