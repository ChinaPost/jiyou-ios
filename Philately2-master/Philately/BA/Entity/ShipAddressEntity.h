//
//  ShipAddress.h
//  Philately
//
//  Created by Mirror on 15/7/3.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//
//收货地址实体类
#import <Foundation/Foundation.h>

@interface ShipAddressEntity : NSObject
{
    NSString*addressId;
    NSString* cstmNo;
    NSString*recvName;
    NSString*provCode;
    NSString*cityCode;
    NSString*countCode;
    NSString*provName;
    NSString*cityName;
    NSString*countName;
    NSString*detailAddress;
    NSString*mobileNo;
    NSString*postCode;
    NSString*isDefaultAddr;
}



@property (nonatomic) NSString*addressId;
@property (nonatomic) NSString* cstmNo;
@property (nonatomic) NSString*recvName;
@property (nonatomic) NSString*provCode;
@property (nonatomic) NSString*cityCode;
@property (nonatomic) NSString*countCode;
@property (nonatomic) NSString*detailAddress;
@property (nonatomic) NSString*mobileNo;
@property (nonatomic) NSString*postCode;
@property (nonatomic) NSString*isDefaultAddr;
@property (nonatomic) NSString*provName;
@property (nonatomic) NSString*cityName;
@property (nonatomic) NSString*countName;

@end
