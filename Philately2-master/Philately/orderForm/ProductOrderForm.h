//
//  OrderForm.h
//  Philately
//
//  Created by gdpost on 15/7/6.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductOrderForm : NSObject

@property (nonatomic,strong) NSString *orderNo;

@property (nonatomic,strong) NSString *productType;

@property (strong,nonatomic) NSString *productNo;
@property (strong,nonatomic) NSString *businNo;


@property (strong,nonatomic) NSMutableDictionary *shoppingCar;

@property (strong,nonatomic)  NSString *pickupId;
@property (strong,nonatomic)  NSString *pickupAddress;
@property (strong,nonatomic)  NSString *pickupName;
@property (nonatomic) int orderFormIndex;

@property (strong,nonatomic) NSString *searchName;

@property (strong,nonatomic)  NSMutableArray *viewControlls;


@property (nonatomic) bool deleteOrderForm;


@property (nonatomic) bool selectAddresss;

@property (nonatomic) int mergeFlag;

@property (nonatomic) bool isfresh;

@property (strong,nonatomic) NSString *relateMobilePhone;


+ (ProductOrderForm *) sharedInstance;

@end
