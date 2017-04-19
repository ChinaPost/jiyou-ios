//
//  ErrorObject.h
//  Philately
//
//  Created by gdpost on 15/6/30.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ErrorObject : NSObject


@property (strong, nonatomic) NSString  *errorCode;
@property (strong, nonatomic) NSString  *errorDesc;
@property (strong, nonatomic) NSString  *errorType;

@end
