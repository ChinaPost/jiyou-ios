


#import <Foundation/Foundation.h>
/*收货地址查询0011*/
@interface RespondParam0011:NSObject
/* 最大记录数 备注:*/
@property ( nonatomic) int totalNum;
/* 本次返回的记录数 备注:循环域开始*/
@property ( nonatomic) int recordNum;
/* 收货地址编号 备注:*/
@property ( nonatomic) NSString *addressID;
/* 收货人姓名 备注:*/
@property ( nonatomic) NSString *recvName;


/* 省份代号 备注:*/
@property ( nonatomic) NSString *provCode;
/* 市代号 备注:*/
@property ( nonatomic) NSString *cityCode;
/* 县代号 备注:*/
@property ( nonatomic) NSString *countCode;
/* 详细地址 备注:*/
@property ( nonatomic) NSString *detailAddress;
/* 收件手机号码 备注:*/
@property ( nonatomic) NSString *mobileNo;
/* 邮编 备注:*/
@property ( nonatomic) NSString *postCode;
/* 是否默认地址 备注:0：是
其它：否*/
@property ( nonatomic) NSString *isDefaultAddress;
/* 本次返回的记录数 备注:循环域结束*/
//@property ( nonatomic) int recordNum;
@end


