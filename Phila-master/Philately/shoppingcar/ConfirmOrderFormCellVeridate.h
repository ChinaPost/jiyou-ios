//
//  ConfirmOrderFormCellVeridate.h
//  Philately
//
//  Created by gdpost on 15/8/1.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmOrderFormCellVeridate : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *verifyPhone;

@property (weak, nonatomic) IBOutlet UIView *seller;

//营销员号:
@property (weak, nonatomic) IBOutlet UILabel *salerNoTitleTextView;
//请输入营销员号
@property (weak, nonatomic) IBOutlet UITextField *salerNoValueEditText;
//验证码:
@property (weak, nonatomic) IBOutlet UILabel *codeTitleTextView;
//请输入验证码
@property (weak, nonatomic) IBOutlet UITextField *codeValueEditText;
//获取验证码
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;

@end
