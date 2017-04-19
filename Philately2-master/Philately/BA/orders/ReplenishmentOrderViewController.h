//
//  ReplenishmentOrderViewController.h
//  Philately
//
//  Created by Mirror on 15/6/30.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReplenishmentOrderCellViewController.h"
#import "RespondParam0040.h"

#import "StampTranCall.h"
#import "PromptError.h"
#import "SysBaseInfo.h"
#import "SVProgressHUD.h"
#import "OrderPay0039.h"


//我的补退款
@interface ReplenishmentOrderViewController : UIViewController<StampTranCallDelegate,OrderPay0039Delegate,UIScrollViewDelegate>
{
    NSMutableArray* mtarr;
    NSMutableArray* dataList;
    RespondParam0040 * orderEty;
}
- (IBAction)goback:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbtitle;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (strong, nonatomic) IBOutlet UIView *nonView;

@end
