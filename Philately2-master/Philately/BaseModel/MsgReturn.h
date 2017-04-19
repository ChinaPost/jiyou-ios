//
//  MsgReturn.h
//  Philately
//
//  Created by gdpost on 15/6/17.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ErrorMsg.h"

@interface MsgReturn : UIView

@property (strong, nonatomic) ErrorMsg  *mErrorMsg;
@property (strong, nonatomic) NSMutableDictionary  *map;

-(void)initMsgReturn;

@end
