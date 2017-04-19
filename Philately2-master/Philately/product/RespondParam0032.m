
#import "RespondParam0032.h"
@implementation RespondParam0032
/* 返回的记录数 备注:循环域开始*/
@synthesize recordNum;
/* 购物车代号 备注:*/
@synthesize shoppingCartID;
/* 业务代号 备注:*/
@synthesize busiNo;
/* 商品代号 备注:*/
@synthesize merchID;
/* 图片URL 备注:*/
@synthesize merchPicID;
/* 商品名称 备注:*/
@synthesize merchName;
/* 所属机构 备注:店铺名称*/
@synthesize brchNo;
/* 商品规格 备注:20：单张
30：四方连*/
@synthesize normsType;

@synthesize  normsName;
/* 购买价格 备注:*/
@synthesize buyPrice;
/* 购买价格 备注:*/
@synthesize buyNum;

/* 购买价格 备注:*/
@synthesize limitBuy;

/* 创建时间 备注:*/
@synthesize gmtCreate;
/* 修改时间 备注:*/
@synthesize gmtModify;
/* 是否实名验证商品 备注:2015/6/30新增：
0：需要
1：不需要*/
@synthesize needAutonym;
/* 是否手机验证码商品 备注:2015/6/30新增：
0：需要
1：不需要*/
@synthesize needVerification;
/* 是否支持寄递 备注:2015/6/30新增：
0：支持
1：不支持*/
@synthesize canPost;

/*店铺名称*/
@synthesize sellerName;
/*商品销售属性  0预售 1销售 2不在销售期  3无货*/
@synthesize merchSaleType;

/* 返回的记录数 备注:循环域结束*/
//@synthesize record Num;

@synthesize  types;

@synthesize isProductCheck;

@end


@implementation ProductType


/* 商品规格 备注:20：单张
 30：四方连*/
@synthesize  normsType;

@synthesize normsName;
/* 购买价格 备注:*/
@synthesize  buyPrice;

@synthesize  checkNum;

@synthesize  limitBuy;

/* 购物车代号 备注:*/
@synthesize  shoppingCartID;

@synthesize isCheck;

@end

