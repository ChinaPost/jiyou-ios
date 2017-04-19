
#import "RespondParam0026.h"
@implementation RespondParam0026
/* 业务代号 备注:*/
@synthesize busiNo;
/* 商品代号 备注:*/
@synthesize merchID;
/* 商品类别代号 备注:*/
@synthesize merchType;
/* 商品名称 备注:*/
@synthesize merchName;
/* 商品状态 备注:内容待定  0:未审核
 1:销售中
 2:仓库中
 3:已删除
 */
@synthesize merchStatus;
/* 商品内部编号 备注:*/
@synthesize merchInterNum;
/* 商品销售价格 备注:*/
@synthesize merchPrice;
/* 上架机构 备注:*/
@synthesize brchNo;
/* 商品简单描述 备注:*/
@synthesize merchDesc;
/* 商品描述（URL） 备注:*/
@synthesize merchURL;
/* 商品销售属性 备注:预售、销售等*/
@synthesize merchSaleType;
/* 志号编号（专业编号） 备注:*/
@synthesize professionNum;
//当前库存数量
@synthesize  curRepertory;
/* 发行日期 备注:格式：yyyymmdd*/
@synthesize launchDate;
/* 当前商品所属销售阶段 备注:针对新邮业务：以旧换新阶段、增量阶段*/
@synthesize saleStage;
/* 是否实名验证商品 备注:0：需要
1：不需要*/
@synthesize needAutonym;
/* 是否手机验证码商品 备注:0：需要
1：不需要*/
@synthesize needVerification;
/* 包括图片数量 备注:循环域开始*/
@synthesize picNum;
/* 图片ID 备注:*/
@synthesize merchPicID;
/* 图片属性 备注:主图、缩略图等*/
@synthesize picType;
/* 尺寸类型 备注:小、中、大*/
@synthesize sizeType;
/* 图片顺序号 备注:*/
@synthesize picIndex;
/* 包括图片数量 备注:循环域结束*/
//@synthesize picNum;
/* 包括商品规格数量 备注:循环域开始*/
@synthesize merchNormsNum;
/* 商品规格 备注:单张、四方连*/
@synthesize normsType;

@synthesize normsName;
/* 模式单价 备注:*/
@synthesize normsPrice;
/* 限购数量 备注:*/
@synthesize limitNum;
/* 获取积分 备注:*/
@synthesize gainScore;

@synthesize leastScore;

@synthesize deductScore;

/* 包括商品规格数量 备注:循环域结束*/
//@synthesize merchNormsNum;
/* 商品销售时间属性数量 备注:循环域开始*/
@synthesize saleTimeNum;
/* 时间类型 备注:销售时间、以旧换新时间、增量时间*/
@synthesize saleTimeType;
/* 起始时间 备注:格式：yymmddhhmmss*/
@synthesize startTime;
/* 截止时间 备注:*/
@synthesize endTime;
/* 商品销售时间属性数量 备注:循环域结束*/
//@synthesize saleTimeNum;




@synthesize isCheck;
@synthesize checkNum;




@end

