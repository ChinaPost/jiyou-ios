


#import <Foundation/Foundation.h>
/*订单查询0040*/
@interface RespondParam0040:NSObject
/* 最大记录数 备注:*/
@property ( nonatomic) int totalNum;
/* 返回的记录数 备注:循环域开始*/
@property ( nonatomic) int recordNum;
/* 订单号 备注:*/
@property ( nonatomic) NSString *orderNo;
/* 业务代号 备注:*/
@property ( nonatomic) NSString *busiNo;
/* 订单总金额 备注:*/
@property ( nonatomic) float orderAmt;
/* 下单日期 备注:格式:yyyymmdd*/
@property ( nonatomic) NSString *bookDate;
/* 支付状态 备注:*/
@property ( nonatomic) NSString *payStatus;
/* 处理状态 备注:*/
@property ( nonatomic) NSString *dealStatus;
/* 渠道代号 备注:*/
@property ( nonatomic) NSString *channelNo;


/* 换货状态 备注:*/
@property ( nonatomic) NSString *isReplacing;
/* 是否多退少补 备注:*/
@property ( nonatomic) NSString *changeType;
/* 交易金额（多退少补差价金额） 备注:*/
@property ( nonatomic) NSString *changeAmount;
/* 补款状态 备注:*/
@property ( nonatomic) NSString *changeStatus;



/* 返回的记录数 备注:循环域结束*/



/* 自提码 备注:2015/11/10新增*/
@property ( nonatomic) NSString *toTheCode;
/* 店铺名称 备注:2015/11/10新增*/
@property ( nonatomic) NSString *sellerName;



@property (strong,nonatomic) NSMutableArray *products;

/* 商品代号 备注:2015/11/10新增*/
@property ( nonatomic) NSString *merchID;
/* 关联订单 备注:2015/11/10新增*/
@property ( nonatomic) NSString *linkOrderNo;
/* 商品类别代号 备注:2015/11/10新增*/
@property ( nonatomic) NSString *merchType;
/* 商品名称 备注:2015/11/10新增*/
@property ( nonatomic) NSString *merchName;

@property ( nonatomic) NSString * merchNumber;//	商品数量	整形		2015/11/10新增

@property ( nonatomic) int  gxhBiaozhi;

/* 图片URL（小图） 备注:2015/11/10新增*/
@property ( nonatomic) NSString *merchPicID;
/* 商品规格 备注:2015/11/10新增 如：单套、四方连 规格代号以接口下发为准*/
@property ( nonatomic) NSString *normsType;
/* 商品规格名称 备注:2015/11/10新增*/
@property ( nonatomic) NSString *normsName;
/* 规格单价 备注:2015/11/10新增*/
@property ( nonatomic) float normsPrice;


@end


