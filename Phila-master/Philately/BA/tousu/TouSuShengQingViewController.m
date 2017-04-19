//
//  touSuShengQingViewController.m
//  Philately
//
//  Created by Mirror on 15/6/27.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "TouSuShengQingViewController.h"
#import "touSuListViewController.h"

@interface TouSuShengQingViewController ()

@end

#define kNum @"0123456789"

@implementation TouSuShengQingViewController


@synthesize orderNO;


bool isup;
CGFloat tmpHight;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbtitle.text =@"投诉申请";
    
    
    self.tfMobile.keyboardType =UIKeyboardTypeNumbersAndPunctuation;
    self.tfName.delegate =self;
    self.tfMobile.delegate =self;
    self.tfvContent.delegate =self;
    self.lborderNo.text =orderNO;
    self.tfMobile.text =[CstmMsg sharedInstance].mobileNo;
    
    UITapGestureRecognizer* tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
    [self.view addGestureRecognizer:tap];
    
    tmpHight =([UIScreen mainScreen].bounds.size.height >= 568)?80:150;
    
    
}
-(void)click
{
    [self.tfvContent resignFirstResponder];
    [self.tfName resignFirstResponder];
    [self.tfMobile resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 点击事件
- (IBAction)goback:(id)sender {

   [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)goSave:(id)sender {
    MsgReturn *msgReturn=[[MsgReturn alloc]init];
    
    if(self.tfName.text==nil ||[self.tfName.text isEqualToString:@""])
    {
        msgReturn.errorCode=@"0001";//不能为空
        [PromptError changeShowErrorMsg:msgReturn title:@"姓名"  viewController:self block:^(BOOL OKCancel){}];
        return;
    }
    else
    {
        if (self.tfName.text.length>21) {
            msgReturn.errorCode=@"0003";//长度太长
            [PromptError changeShowErrorMsg:msgReturn title:@"姓名"  viewController:self block:^(BOOL OKCancel){}];
            return;
            
        }
    }
    
    if(self.tfMobile.text==nil ||[self.tfMobile.text isEqualToString:@""])
    {
        msgReturn.errorCode=@"0001";//不能为空
        [PromptError changeShowErrorMsg:msgReturn title:@"手机号码"  viewController:self block:^(BOOL OKCancel){}];
        return;
    }
    if(self.tfvContent.text==nil ||[self.tfvContent.text isEqualToString:@""])
    {
        msgReturn.errorCode=@"0001";//不能为空
        [PromptError changeShowErrorMsg:msgReturn title:@"投诉内容"  viewController:self block:^(BOOL OKCancel){}];
        return;
    }
    else
    {
        if (self.tfvContent.text.length>200) {
            msgReturn.errorCode=@"0003";//长度太长
            [PromptError changeShowErrorMsg:msgReturn title:@"投诉内容"  viewController:self block:^(BOOL OKCancel){}];
            return;

        }
    }
    
    if(![DateConvert isCommonChar:self.tfName.text])
    {
        
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        
        msgReturn.errorDesc=@"投诉人格式不正确";//不能为空
        msgReturn.errorType=@"01";
        msgReturn.errorCode=@"-0078";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        return ;
    }
    
//    if(![DateConvert isCommonChar:self.tfvContent.text])
//    {
//        
//        
//        MsgReturn *msgReturn=[[MsgReturn alloc]init];
//        
//        
//        msgReturn.errorDesc=@"投诉理由格式不正确";//不能为空
//        msgReturn.errorType=@"01";
//        msgReturn.errorCode=@"0078";
//        msgReturn.errorPic=true;
//        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
//        return ;
//    }
    
    msgReturn.errorCode=@"0043";//是否确定对本订单提交投诉
    [PromptError changeShowErrorMsg:msgReturn title:@"投诉申请"  viewController:self block:^(BOOL OKCancel)
         {
             if (OKCancel) {
                 [self applicationTouSu];
             }else
             {
                 
             }
             return ;
         }
     ];
    
}

#pragma mark - 投诉申请 与 返回处理方法
NSString * n0059 =@"JY0059";
-(void)applicationTouSu
{
    CstmMsg *_cstmmsg = [CstmMsg sharedInstance];
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    [para setValue:_cstmmsg.cstmNo forKey:@"cstmNo"];
    [para setValue:self.lborderNo.text forKey:@"orderNo"];
    [para setValue:self.tfName.text forKey:@"cstmName"];
    [para setValue:self.tfMobile.text forKey:@"cstmPhone"];
    [para setValue:self.tfvContent.text forKey:@"complaintContent"];
    
    
    SysBaseInfo *_sysBaseInfo = [SysBaseInfo sharedInstance];
    StampTranCall * stampTranCall = [StampTranCall sharedInstance];
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmmsg formName:n0059 business:para delegate:self viewController:self];
    
}

-(void) ReturnData:(MsgReturn*)msgReturn
{
    [SVProgressHUD dismiss];
    if ([msgReturn.formName isEqual:n0059]) {
        if(msgReturn.map==nil)
            return;
        
        NSLog(@"0059 %lu",(unsigned long)[msgReturn.map count]);
        
        
        TouSuListViewController* tousuView =[[TouSuListViewController alloc]init];
        
        self.hidesBottomBarWhenPushed = YES;
        tousuView.orderNo=@"";
        [self.navigationController pushViewController:tousuView animated:YES];
            
    }
}
-(void) ReturnError:(MsgReturn*)msgReturn
{
    [SVProgressHUD dismiss];
}
#pragma mark -textFieldDelegate 
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];//得到输入框的内容
    if (textField == self.tfMobile) {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:kNum] invertedSet];
        NSString * filtered =[[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        NSLog(@"filtered:%@",filtered);
        BOOL basic =[string isEqualToString:filtered];
        if (basic)
        {
            if ([toBeString length] >= 21)
            { //如果输入框内容大于7则禁止输入
                [self.tfMobile resignFirstResponder];
                return NO;
            }
            self.tfMobile.text =[toBeString stringByReplacingOccurrencesOfString:@" " withString:@""];
        }
        else
        {
            NSString *tt =[toBeString substringWithRange:NSMakeRange(toBeString.length-1, 1)];
            self.tfMobile.text =[toBeString stringByReplacingOccurrencesOfString:tt withString:@""];
            
        }
        return NO;
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==self.tfName) {
        [self.tfName resignFirstResponder];
        [self.tfMobile becomeFirstResponder];
        [self.tfvContent resignFirstResponder];
    }
    else if (textField==self.tfMobile)
    {
        [self.tfName resignFirstResponder];
        [self.tfMobile resignFirstResponder];
        [self.tfvContent becomeFirstResponder];
    }
    return NO;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==self.tfMobile) {
        [self MoveView];
    }
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==self.tfMobile) {
        [self MoveView];
    }
}
#pragma mark - UItextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self MoveView];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self MoveView];
}
#pragma mark -textView 失效方法
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [self.tfvContent resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}
#pragma mark- 点击textField,根据键盘上移视图
-(void)MoveView{
    if (isup) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame=CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+tmpHight, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
        isup = false;
    }else{
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationBeginsFromCurrentState:YES];
        
        self.view.frame=CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y -tmpHight, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
        isup = true;
    }
}

@end
