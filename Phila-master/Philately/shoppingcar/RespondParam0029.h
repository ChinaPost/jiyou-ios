


#import <Foundation/Foundation.h>
/*可选自提网点查询0029*/
@interface RespondParam0029:NSObject
/* 最大记录数 备注:*/
@property ( nonatomic) int totalNum;
/* 本次返回的记录数 备注:循环域开始*/
@property ( nonatomic) int recordNum;
/* 自提网点代号 备注:*/
@property ( nonatomic) NSString *brchNo;
/* 自提网点名称 备注:*/
@property ( nonatomic) NSString *brchName;
/* 网点地址 备注:*/
@property ( nonatomic) NSString *brchAddress;
/* 网点电话 备注:*/
@property ( nonatomic) NSString *brchTele;

@property (nonatomic) bool check;
/* 返回的记录数 备注:循环域结束*/
//@property ( nonatomic) int recordNum;
@end


