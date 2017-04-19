//
//  AuthenticationViewController.m
//  Philately
//
//  Created by Mirror on 15/6/19.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "AuthenticationViewController.h"

#import "BasicClass.h"
#import "SVProgressHUD.h"
#import "PromptError.h"
#import "SysBaseInfo.h"

@interface AuthenticationViewController ()

@end

#define kAlphaNum @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
@implementation AuthenticationViewController

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden =YES;
    self.lbtitle.text =@"实名认证";
    
    self.tfcertNo.delegate =self;
    self.tfcertNo.keyboardType =UIKeyboardTypeNumbersAndPunctuation;
    self.tfname.delegate =self;
    
    UITapGestureRecognizer* tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
    [self.view addGestureRecognizer:tap];
    
    
}
-(void)click
{
    [self.tfcertNo resignFirstResponder];
    [self.tfname resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 实名验证
/*实名验证0007*/
NSString  *n0007=@"JY0007";
/*实名验证0007*/
-(void) request0007{
    
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 会员编号 必填*/
    [businessparam setValue:_cstmMsg.cstmNo forKey:@"cstmNo"];
    /* 姓名 必填 */
    [businessparam setValue:self.tfname.text forKey:@"cstmName"];
    /* 身份证号 必填 */
    [businessparam setValue:[self.tfcertNo.text uppercaseString] forKey:@"certNo"];

    
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0007 business:businessparam delegate:self viewController:self];
    
}
#pragma mark - 发送交易请求后 返回处理
-(void) ReturnData:(MsgReturn*)msgReturn
{
    [SVProgressHUD dismiss];
    /*实名验证 0007*/
    if ([msgReturn.formName isEqualToString:n0007])//实名验证
    {
        if(msgReturn.map==nil)
            return;
        
        NSLog(@"0007 %lu",(unsigned long)[msgReturn.map count]);
        //        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        //        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        //        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        //        NSString *respCode=[returnHead objectForKey:@"respCode"];
        //        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        
        msgReturn.errorCode=@"0032";//不能为空
        [PromptError changeShowErrorMsg:msgReturn title:@"实名验证"  viewController:self block:^(BOOL OKCancel){} ];
        
        [CstmMsg sharedInstance].isAutonym =@"0";
        [CstmMsg sharedInstance].cstmName =self.tfname.text;
        [CstmMsg sharedInstance].certNo =self.tfcertNo.text;
        [CstmMsg sharedInstance].verifiMobileNo =[CstmMsg sharedInstance].mobileNo;
        
        if (self.refreshData) {
            self.refreshData(self.tfname.text,self.tfcertNo.text);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void) ReturnError:(MsgReturn*)msgReturn
{
    [SVProgressHUD dismiss];
}

#pragma mark -- actions
- (IBAction)doAuthentication:(id)sender {
    MsgReturn *msgReturn=[[MsgReturn alloc]init];
    
    if(self.tfname.text==nil ||[self.tfname.text isEqualToString:@""])
    {
        msgReturn.errorCode=@"0001";//不能为空
         msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@"姓名"  viewController:self block:^(BOOL OKCancel){} ];
        return;
    }
    else
    {
        if (self.tfname.text.length<2) {
            msgReturn.errorCode=@"0002";//长度过短
             msgReturn.errorPic=true;
            [PromptError changeShowErrorMsg:msgReturn title:@"姓名" viewController:self  block:^(BOOL OKCancel){}];
            return;
        }
        if (self.tfname.text.length>40) {
            msgReturn.errorCode=@"0003";//长度过长
             msgReturn.errorPic=true;
            [PromptError changeShowErrorMsg:msgReturn title:@"姓名" viewController:self  block:^(BOOL OKCancel){}];
            return;
        }
    }
    if(self.tfcertNo.text==nil ||[self.tfcertNo.text isEqualToString:@""])
    {
        msgReturn.errorCode=@"0001";//不能为空
        [PromptError changeShowErrorMsg:msgReturn title:@"身份证号"  viewController:self block:^(BOOL OKCancel){} ];
        return;
    }
    NSString* certno =[self.tfcertNo.text uppercaseString];
    Boolean flag = [BasicClass checkUserIdCard:certno];
    if (!flag) {
        msgReturn.errorCode=@"0038";//请输入正确的身份证号
        [PromptError changeShowErrorMsg:msgReturn title:@"身份证号"  viewController:self block:^(BOOL OKCancel){} ];
        return ;
    }
    
    [self request0007];
}

- (IBAction)goback:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];//得到输入框的内容
    if (textField==self.tfcertNo)
    {//身份证号
        
        if ([toBeString length] == 19)
        { //如果输入框内容大于18则禁止输入
            [self.tfcertNo resignFirstResponder];
            return NO;
        }
    }
    if (textField==self.tfname)
    {//身份证号
        
        if ([toBeString length] == 21)
        { //如果输入框内容大于21则禁止输入
            [self.tfname resignFirstResponder];
            [self.tfcertNo becomeFirstResponder];
            return NO;
        }
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField ==self.tfname) {
        [self.tfcertNo becomeFirstResponder];
        [self.tfname resignFirstResponder];
        return NO;
    }
    if (textField==self.tfcertNo) {
        [self.tfcertNo resignFirstResponder];
        [self.tfname resignFirstResponder];
        return NO;
    }
    return YES;
}


@end
