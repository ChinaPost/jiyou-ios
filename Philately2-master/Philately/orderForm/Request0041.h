//
//  Request0041.h
//  Philately
//
//  Created by gdpost on 15/7/14.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StampTranCall.h"
#import "PromptError.h"
#import "SysBaseInfo.h"
#import "RespondParam0041.h"

@protocol Request0041Delegate;

@interface Request0041 : NSObject<StampTranCallDelegate>

-(void) request0041:(NSString *)orderNo;
@property (strong,nonatomic) id<Request0041Delegate> delegate;

@end

@protocol Request0041Delegate <NSObject>

-(void) jy0041Result:(NSDictionary*) result;

@end