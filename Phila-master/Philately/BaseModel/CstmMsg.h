//
//  CstmMsg.h
//  Philately
//
//  Created by gdpost on 15/6/17.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TermTypeInfo.h"

@interface CstmMsg : NSObject

@property (strong, nonatomic) NSString  *sinceBrchName;//新邮自提机构名称

@property (strong, nonatomic) NSString  *sinceBrchAddress;//新邮自提机构地址

@property (strong, nonatomic) NSString  *saleBrchName;//零售自提机构名称

@property (strong, nonatomic) NSString  *saleBrchAddress;//零售自提机构地址

@property (strong, nonatomic) NSString  *cstmNo;
@property (strong, nonatomic) NSString  *userPicID;
@property (strong, nonatomic) NSString  *userPicUrl;
@property (strong, nonatomic) NSString  *userName;
@property (strong, nonatomic) NSString  *mobileNo;
@property (strong, nonatomic) NSString  *homePhone;
@property (strong, nonatomic) NSString  *userSex;
@property (strong, nonatomic) NSString  *email;
@property (strong, nonatomic) NSString  *cstmScore;
@property (strong, nonatomic) NSString  *isStampMember;

@property (strong, nonatomic) NSString  *isAutonym;
@property (strong, nonatomic) NSString  *cstmName;
@property (strong, nonatomic) NSString  *certNo;
@property (strong, nonatomic) NSString  *verifiMobileNo;

@property (strong, nonatomic) NSString  *provCode;
@property (strong, nonatomic) NSString  *cityCode;
@property (strong, nonatomic) NSString  *countCode;
@property (strong, nonatomic) NSString  *detailAddress;
@property (strong, nonatomic) NSString  *postCode;
@property (strong, nonatomic) NSString  *brchMobNum;
@property (strong, nonatomic) NSString  *sinceBrchNo;
@property (strong, nonatomic) NSString  *saleBrchNo;
@property (strong, nonatomic) NSArray  * termTypeInfo;





+ (CstmMsg *) sharedInstance;
-(void) clearCstmMsg;
-(void) resetCstmMsg;
@end
