


#import <Foundation/Foundation.h>
/*商品详情0026*/
@interface RespondParam0026:NSObject
/* 业务代号 备注:*/
@property ( nonatomic) NSString *busiNo;
/* 商品代号 备注:*/
@property ( nonatomic) NSString *merchID;
/* 商品类别代号 备注:*/
@property ( nonatomic) NSString *merchType;
/* 商品名称 备注:*/
@property ( nonatomic) NSString *merchName;
/* 商品状态 备注:内容待定*/
@property ( nonatomic) NSString *merchStatus;
/* 商品内部编号 备注:*/
@property ( nonatomic) NSString *merchInterNum;
/* 商品销售价格 备注:*/
@property ( nonatomic) float merchPrice;

@property ( nonatomic) int curRepertory;//库存数量
/* 上架机构 备注:*/
@property ( nonatomic) NSString *brchNo;
/* 商品简单描述 备注:*/
@property ( nonatomic) NSString *merchDesc;
/* 商品描述（URL） 备注:*/
@property ( nonatomic) NSString *merchURL;
/* 商品销售属性 备注:预售、销售等*/
@property ( nonatomic) NSString *merchSaleType;
/* 志号编号（专业编号） 备注:*/
@property ( nonatomic) NSString *professionNum;
/* 发行日期 备注:格式：yyyymmdd*/
@property ( nonatomic) NSString *launchDate;
/* 当前商品所属销售阶段 备注:针对新邮业务：以旧换新阶段、增量阶段*/
@property ( nonatomic) NSString *saleStage;
/* 是否实名验证商品 备注:0：需要
1：不需要*/
@property ( nonatomic) NSString *needAutonym;
/* 是否手机验证码商品 备注:0：需要
1：不需要*/
@property ( nonatomic) NSString *needVerification;
/* 包括图片数量 备注:循环域开始*/
@property ( nonatomic) int picNum;
/* 图片ID 备注:*/
@property ( nonatomic) NSString *merchPicID;
/* 图片属性 备注:主图、缩略图等*/
@property ( nonatomic) NSString *picType;
/* 尺寸类型 备注:小、中、大*/
@property ( nonatomic) NSString *sizeType;
/* 图片顺序号 备注:*/
@property ( nonatomic) int picIndex;
/* 包括图片数量 备注:循环域结束*/
//@property ( nonatomic) int picNum;
/* 包括商品规格数量 备注:循环域开始*/
@property ( nonatomic) int merchNormsNum;
/* 商品规格 备注:单张、四方连*/
@property ( nonatomic) NSString *normsType;
@property ( nonatomic) NSString *normsName;

/* 模式单价 备注:*/
@property ( nonatomic) float normsPrice;
/* 限购数量 备注:*/
@property ( nonatomic) int limitNum;
/* 获取积分 备注:*/
@property ( nonatomic) int gainScore;
/*购买本商品所需最低积分*/
@property ( nonatomic) int leastScore;
/*扣除积分*/
@property ( nonatomic) int deductScore;

/* 包括商品规格数量 备注:循环域结束*/
//@property ( nonatomic) int merchNormsNum;
/* 商品销售时间属性数量 备注:循环域开始*/
@property ( nonatomic) int saleTimeNum;
/* 时间类型 备注:销售时间、以旧换新时间、增量时间*/
@property ( nonatomic) NSString *saleTimeType;
/* 起始时间 备注:格式：yymmddhhmmss*/
@property ( nonatomic) NSString *startTime;
/* 截止时间 备注:*/
@property ( nonatomic) NSString *endTime;
/* 商品销售时间属性数量 备注:循环域结束*/
//@property ( nonatomic) int saleTimeNum;


@property ( nonatomic) bool *isCheck;
@property ( nonatomic) int checkNum;


@end


