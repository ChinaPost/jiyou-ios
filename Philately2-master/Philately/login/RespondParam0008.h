


#import <Foundation/Foundation.h>
/*会员资料标准查询0008*/
@interface RespondParam0008:NSObject
/* 用户头像图片ID 备注:用户头像URL地址*/
@property ( nonatomic) NSString *userPicID;
/* 用户名 备注:*/
@property ( nonatomic) NSString *userName;
/* 手机号码 备注:注册手机号码*/
@property ( nonatomic) NSString *mobileNo;
@property (nonatomic) NSString *homePhone;
/* 性别 备注:0：男
1：女*/
@property ( nonatomic) NSString *userSex;
/* 邮箱 备注:*/
@property ( nonatomic) NSString *email;
/* 会员积分 备注:*/
@property ( nonatomic) int cstmScore;
/* 是否历史集邮统版会员 备注:0：是
1：否*/
@property ( nonatomic) NSString *isStampMember;
/* 是否实名认证 备注:0：是
1：否*/
@property ( nonatomic) NSString *isAutonym;
/* 姓名 备注:未经过实名验证的会员这几项为空*/
@property ( nonatomic) NSString *cstmName;
/* 身份证号码 备注:*/
@property ( nonatomic) NSString *certNo;
/* 认证手机号码 备注:*/
@property ( nonatomic) NSString *verifiMobileNo;
/* 省份代号 备注:2015/6/17 增加*/
@property ( nonatomic) NSString *provCode;
/* 市代号 备注:2015/6/17增加*/
@property ( nonatomic) NSString *cityCode;
/* 县代号 备注:2015/6/17增加*/
@property ( nonatomic) NSString *countCode;
/* 详细地址 备注:2015/6/17增加*/
@property ( nonatomic) NSString *detailAddress;
/* 邮编 备注:2015/6/17增加*/
@property ( nonatomic) NSString *postCode;
/* 营业员联系方式（营业员编号） 备注:2015/6/17 增加*/
@property ( nonatomic) NSString *brchMobNum;
/* 新邮自提机构代码 备注:2015/6/17增加*/
@property ( nonatomic) NSString *sinceBrchNo;
/* 零售自提机构代码 备注:2015/6/17增加*/
@property ( nonatomic) NSString *saleBrchNo;
/* 关联终端数量 备注:循环域开始*/
@property ( nonatomic) int termNum;
/* 关联终端类型 备注:01：adnroid
02：ios
03：微信*/
@property ( nonatomic) NSString *termType;
/* 关联终端编号 备注:微信类型的终端编号为Openid*/
@property ( nonatomic) NSString *termNo;
/* 关联终端数量 备注:循环域结束*/
//@property ( nonatomic) int termNum;
@end


