//
//  ReplaceOrderDetailViewController.h
//  Philately
//
//  Created by Mirror on 15/7/1.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReplaceOrderDetailCellViewController.h"
#import "RespondParam0057.h"

#import "StampTranCall.h"
#import "PromptError.h"
#import "SysBaseInfo.h"
#import "SVProgressHUD.h"

@interface ReplaceOrderDetailViewController : UIViewController<StampTranCallDelegate,UITextFieldDelegate>
{
    NSMutableArray *mtarr;
    NSMutableArray *dataList;
    NSMutableArray *picList;
    NSString * unDoFlag;//是否显示撤销按钮，0显示，1不显示
    NSString * emailFlag;//是否显示回邮信息，0显示，1不显示
    RespondParam0057* replaceOrderEty;
}

@property (weak, nonatomic) IBOutlet UILabel *lbtitle;
@property (weak, nonatomic) IBOutlet UILabel *lbreplaceOrderNo;
@property (weak, nonatomic) IBOutlet UILabel *lborderNo;
@property (weak, nonatomic) IBOutlet UILabel *lbstatus;
@property (weak, nonatomic) IBOutlet UITextView *tfuserDesc;


@property (weak, nonatomic) IBOutlet UIView *imgView;
@property (weak, nonatomic) IBOutlet UIButton *btnunDo;


@property (strong, nonatomic) IBOutlet UIView *saveView;
@property (weak, nonatomic) IBOutlet UITextField *tfshipNo;
@property (weak, nonatomic) IBOutlet UILabel *lbshipCompany;

@property(nonatomic,retain)RespondParam0057* replaceOrderEty;

@property (weak, nonatomic) IBOutlet UIScrollView *bigScrollView;

@property (strong, nonatomic) IBOutlet UIView *basicView;
@property (strong, nonatomic) IBOutlet UIView *refuseView;
@property (weak, nonatomic) IBOutlet UITextView *tfrefuseReason;
@property (weak, nonatomic) IBOutlet UIView *orderView;
@property (weak, nonatomic) IBOutlet UIView *merchView;
@property (weak, nonatomic) IBOutlet UIView *reasonView;
@property (weak, nonatomic) IBOutlet UIButton *btnsure;
@property (weak, nonatomic) IBOutlet UIImageView *imgdown;


- (IBAction)goback:(id)sender;
- (IBAction)goUnDo:(id)sender;
- (IBAction)goapplication:(id)sender;


@end
