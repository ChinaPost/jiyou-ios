


#import <Foundation/Foundation.h>
/*购物车修改0034*/
@interface RespondParam0034:NSObject
/* 返回的记录数 备注:2015/7/2新增整个循环域内容：
循环域开始*/
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
/* 商品规格 备注:单张、四方连*/
@property ( nonatomic) NSString *normsType;
/* 购买价格 备注:*/
@property ( nonatomic) float buyPrice;
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
/* 返回的记录数 备注:循环域结束*/
//@property ( nonatomic) int recordNum;
@end


