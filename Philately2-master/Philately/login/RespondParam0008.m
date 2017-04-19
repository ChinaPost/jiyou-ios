
#import "RespondParam0008.h"
@implementation RespondParam0008
/* 用户头像图片ID 备注:用户头像URL地址*/
@synthesize userPicID;
/* 用户名 备注:*/
@synthesize userName;
/* 手机号码 备注:注册手机号码*/
@synthesize mobileNo;
@synthesize homePhone;
/* 性别 备注:0：男
1：女*/
@synthesize userSex;
/* 邮箱 备注:*/
@synthesize email;
/* 会员积分 备注:*/
@synthesize cstmScore;
/* 是否历史集邮统版会员 备注:0：是
1：否*/
@synthesize isStampMember;
/* 是否实名认证 备注:0：是
1：否*/
@synthesize isAutonym;
/* 姓名 备注:未经过实名验证的会员这几项为空*/
@synthesize cstmName;
/* 身份证号码 备注:*/
@synthesize certNo;
/* 认证手机号码 备注:*/
@synthesize verifiMobileNo;
/* 省份代号 备注:2015/6/17 增加*/
@synthesize provCode;
/* 市代号 备注:2015/6/17增加*/
@synthesize cityCode;
/* 县代号 备注:2015/6/17增加*/
@synthesize countCode;
/* 详细地址 备注:2015/6/17增加*/
@synthesize detailAddress;
/* 邮编 备注:2015/6/17增加*/
@synthesize postCode;
/* 营业员联系方式（营业员编号） 备注:2015/6/17 增加*/
@synthesize brchMobNum;
/* 新邮自提机构代码 备注:2015/6/17增加*/
@synthesize sinceBrchNo;
/* 零售自提机构代码 备注:2015/6/17增加*/
@synthesize saleBrchNo;
/* 关联终端数量 备注:循环域开始*/
@synthesize termNum;
/* 关联终端类型 备注:01：adnroid
02：ios
03：微信*/
@synthesize termType;
/* 关联终端编号 备注:微信类型的终端编号为Openid*/
@synthesize termNo;
/* 关联终端数量 备注:循环域结束*/
//@synthesize termNum;
@end

