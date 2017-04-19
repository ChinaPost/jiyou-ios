//
//  touSuDetailViewController.h
//  Philately
//
//  Created by Mirror on 15/6/27.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComplaintOrderEntity.h"

#import "StampTranCall.h"
#import "PromptError.h"
#import "SysBaseInfo.h"
#import "SVProgressHUD.h"


@interface TouSuDetailViewController : UIViewController<StampTranCallDelegate>
{
    ComplaintOrderEntity * complaintOrderEty;
}
@property (weak, nonatomic) IBOutlet UILabel *lbtitle;
@property (weak, nonatomic) IBOutlet UILabel *lbcomplaintNo;
@property (weak, nonatomic) IBOutlet UITextView *tfcomplaintContent;
@property (weak, nonatomic) IBOutlet UILabel *lbstatus;
@property (weak, nonatomic) IBOutlet UILabel *lblinkOrderNo;
@property (weak, nonatomic) IBOutlet UITextView *tfreason;
@property (weak, nonatomic) IBOutlet UILabel *lbmobile;
@property (weak, nonatomic) IBOutlet UILabel *lbcstmName;
@property (weak, nonatomic) IBOutlet UILabel *lbtousudate;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *errReasonView;
@property (weak, nonatomic) IBOutlet UITextView *tferrReason;
@property (strong, nonatomic) IBOutlet UIView *basicView;




@property (nonatomic)ComplaintOrderEntity * complaintOrderEty;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;

- (IBAction)goback:(id)sender;
- (IBAction)doCancel:(id)sender;

@end
