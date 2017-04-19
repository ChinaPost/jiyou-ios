


#import <Foundation/Foundation.h>
/*商品分类查询0024*/
@interface RespondParam0024:NSObject
/* 最大记录数 备注:*/
@property ( nonatomic) int totalNum;
/* 本次返回的记录数 备注:循环域开始*/
@property ( nonatomic) int recordNum;
/* 商品类别代号 备注:*/
@property ( nonatomic) NSString *merchType;
/* 商品类别名称 备注:*/
@property ( nonatomic) NSString *merchTypeName;
/* 本次返回的记录数 备注:循环域结束*/
//@property ( nonatomic) int recordNum;

@property (strong,nonatomic) NSString *priceLowToUp;
@property (nonatomic) BOOL priceLowToUpBool;

@end


