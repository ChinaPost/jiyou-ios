//
//  touSuShengQingViewController.h
//  Philately
//
//  Created by Mirror on 15/6/27.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "StampTranCall.h"
#import "PromptError.h"
#import "SysBaseInfo.h"
#import "SVProgressHUD.h"
#import "DateConvert.h"

@interface TouSuShengQingViewController : UIViewController<StampTranCallDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    NSString* orderNO;

}
- (IBAction)goback:(id)sender;
- (IBAction)goSave:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (weak, nonatomic) IBOutlet UITextField *tfMobile;
@property (weak, nonatomic) IBOutlet UITextView *tfvContent;
@property (weak, nonatomic) IBOutlet UILabel *lborderNo;
@property (weak, nonatomic) IBOutlet UILabel *lbtitle;



@property(nonatomic)NSString* orderNO;

@end
