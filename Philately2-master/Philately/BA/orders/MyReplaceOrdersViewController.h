//
//  MyReplaceOrdersViewController.h
//  Philately
//
//  Created by Mirror on 15/6/30.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "StampTranCall.h"
#import "PromptError.h"
#import "SysBaseInfo.h"
#import "SVProgressHUD.h"
#import "RespondParam0040.h"
#import "Request0041.h"

@interface MyReplaceOrdersViewController : UIViewController<StampTranCallDelegate,Request0041Delegate,UIScrollViewDelegate>
{
    NSMutableArray* mtarr;
    NSMutableArray* dataList;
    RespondParam0040 * orderEty;
    NSString* orderNo;
}
- (IBAction)goback:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbtitle;
@property (strong, nonatomic) IBOutlet UIView *nonView;

@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;

@end
