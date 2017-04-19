//
//  MyYaoHaoViewController.h
//  Philately
//
//  Created by Mirror on 15/7/18.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RespondParam0040.h"

#import "StampTranCall.h"
#import "PromptError.h"
#import "SysBaseInfo.h"
#import "SVProgressHUD.h"

@interface MyYaoHaoViewController : UIViewController<StampTranCallDelegate,UIScrollViewDelegate>
{
    NSMutableArray* mtarr;
    NSMutableArray* dataList;
    RespondParam0040 * orderEty;
}
@property (weak, nonatomic) IBOutlet UILabel *lbtitle;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIView *nonview;


- (IBAction)goBack:(id)sender;

@end
