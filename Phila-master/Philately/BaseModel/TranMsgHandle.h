//
//  TranMsgHandle.h
//  Philately
//
//  Created by gdpost on 15/6/17.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgReturn.h"

@interface TranMsgHandle : NSObject

-(MsgReturn*)sendMsgComp;
-(MsgReturn*)recvMsgAnalyse;


@end
