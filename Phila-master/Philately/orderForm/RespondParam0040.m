
#import "RespondParam0040.h"
@implementation RespondParam0040
/* 最大记录数 备注:*/
@synthesize totalNum;
/* 返回的记录数 备注:循环域开始*/
@synthesize recordNum;
/* 订单号 备注:*/
@synthesize orderNo;
/* 业务代号 备注:*/
@synthesize busiNo;
/* 订单总金额 备注:*/
@synthesize orderAmt;
/* 下单日期 备注:格式:yyyymmdd*/
@synthesize bookDate;
/* 支付状态 备注:*/
@synthesize payStatus;
/* 处理状态 备注:*/
@synthesize dealStatus;
/* 渠道代号 备注:*/
@synthesize channelNo;
/* 换货状态 备注:*/
@synthesize isReplacing;
/* 交易金额（多退少补差价金额） 备注:*/
@synthesize changeAmount;
/* 补款状态 备注:*/
@synthesize changeStatus;
/* 是否多退少补 备注:*/
@synthesize changeType;

/* 返回的记录数 备注:循环域结束*/



/* 自提码 备注:2015/11/10新增*/
@synthesize toTheCode;
/* 店铺名称 备注:2015/11/10新增*/
@synthesize sellerName;

/* 商品代号 备注:2015/11/10新增*/
@synthesize merchID;
/* 关联订单 备注:2015/11/10新增*/
@synthesize linkOrderNo;
/* 商品类别代号 备注:2015/11/10新增*/
@synthesize merchType;
/* 商品名称 备注:2015/11/10新增*/
@synthesize merchName;
/* 图片URL（小图） 备注:2015/11/10新增*/
@synthesize merchNumber;
@synthesize merchPicID;
/* 商品规格 备注:2015/11/10新增 如：单套、四方连 规格代号以接口下发为准*/
@synthesize normsType;
/* 商品规格名称 备注:2015/11/10新增*/
@synthesize normsName;
/* 规格单价 备注:2015/11/10新增*/
@synthesize normsPrice;


@synthesize products;
@end

