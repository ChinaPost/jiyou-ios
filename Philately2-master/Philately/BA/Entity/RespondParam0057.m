//
//  RespondParam0057.m
//  Philately
//
//  Created by Mirror on 15/7/13.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "RespondParam0057.h"

@implementation RespondParam0057
@synthesize recordNum;
@synthesize exchangMerchNo;
@synthesize linkOrderNo;
@synthesize applyDate;
@synthesize dealStatus;
@synthesize userDesc;
@synthesize refuseReason;
@synthesize mailAddress;
@synthesize logistCompany;
@synthesize logistNum;

@synthesize applyMerchList;
@synthesize applyPicList;
@synthesize exchangeMerchList;

@end

@implementation ApplyMerchItems

@synthesize applyMerchNum;
@synthesize linkExchangMerchNo1;
@synthesize linkMerchID;
@synthesize merchName;
@synthesize merchNum;
@end

@implementation ApplyPicItems

@synthesize applyPicNum;
@synthesize linkExchangMerchNo2;
@synthesize interPicURL;
@synthesize merchPicID;
@end

@implementation ExchangMerchItems

@synthesize exchangMerchNum;
@synthesize linkExchangMerchNo3;
@synthesize dealTime;
@synthesize dealContent;
@synthesize dealPerson;
@end
