//
//  RespondParam0057.h
//  Philately
//
//  Created by Mirror on 15/7/13.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RespondParam0057 : NSObject
@property (nonatomic)NSString* recordNum;
@property (nonatomic)NSString*exchangMerchNo;
@property (nonatomic)NSString*linkOrderNo;
@property (nonatomic)NSString*applyDate;
@property (nonatomic)NSString*dealStatus;
@property (nonatomic)NSString*userDesc;
@property (nonatomic)NSString*refuseReason;
@property (nonatomic)NSString*mailAddress;
@property (nonatomic)NSString*logistCompany;
@property (nonatomic)NSString*logistNum;

@property (nonatomic,retain)NSMutableArray* applyMerchList;
@property (nonatomic,strong)NSMutableArray* applyPicList;
@property (nonatomic,strong)NSMutableArray* exchangeMerchList;
@end

@interface ApplyMerchItems : NSObject

@property (nonatomic)NSString* applyMerchNum;
@property (nonatomic)NSString* linkExchangMerchNo1;
@property (nonatomic)NSString* linkMerchID;
@property (nonatomic)NSString* merchName;
@property (nonatomic)NSString* merchNum;
@end

@interface ApplyPicItems : NSObject

@property (nonatomic)NSString* applyPicNum;
@property (nonatomic)NSString* linkExchangMerchNo2;
@property (nonatomic)NSString* interPicURL;
@property (nonatomic)NSString* merchPicID;
@end

@interface ExchangMerchItems : NSObject

@property (nonatomic)NSString* exchangMerchNum;
@property (nonatomic)NSString* linkExchangMerchNo3;
@property (nonatomic)NSString* dealTime;
@property (nonatomic)NSString* dealContent;
@property (nonatomic)NSString* dealPerson;
@end


