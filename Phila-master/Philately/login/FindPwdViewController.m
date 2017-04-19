//注入网络请求,响应,等待提示



#import "FindPwdViewController.h"
#import "UIImageView+WebCache.h"
#import <Foundation/Foundation.h>
#import <PublicFramework/JSONKit.h>
#import "RespondParam0053.h"
#import "RespondParam0005.h"
#import "Toast+UIView.h"
#import "BasicClass.h"

@implementation FindPwdViewController
//找回新密码
@synthesize findpwdButton;
//back
@synthesize backImageView;
//找回密码
@synthesize titleTextView;
//手机号码
@synthesize phoneTitleTextView;
//请输入手机号
@synthesize phoneValueEditText;
//获取验证码
@synthesize getcodeButton;
//验证码
@synthesize codeTitleTextView;
//请输入验证码
@synthesize codeValueEditText;
//新密码
@synthesize newpwdTitleTextView;
//请输入新密码
@synthesize newpwdValueEditText;
//确认新密码
@synthesize newpwd2TitleTextView;
//请再输入新密码
@synthesize newpwd2ValueEditText;

NSTimer *countDownTimer2 ;
int secondsCountDown2 = 60;//60秒倒计时

#define kNum @"0123456789"

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.phoneValueEditText.keyboardType =UIKeyboardTypeNumberPad;
    self.phoneValueEditText.delegate =self;
    
      [self.phoneValueEditText addTarget:self action:@selector(phoneValueEditTextDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
//      [self.phoneValueEditText addTarget:self action:@selector(phoneValueEditTextDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    
      [self.getcodeButton addTarget:self action:@selector(codepicButtonclicked:) forControlEvents:UIControlEventTouchUpInside];
    
        [self.codeValueEditText addTarget:self action:@selector(codeValueEditTextDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    self.codeValueEditText.returnKeyType=UIReturnKeyDone;

    
    [self.newpwdValueEditText addTarget:self action:@selector(pwdValueEditTextDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
    self.newpwdValueEditText.returnKeyType=UIReturnKeyDone;

    [self.newpwd2ValueEditText addTarget:self action:@selector(pwd2ValueEditTextDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    self.newpwd2ValueEditText.returnKeyType=UIReturnKeyDone;
    
    [self.findpwdButton addTarget:self action:@selector(rigistButtonlicked:) forControlEvents:UIControlEventTouchUpInside];

    
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backImageViewTap)];
    [backImageView addGestureRecognizer:singleTap1];
    
    
//    getcodeButton.enabled=YES;
//    codeValueEditText.enabled=NO;
//    newpwdValueEditText.enabled=NO;
//    newpwd2ValueEditText.enabled=NO;
//    findpwdButton.enabled=NO;
    UITapGestureRecognizer* closeKeyboardtap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKeyboard)];
    [self.view addGestureRecognizer:closeKeyboardtap];
    
}

-(void)closeKeyboard
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

-(void) viewWillAppear:(BOOL)animated{
}


-(void)backImageViewTap
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)timeFireMethod{
    secondsCountDown2--;
    [self.getcodeButton setTitle:[NSString stringWithFormat:@"%d",secondsCountDown2] forState:UIControlStateNormal];
    
    if(secondsCountDown2==0){
        [countDownTimer2 invalidate];
        self.getcodeButton.userInteractionEnabled=YES;
        [self.getcodeButton setTitle:[NSString stringWithFormat:@"%@",@"获取验证码"] forState:UIControlStateNormal];
        
    }
}
-(void)codepicButtonclicked:(UIButton *)btn{
    
    if(phoneValueEditText.text==nil || [phoneValueEditText.text isEqualToString:@""])
    {
         //[self.view makeToast:@"请输入手机号"];
        
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        
        msgReturn.errorDesc=@"请输入手机号";//不能为空
        msgReturn.errorType=@"02";
        msgReturn.errorCode=@"-333";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        
        return;
    }
    
    
    
    if (phoneValueEditText.text==nil || [phoneValueEditText.text isEqualToString:@""]|| [phoneValueEditText.text length]!=11 || [[phoneValueEditText.text substringWithRange:NSMakeRange(0, 1) ] intValue]!=1) {
        
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        msgReturn.errorCode=@"-1001";//不能为空
        msgReturn.errorDesc=@"验证码接收手机:格式不正确";
        msgReturn.errorType=@"02";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        
        return;
    }
    
//    BasicClass *baseclass=[[BasicClass alloc] init];
//    if(![baseclass validateMobile:phoneValueEditText.text])
//    {
//        
//        MsgReturn *msgReturn=[[MsgReturn alloc]init];
//        
//        
//        msgReturn.errorDesc=@"手机号格式不正确";//不能为空
//        msgReturn.errorType=@"02";
//        msgReturn.errorCode=@"-333";
//        msgReturn.errorPic=true;
//        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
//        
//        return;
//    }
    
    
    secondsCountDown2=60;
     [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    countDownTimer2 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    btn.userInteractionEnabled=NO;
    
    [self request0053];
    
}

-(void)phoneValueEditTextDidEndOnExit:(UITextField *)textField{
     [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    //[codeValueEditText becomeFirstResponder];//把焦点给别人 键盘消失
  //  codeValueEditText.userInteractionEnabled=YES;
    //getcodeButton.userInteractionEnabled=YES;
}


-(void)codeValueEditTextDidEnd:(UITextField *)textField{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    //[newpwdValueEditText becomeFirstResponder];//把焦点给别人 键盘消失
   // newpwdValueEditText.userInteractionEnabled=YES;
   
    
}

-(void)codeValueEditTextDidEndOnExit:(UITextField *)textField{
     [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    //[newpwdValueEditText becomeFirstResponder];//把焦点给别人 键盘消失
   // newpwdValueEditText.userInteractionEnabled=YES;
    
}

-(void)pwdValueEditTextDidEndOnExit:(UITextField *)textField{
     [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
    int count=[textField.text length];
    if(!(count>=6&&count<=12))
    {
       // [self.view makeToast:@"请输入6位密码"];
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        
        msgReturn.errorDesc=@"请输入6到12位密码";//不能为空
        msgReturn.errorType=@"02";
        msgReturn.errorCode=@"-333";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
    }else
    {
        
        [newpwd2ValueEditText becomeFirstResponder];//把焦点给别人 键盘消失
        //newpwd2ValueEditText.userInteractionEnabled=YES;
    }
    
}


-(void)pwd2ValueEditTextDidEndOnExit:(UITextField *)textField{
     [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    int count=[textField.text length];
    if(!(count>=6&&count<=12))
    {
       // [self.view makeToast:@"请输入6位密码"];
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        
        msgReturn.errorDesc=@"请输入6到12位确认密码";//不能为空
        msgReturn.errorType=@"02";
        msgReturn.errorCode=@"-333";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        
    }else if(![newpwd2ValueEditText.text isEqualToString:newpwdValueEditText.text])
    {
        //[self.view makeToast:@"两次密码输入不一致"];
        
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        
        msgReturn.errorDesc=@"两次密码输入不一致";//不能为空
        msgReturn.errorType=@"02";
        msgReturn.errorCode=@"-333";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
    }
    else
    {
        
        [findpwdButton becomeFirstResponder];//把焦点给别人 键盘消失
        //findpwdButton.userInteractionEnabled=YES;
    }
    
}


-(void)rigistButtonlicked:(UIButton *)btn{
    
    
    [self request0005];
    
}


-(void) setUiValue{


}


/*手机验证码发送0053*/
NSString  *nn0053=@"JY0053";
/*手机验证码发送0053*/
-(void) request0053{
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 手机号码 备注:必填*/
    [businessparam setValue:phoneValueEditText.text forKey:@"mobileNo"];
    
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:nn0053 business:businessparam delegate:self viewController:self];
}





/*找回密码 0005*/
NSString  *n0005=@"JY0005";
/*找回密码 0005*/
-(void) request0005{
    


    
    
    if(phoneValueEditText.text==nil || [phoneValueEditText.text isEqualToString:@""])
    {
       // [self.view makeToast:@"请输入手机号"];
        
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        
        msgReturn.errorDesc=@"请输入手机号";//不能为空
        msgReturn.errorType=@"02";
        msgReturn.errorCode=@"-333";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        return;
    }
    

    
    if(codeValueEditText.text==nil || [codeValueEditText.text isEqualToString:@""])
    {
       // [self.view makeToast:@"请输入验证码"];
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        
        msgReturn.errorDesc=@"请输入验证码";//不能为空
        msgReturn.errorType=@"02";
        msgReturn.errorCode=@"-333";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        return;
    }
    
    if(newpwdValueEditText.text==nil || [newpwdValueEditText.text isEqualToString:@""])
    {
        //[self.view makeToast:@"请输入密码"];
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        
        msgReturn.errorDesc=@"请输入密码";//不能为空
        msgReturn.errorType=@"02";
        msgReturn.errorCode=@"-333";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        return;
    }
    
    
    int count1=[newpwdValueEditText.text length];
    if( !(count1>=6&&count1<=12))
    {
        //[self.view makeToast:@"请输入密码"];
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        
        msgReturn.errorDesc=@"请输入6到12位密码";//不能为空
        msgReturn.errorType=@"02";
        msgReturn.errorCode=@"-333";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        return;
    }
    
    if(newpwd2ValueEditText.text==nil || [newpwd2ValueEditText.text isEqualToString:@""])
    {
        //[self.view makeToast:@"请输入确认密码"];
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        
        msgReturn.errorDesc=@"请输入确认密码";//不能为空
        msgReturn.errorType=@"02";
        msgReturn.errorCode=@"-333";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        return;
    }
    
    int count2=[newpwd2ValueEditText.text length];
    if(  !(count2>=6&&count2<=12))
    {
        //[self.view makeToast:@"请输入确认密码"];
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        
        msgReturn.errorDesc=@"请输入6到12位确认密码";//不能为空
        msgReturn.errorType=@"02";
        msgReturn.errorCode=@"-333";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        return;
    }
    
    if(![newpwd2ValueEditText.text isEqualToString:newpwdValueEditText.text])
    {
        //[self.view makeToast:@"两次密码输入不一致"];
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        
        msgReturn.errorDesc=@"两次密码输入不一致";//不能为空
        msgReturn.errorType=@"02";
        msgReturn.errorCode=@"-333";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        return;
    }

    
    
NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
/* 手机号码 备注:必填*/
[businessparam setValue:phoneValueEditText.text forKey:@"mobileNo"];
/* 手机验证码 备注:必填*/
[businessparam setValue:codeValueEditText.text forKey:@"verificationCode"];
/* 新密码 备注:必填*/
[businessparam setValue:newpwdValueEditText.text forKey:@"newPassWord"];
    
    
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0005 business:businessparam delegate:self viewController:self];
 }



-(void) ReturnError:(MsgReturn*)msgReturn
{
}

-(void) ReturnData:(MsgReturn*)msgReturn
{
    
    //NSMutableArray *listData=[[NSMutableArray alloc]init];
    /*手机验证码发送0053*/
    if ([msgReturn.formName isEqualToString:nn0053]){
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnBody=[returnData objectForKey:@"returnBody"];
        RespondParam0053 *commonItem=[[RespondParam0053 alloc]init];
        
//        getcodeButton.enabled=YES;
//        codeValueEditText.enabled=YES;
//        newpwdValueEditText.enabled=YES;
//        newpwd2ValueEditText.enabled=YES;
//        findpwdButton.enabled=YES;
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            MsgReturn *msgReturn=[[MsgReturn alloc]init];
            
            
            msgReturn.errorDesc=@"验证码获取成功";//不能为空
            msgReturn.errorType=@"02";
            msgReturn.errorCode=@"-333";
            
            [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
            

        });
        
    }
    
    
    /*找回密码 0005*/
    if ([msgReturn.formName isEqualToString:n0005]){
    NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
    NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
    NSString *respDesc=[returnHead objectForKey:@"respDesc"];
    NSString *respCode=[returnHead objectForKey:@"respCode"];
    NSDictionary *returnBody=[returnData objectForKey:@"returnBody"];
    RespondParam0005 *commonItem=[[RespondParam0005 alloc]init];
        
        //[self.view makeToast:@"找回密码成功"];
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        msgReturn.errorCode=@"-334";//是否确认删除
        msgReturn.errorDesc=@"找回密码成功";
        msgReturn.errorType=@"01";
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel)
         {
             [self dismissViewControllerAnimated:NO completion:^{
                 
             }];

         }
         ];

        
        
    }

    

}

#pragma mark -UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];//得到输入框的内容
    if (textField==self.phoneValueEditText)
    {//身份证号
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:kNum] invertedSet];
        NSString * filtered =[[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        NSLog(@"filtered:%@",filtered);
        BOOL basic =[string isEqualToString:filtered];
        if (basic)
        {
            if ([toBeString length] >= 12)
            { //如果输入框内容大于7则禁止输入
                [self.phoneValueEditText resignFirstResponder];
                [self.codeValueEditText becomeFirstResponder];
                return NO;
            }
            self.phoneValueEditText.text =[toBeString stringByReplacingOccurrencesOfString:@" " withString:@""];        }
        else
        {
            NSString *tt =[toBeString substringWithRange:NSMakeRange(toBeString.length-1, 1)];
            self.phoneValueEditText.text =[toBeString stringByReplacingOccurrencesOfString:tt withString:@""];
        }
        return NO;

    }
    return YES;
}



@end



//NSMutableArray *listData=[[NSMutableArray alloc]init];



