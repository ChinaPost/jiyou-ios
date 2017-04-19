//
//  EditMemberViewController.h
//  Philately
//
//  Created by Mirror on 15/6/23.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "memberTableCell.h"

#import "StampTranCall.h"
#import "PromptError.h"
#import "SysBaseInfo.h"
#import "SVProgressHUD.h"
#import "CityEntity.h"

#import "ShipAddressEntity.h"

enum tagView
{
    tagsex = 0,
    tagemail =1,
    tagoper =2,
    tagcity =3,
    tagaddr=4,
    tagpost =5,
    tagyanzheng =6
} ;

@interface EditMemberViewController : UIViewController<StampTranCallDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    CstmMsg *tmpCstm;
    
    
    UIView* pickfatherview;
    
    NSMutableArray *mtarr;
  
}

@property (weak, nonatomic) IBOutlet UILabel *relateMobilePhone;
@property (weak, nonatomic) IBOutlet UITextField *homePhoneEditer;
@property (weak, nonatomic) IBOutlet UIImageView *relatePhoneRight;

@property (strong, nonatomic) IBOutlet UIView *basicView;
@property (weak, nonatomic) IBOutlet UILabel *lbtitle;
@property (weak, nonatomic) IBOutlet UIView *cstmnameView;
@property (weak, nonatomic) IBOutlet UIView *mobileView;
@property (weak, nonatomic) IBOutlet UIView *cityView;
@property (weak, nonatomic) IBOutlet UIView *sexView;
@property (weak, nonatomic) IBOutlet UIView *emailView;
@property (weak, nonatomic) IBOutlet UIView *operView;
@property (weak, nonatomic) IBOutlet UIView *addrView;
@property (weak, nonatomic) IBOutlet UIView *postView;
@property (weak, nonatomic) IBOutlet UIView *saveView;
@property (weak, nonatomic) IBOutlet UIView *yanzhengView;
@property (strong, nonatomic) IBOutlet UIView *yanzhengtonguoView;
@property (weak, nonatomic) IBOutlet UIScrollView *Scrollview;
@property (strong, nonatomic) IBOutlet UIView *cityPickerview;

@property (weak, nonatomic) IBOutlet UILabel *lbuserName;//用户名
@property (weak, nonatomic) IBOutlet UILabel *lbsex;
@property (weak, nonatomic) IBOutlet UILabel *lbcstmMobile;
@property (weak, nonatomic) IBOutlet UITextField *tfemail;
@property (weak, nonatomic) IBOutlet UITextField *tfbrchMobNum;
@property (weak, nonatomic) IBOutlet UILabel *lbprovName;
@property (weak, nonatomic) IBOutlet UILabel *lbcityName;
@property (weak, nonatomic) IBOutlet UILabel *lbcountyName;
@property (weak, nonatomic) IBOutlet UITextField *tfdetailAddr;

@property (weak, nonatomic) IBOutlet UITextField *tfpostcode;

@property (weak, nonatomic) IBOutlet UILabel *cstmScore;

@property (weak, nonatomic) IBOutlet UILabel *lbcstmName;//姓名
@property (weak, nonatomic) IBOutlet UILabel *lbcertNo;
@property (weak, nonatomic) IBOutlet UILabel *lbverifiMobileNo;


- (IBAction)docancel:(id)sender;
- (IBAction)dosure:(id)sender;

- (IBAction)goback:(id)sender;
-(void)refreshAreaInfo:(ShipAddressEntity*)shipaddress;
- (IBAction)save:(id)sender;


@end
