
#import "RespondParam0041.h"
@implementation RespondParam0041
/* 订单号 备注:*/
@synthesize orderNo;
/* 业务代号 备注:*/
@synthesize busiNo;
/* 渠道代号 备注:*/
@synthesize channelNo;
/* 支付方式 备注:*/
@synthesize payType;
/* 下单日期 备注:*/
@synthesize bookDate;
/* 处理机构 备注:*/
@synthesize dealBrch;
/* 支付状态 备注:*/
@synthesize payStatus;
/* 处理状态 备注:*/
@synthesize dealStatus;

@synthesize sellerName;//	店铺名称	字符	100	2015/11/10新增
@synthesize subtractionPoint;//	扣除积分	浮点		2015/11/10新增
@synthesize donatePoint;//	赠送积分	浮点		2015/11/10新增
@synthesize userRemark;//	给卖家留言	字符	500	2015/11/10新增


/* 配送方式 备注:自提方式：自提网点代号 、自提码生效；
寄递方式：收件人信息 生效*/
@synthesize shipType;

@synthesize shipMode;
@synthesize shipModeName;
/* 自提网点代号 备注:*/
@synthesize brchNo;
@synthesize brchName;
@synthesize brchAddress;


/* 自提码 备注:*/
@synthesize toTheCode;
/* 收货人姓名 备注:收件人信息*/
@synthesize recvName;
/* 详细地址 备注:*/
@synthesize detailAddress;
/* 收件手机号码 备注:*/
@synthesize mobileNo;
/* 邮编 备注:*/
@synthesize postCode;
/* 订单总金额 备注:*/
@synthesize orderAmt;
/* 商品总金额 备注:*/
@synthesize merchAmt;
/* 配送费用 备注:*/
@synthesize shipFee;
/* 已付金额 备注:*/
@synthesize hasPayMoney;
/* 订单备注信息 备注:*/
@synthesize orderRemark;
/* 发票开具类型 备注:不开、个人、单位*/
@synthesize invoiceType;
/* 发票抬头 备注:当发票类型为“单位”时生效*/
@synthesize invoiceTitle;
/* 预处理单号 备注:个性化定制业务才有预处理单号*/
@synthesize prepNumber;


@synthesize isReplacing;
@synthesize changeType;
@synthesize changeAmount;
@synthesize changeStatus;
@synthesize orderOperNum;

/* 操作类型 备注:支付、取消、换货等*/
@synthesize operationType;
/* 操作截止日期 备注:*/
@synthesize operationEndDate;


@synthesize  orderLogNum;
/* 处理时间 备注:yymmddhhmmss*/
@synthesize dealTime;
/* 处理类型 备注:*/
@synthesize dealType;
/* 处理内容 备注:*/
@synthesize dealContent;
/* 处理人 备注:*/
@synthesize dealPerson;


@synthesize orderEventNum;
/* 事件类型 备注:退款、补款、摇号、换货*/
@synthesize eventType;
/* 事件状态 备注:未审核、审核通过、审核不通过等*/
@synthesize eventStatus;
/* 事件描述 备注:*/
@synthesize eventDesc;


@synthesize paySeqNum;
/* 支付流水 备注:*/
@synthesize paySeq;
/* 支付流水状态 备注:支付、退款、补款*/
@synthesize paySeqStatus;
/* 金额 备注:*/
@synthesize payMoney;
/* 流水操作状态 备注:*/
@synthesize payOperStatus;
/* 操作时间 备注:*/
@synthesize payDealTime;
/* 银行流水 备注:*/
@synthesize bankSeq;
/* 备注 备注:*/
@synthesize payRemark;
/* 子订单数量 备注:循环域开始*/
@synthesize subOrderNum;
/* 子订单号 备注:*/
@synthesize subOrderNo1;
/* 子订单状态 备注:*/
@synthesize subOrderStatus;
/* 子订单总金额 备注:*/
@synthesize subOrderAmt;
/* 商品总金额 备注:*/
@synthesize subMerchAmt;
/* 配送费用 备注:*/
@synthesize subShipFee;
/* 子订单数量 备注:循环域结束*/
//@synthesize subOrderNum;

@synthesize  subOrderLogNum;
/* 子订单号 备注:*/
@synthesize subOrderNo2;
/* 处理时间 备注:yymmddhhmmss*/
@synthesize subdealTime;
/* 处理类型 备注:*/
@synthesize subdealType;
/* 处理内容 备注:*/
@synthesize subdealContent;
/* 处理人 备注:*/
@synthesize subdealPerson;



@synthesize  subOrderLogistNum;
/* 子订单号 备注:*/
@synthesize subOrderNo3;
/* 物流公司 备注:*/
@synthesize logistCompany;
/* 物流单号 备注:yymmddhhmmss*/
@synthesize logistNum;
/* 处理时间 备注:yymmddhhmmss*/
@synthesize logistDealTime;


@synthesize merchListNum;
/* 商品代号 备注:*/
@synthesize merchID;
/* 图片ID 备注:*/
@synthesize merchPicID;
/* 商品名称 备注:*/
@synthesize merchName;
/* 商品规格 备注:*/
@synthesize normsType;
@synthesize normsName;
/* 模式单价 备注:*/
@synthesize normsPrice;
/*个性化标志*/
@synthesize gxhBiaozhi;
/* 商品购买数量 备注:*/
@synthesize merchNum;



@synthesize  logisticsNum;
@synthesize source;
@synthesize  acceptTime;
@synthesize acceptAddr;
@synthesize remark;

@end

