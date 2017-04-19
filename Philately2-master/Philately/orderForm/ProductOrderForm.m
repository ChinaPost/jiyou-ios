//
//  OrderForm.m
//  Philately
//
//  Created by gdpost on 15/7/6.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "ProductOrderForm.h"

@implementation ProductOrderForm


@synthesize orderNo;
@synthesize productType;
@synthesize relateMobilePhone;
@synthesize productNo;
@synthesize businNo;
@synthesize shoppingCar;

@synthesize searchName;

@synthesize pickupId;
@synthesize pickupAddress;
@synthesize pickupName;
@synthesize orderFormIndex;
@synthesize deleteOrderForm;
@synthesize viewControlls;
@synthesize selectAddresss;
@synthesize mergeFlag;
@synthesize isfresh;

//实现一个创建单例对象的类方法

static ProductOrderForm *objName = nil;

+ (ProductOrderForm *) sharedInstance{
    static dispatch_once_t oneToken = 0;
    dispatch_once(&oneToken, ^{
        objName = [[super allocWithZone: NULL] init];
    });
    return objName;
}

//重写几个方法，防止创建单例对象时出现错误
-(id) init{
    if(self = [super init])
    {
        //初始化单例对象的各种属性
    }
    return self;
}

+(id)allocWithZone: (struct _NSZone *) zone{
    return [self sharedInstance];
}

//这是单例对象遵循<NSCopying>协议时需要实现的方法
-(id) copyWithZone: (struct _NSZone *)zone{
    return self;
}


@end
