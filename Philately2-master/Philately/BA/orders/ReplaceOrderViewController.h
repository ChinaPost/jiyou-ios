//
//  ReplaceOrderViewController.h
//  Philately
//
//  Created by Mirror on 15/6/30.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReplaceOrderCellViewController.h"

#import "StampTranCall.h"
#import "PromptError.h"
#import "SysBaseInfo.h"
#import "SVProgressHUD.h"

#import "RespondParam0057.h"
#import "Request0041.h"

@interface ReplaceOrderViewController : UIViewController<ReplaceOrderCellDelegate,StampTranCallDelegate,Request0041Delegate>
{
    NSMutableArray* mtarr;
    NSMutableArray* dataList;
    NSString* orderNo;
    NSString* status;//状态，是否是 可申请换货
    RespondParam0057 * repalceOrderEty;
}

- (IBAction)goback:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbtitle;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (strong, nonatomic) IBOutlet UIView *nonView;
@property (weak, nonatomic) IBOutlet UIButton *btnApplicationOrder;
@property(nonatomic)NSString* myreplaceorderflag;

@property(nonatomic)NSString* orderNo;
@property(nonatomic)NSString* status;

- (IBAction)goApplicationOrder:(id)sender;
@end
