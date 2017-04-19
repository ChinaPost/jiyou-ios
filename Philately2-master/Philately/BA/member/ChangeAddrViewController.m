//
//  ChangeAddrViewController.m
//  Philately
//
//  Created by Mirror on 15/6/26.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "ChangeAddrViewController.h"
#import <MsgReturn.h>
#import "PromptError.h"
#import "BasicClass.h"

@interface ChangeAddrViewController ()
@property (nonatomic,retain) NSString *titlestring;
@property (nonatomic,retain) NSString *placestring;
@property (assign) NSInteger tag;
@end

#define kNum @"0123456789"
@implementation ChangeAddrViewController


-(id)initWithTag:(NSInteger)tag
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.tag =tag;
        if (tag == 1) {
            self.titlestring =@"修改邮箱地址";
            self.placestring=@"请输入新的邮箱地址";
        } else if (tag ==2){
            self.titlestring =@"修改营销员号";
            self.placestring=@"请输入营销员号";
        } else if (tag ==4){
            self.titlestring =@"修改详细地址";
            self.placestring=@"请输入新的详细地址";
        } else if (tag ==5){
            self.titlestring =@"修改邮编";
            self.placestring=@"请输入新的邮政编码";
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbtitle.text =self.titlestring;
    self.tfAddr.placeholder =self.placestring;
    self.tfAddr.delegate =self;
    
    if (self.tag==2||self.tag==5) {
        [self.tfAddr setKeyboardType:UIKeyboardTypeNumberPad];
    }
    else if (self.tag==1)
    {
        [self.tfAddr setKeyboardType:UIKeyboardTypeEmailAddress];
    }
    else
    {
        [self.tfAddr setKeyboardType:UIKeyboardTypeDefault];
    }
    
    UITapGestureRecognizer* tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
    [self.view addGestureRecognizer:tap];
}
-(void)click
{
    [self.tfAddr resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];//得到输入
    if (self.tag ==2) {
        if (toBeString.length==21) {
            [self.tfAddr resignFirstResponder];
            return NO;
        }
    }
    else if (self.tag ==5){
        if (toBeString.length==7) {
            [self.tfAddr resignFirstResponder];
            return NO;
        }
    }
    else if (self.tag ==1){
        if (toBeString.length==51) {
            [self.tfAddr resignFirstResponder];
            return NO;
        }
    }
    else if (self.tag ==4){
        if (toBeString.length==101) {
            [self.tfAddr resignFirstResponder];
            return NO;
        }
    }
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"tag:[%ld]",(long)textField.tag);
    if (self.tag ==2) {
        if ([self.tfAddr.text length] > 20)
        { //如果输入框内容等于20则禁止输入
            self.tfAddr.text =[self.tfAddr.text substringToIndex:11];
            [self.tfAddr resignFirstResponder];
            return;
        }
    }else if (self.tag ==5){
        if ([self.tfAddr.text length] > 6)
        {
            self.tfAddr.text =[self.tfAddr.text substringToIndex:6];
            [self.tfAddr resignFirstResponder];
            return;
        }
    }
    else if (self.tag ==1){
        if ([self.tfAddr.text length] > 50)
        {
            self.tfAddr.text =[self.tfAddr.text substringToIndex:50];
            [self.tfAddr resignFirstResponder];
            return;
        }
    }
    else if (self.tag ==4){
        if ([self.tfAddr.text length] > 100)
        {
            self.tfAddr.text =[self.tfAddr.text substringToIndex:100];
            [self.tfAddr resignFirstResponder];
            return;
        }
    }
    

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.tfAddr resignFirstResponder];
    return YES;
}



#pragma mark-按钮点击事件
- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)goSave:(id)sender {
    
    MsgReturn *msgReturn=[[MsgReturn alloc]init];
    NSString* txtcontent =self.tfAddr.text;
    if (self.tag ==4) {
        if(txtcontent==nil ||[txtcontent isEqualToString:@""])
        {
            msgReturn.errorCode=@"0001";//不能为空
             msgReturn.errorPic=true;
            [PromptError changeShowErrorMsg:msgReturn title:@"地址"  viewController:self block:^(BOOL OKCancel){}];
            return;
        }
        else
        {
            if (self.tfAddr.text.length<5) {
                msgReturn.errorCode=@"0002";//长度过短
                 msgReturn.errorPic=true;
                [PromptError changeShowErrorMsg:msgReturn title:@"地址"  viewController:self block:^(BOOL OKCancel){}];
                return;
            }
            if (self.tfAddr.text.length>100) {
                msgReturn.errorCode=@"0003";//长度超长
                 msgReturn.errorPic=true;
                [PromptError changeShowErrorMsg:msgReturn title:@"地址"  viewController:self block:^(BOOL OKCancel){}];
                return;
            }
        }

    }
    else if (self.tag ==5)
    {
        if (self.tfAddr.text.length>6) {
            msgReturn.errorCode=@"0003";//长度过长
            msgReturn.errorPic=true;
            [PromptError changeShowErrorMsg:msgReturn title:@"邮编"  viewController:self block:^(BOOL OKCancel){}];
            return;
        }
        if (self.tfAddr.text.length<6) {
            msgReturn.errorCode=@"0002";//长度过短
            msgReturn.errorPic=true;
            [PromptError changeShowErrorMsg:msgReturn title:@"邮编"  viewController:self block:^(BOOL OKCancel){}];
            return;
        }

    }
    
    
    
    
    if (self.doChangeAddr) {
        self.doChangeAddr(self.tfAddr.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
