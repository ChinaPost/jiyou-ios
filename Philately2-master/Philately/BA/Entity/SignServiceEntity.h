//
//  SignServiceEntity.h
//  Philately
//
//  Created by Mirror on 15/7/11.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignServiceEntity : NSObject
{
    NSString* serviceKey;
    NSString* serviceValue;
    NSString* remark;
}

@property (nonatomic)NSString* serviceKey;
@property (nonatomic)NSString* serviceValue;
@property (nonatomic)NSString* remark;
@end
