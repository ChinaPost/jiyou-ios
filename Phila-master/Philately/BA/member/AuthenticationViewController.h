//
//  AuthenticationViewController.h
//  Philately
//
//  Created by Mirror on 15/6/19.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "StampTranCall.h"
#import "PromptError.h"
#import "SysBaseInfo.h"
#import "SVProgressHUD.h"

@interface AuthenticationViewController : UIViewController<UITextFieldDelegate,StampTranCallDelegate>

- (IBAction)doAuthentication:(id)sender;
- (IBAction)goback:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbtitle;
@property (weak, nonatomic) IBOutlet UITextField *tfname;
@property (weak, nonatomic) IBOutlet UITextField *tfcertNo;

@property (nonatomic,strong)void(^refreshData)(NSString*cstmName,NSString*certNo);

@end
