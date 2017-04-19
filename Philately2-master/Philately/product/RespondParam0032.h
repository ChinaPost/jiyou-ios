


#import <Foundation/Foundation.h>
/*购物车查询0032*/
@interface RespondParam0032:NSObject
/* 返回的记录数 备注:循环域开始*/
@property ( nonatomic) int recordNum;
/* 购物车代号 备注:*/
@property ( nonatomic) NSString *shoppingCartID;
/* 业务代号 备注:*/
@property ( nonatomic) NSString *busiNo;
/* 商品代号 备注:*/
@property ( nonatomic) NSString *merchID;
/* 图片URL 备注:*/
@property ( nonatomic) NSString *merchPicID;
/* 商品名称 备注:*/
@property ( nonatomic) NSString *merchName;
/* 所属机构 备注:店铺名称*/
@property ( nonatomic) NSString *brchNo;
/* 商品规格 备注:20：单张
30：四方连*/
@property ( nonatomic) NSString *normsType;
@property ( nonatomic) NSString *normsName;

/* 购买价格 备注:*/
@property ( nonatomic) float buyPrice;


@property ( nonatomic) int buyNum;

/* 购买价格 备注:*/
@property ( nonatomic) int  limitBuy;

/* 创建时间 备注:*/
@property ( nonatomic) NSString *gmtCreate;
/* 修改时间 备注:*/
@property ( nonatomic) NSString *gmtModify;
/* 是否实名验证商品 备注:2015/6/30新增：
0：需要
1：不需要*/
@property ( nonatomic) NSString *needAutonym;
/* 是否手机验证码商品 备注:2015/6/30新增：
0：需要
1：不需要*/
@property ( nonatomic) NSString *needVerification;
/* 是否支持寄递 备注:2015/6/30新增：
0：支持
1：不支持*/
@property ( nonatomic) NSString *canPost;

/*店铺名称*/
@property ( nonatomic) NSString *sellerName;
/*商品销售属性  0预售 1销售 2不在销售期  3无货*/
@property ( nonatomic) NSString *merchSaleType;

/* 返回的记录数 备注:循环域结束*/
//@property ( nonatomic) int recordNum;

@property (strong,nonatomic) NSMutableArray *types;//ProductType

@property (nonatomic) bool isProductCheck;


@end


@interface ProductType : NSObject

/* 商品规格 备注:20：单张
 30：四方连*/
@property ( nonatomic) NSString *normsType;

@property ( nonatomic) NSString *normsName;
/* 购买价格 备注:*/
@property ( nonatomic) float buyPrice;

@property (nonatomic) int checkNum;

@property ( nonatomic) int  limitBuy;

@property (nonatomic) bool isCheck;

/* 购物车代号 备注:*/
@property ( nonatomic) NSString *shoppingCartID;

@end


