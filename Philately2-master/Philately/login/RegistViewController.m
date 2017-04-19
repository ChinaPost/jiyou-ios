


#import "RegistViewController.h"
#import "UIImageView+WebCache.h"
#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import <MsgReturn.h> 
#import "RespondParam0003.h"
#import "RespondParam0008.h"
#import "RespondParam0053.h"
#import "PromptError.h"
#import "OMGToast.h"
#import "Toast+UIView.h"
#import "BasicClass.h"
#import "RespondParam0004.h"
#import "ProductdetailViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "DateConvert.h"

@implementation RegistViewController
//注册
@synthesize rigistButton;
//back
@synthesize backImageView;
//用户注册
@synthesize titleTextView;
//登录
@synthesize loginButton;
//用户名:
@synthesize userNameTitleTextView;
//请输入用户名
@synthesize userNameValueEditText;
//手机号码:
@synthesize phoneTitleTextView;
//请输入手机号码
@synthesize phoneValueEditText;
//手机验证码:
@synthesize codeTitleTextView;
//请输入手机验证码
@synthesize codeValueEditText;
//重发验证码
@synthesize codepicButton;
//密码:
@synthesize pwdTitleTextView;
//请输入密码
@synthesize pwdValueEditText;
//重复密码
@synthesize pwd2TitleTextView;
//请输入密码
@synthesize pwd2ValueEditText;

NSTimer *countDownTimer ;
int secondsCountDown = 60;//60秒倒计时

- (void)viewDidLoad
{
    [super viewDidLoad];
    
  
    
 
    [self.userNameValueEditText addTarget:self action:@selector(userNameValueEditTextDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
      self.userNameValueEditText.returnKeyType=UIReturnKeyDone;
    [self.phoneValueEditText addTarget:self action:@selector(phoneValueEditTextDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    self.phoneValueEditText.keyboardType=UIKeyboardTypePhonePad;
    
         [self.codeValueEditText addTarget:self action:@selector(codeValueEditTextDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    
    self.codeValueEditText.returnKeyType=UIReturnKeyDone;
    
    
      [self.codeValueEditText addTarget:self action:@selector(codeValueEditTextDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
      self.codeValueEditText.returnKeyType=UIReturnKeyDone;
    
    [self.codepicButton addTarget:self action:@selector(codepicButtonclicked:) forControlEvents:UIControlEventTouchUpInside];
    
       [self.pwdValueEditText addTarget:self action:@selector(pwdValueEditTextDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
      self.pwdValueEditText.returnKeyType=UIReturnKeyDone;
    
  [self.pwd2ValueEditText addTarget:self action:@selector(pwd2ValueEditTextDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
    
    [self.rigistButton addTarget:self action:@selector(rigistButtonlicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.pwd2ValueEditText addTarget:self action:@selector(pwd2ValueEditTextDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    self.pwd2ValueEditText.returnKeyType=UIReturnKeyDone;
    
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backImageViewTap)];
    [backImageView addGestureRecognizer:singleTap1];
    
    
    phoneValueEditText.enabled=NO;
    codeValueEditText.enabled=NO;
    pwdValueEditText.enabled=NO;
    pwd2ValueEditText.enabled=NO;
    rigistButton.enabled=NO;
    
    [self.checkUser addTarget:self action:@selector(checkUserClick:) forControlEvents:UIControlEventTouchUpInside];
 
    UITapGestureRecognizer* closeKeyboardtap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKeyboard)];
    [self.view addGestureRecognizer:closeKeyboardtap];

    
}

-(void)closeKeyboard
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
-(void)checkUserClick:(UIButton*)btn
{
    
    
    if(userNameValueEditText.text==nil || [userNameValueEditText.text isEqualToString:@""])
    {
        //[self.view makeToast:@"请输入用户名"];
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        
        msgReturn.errorDesc=@"请输入用户名";//不能为空
        msgReturn.errorType=@"02";
        msgReturn.errorCode=@"-333";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        return ;
    }
    
    
 
//    NSString *regex = @"[a-zA-Z0-9_\u4e00-\u9fa5]+$";
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    BOOL isValid = [predicate evaluateWithObject:userNameValueEditText.text];
//    
    if(![DateConvert isCommonChar:userNameValueEditText.text])
    {
        //[self.view makeToast:@"请输入用户名"];
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        
        msgReturn.errorDesc=@"用户名格式不正确";//不能为空
        msgReturn.errorType=@"01";
        msgReturn.errorCode=@"-0078";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        return ;
    }
    
    
    
      [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
    [self request0001];
}


-(void)backImageViewTap
{


[self dismissViewControllerAnimated:YES completion:^{}];
    [self.navigationController popViewControllerAnimated:NO];
    
    

}

-(void)timeFireMethod{
    
    secondsCountDown--;
     [self.codepicButton setTitle:[NSString stringWithFormat:@"%d",secondsCountDown] forState:UIControlStateNormal];
    
    if(secondsCountDown==0){
        [countDownTimer invalidate];
         self.codepicButton.enabled=YES;
      [self.codepicButton setTitle:[NSString stringWithFormat:@"%@",@"获取验证码"] forState:UIControlStateNormal];
        
    }
}

-(void)codeValueEditTextDidBegin:(UITextField*)txt
{
 


}

-(void)codepicButtonclicked:(UIButton *)btn{
    if (countDownTimer!=nil &&  [countDownTimer isValid]) {
        return;
    }
    
    
    

    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
    
   
    
    [self request0002];
    
   
}



-(void)userNameValueEditTextDidEndOnExit:(UITextField *)textField{
    //[phoneValueEditText becomeFirstResponder];//把焦点给别人 键盘消失
     [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    //[self request0001];
    
}




-(void)phoneValueEditTextDidEndOnExit:(UITextField *)textField{
   // [codeValueEditText becomeFirstResponder];//把焦点给别人 键盘消失
     [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
   
    
}

-(void)codeValueEditTextDidEndOnExit:(UITextField *)textField{
     [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
   //[pwdValueEditText becomeFirstResponder];//把焦点给别人 键盘消失
    pwdValueEditText.enabled=YES;
    
}


-(void)pwdValueEditTextDidEndOnExit:(UITextField *)textField{
     [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
    int count2=[textField.text length];
    if(!(count2>=6&&count2<=12))
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
    
    [pwd2ValueEditText becomeFirstResponder];//把焦点给别人 键盘消失
    pwd2ValueEditText.enabled=YES;
    }
    
}


-(void)pwd2ValueEditTextDidEndOnExit:(UITextField *)textField{
    
     [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
    int count2=[textField.text length];
    if(!(count2>=6&&count2<=12))
    {
        //[self.view makeToast:@"请输入6位密码"];
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        
        msgReturn.errorDesc=@"请输入6到12位密码";//不能为空
        msgReturn.errorType=@"02";
        msgReturn.errorCode=@"-333";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        
    }else if(![pwd2ValueEditText.text isEqualToString:pwdValueEditText.text])
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
        
        [rigistButton becomeFirstResponder];//把焦点给别人 键盘消失
        rigistButton.enabled=YES;
    }
    
}

-(void)rigistButtonlicked:(UIButton *)btn{
    
  
    [self request0003];
    
}



-(void) viewWillAppear:(BOOL)animated{
}


-(void) setUiValue{

}


/*用户名唯一校验0001*/
NSString  *n0001=@"JY0001";
/*用户名唯一校验0001*/
-(void) request0001{
    
    
    if(userNameValueEditText.text==nil || [userNameValueEditText.text isEqualToString:@""])
    {
        //[self.view makeToast:@"请输入用户名"];
        return ;
    }
    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 用户名 备注:必填*/
    [businessparam setValue:userNameValueEditText.text forKey:@"userName"];
    
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0001 business:businessparam delegate:self viewController:self];

    
}




/*手机号码唯一校验0002*/
NSString  *n0002=@"JY0002";
/*手机号码唯一校验0002*/
-(void) request0002{

    if(phoneValueEditText.text==nil || [phoneValueEditText.text isEqualToString:@""])
    {
        
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
//        msgReturn.errorDesc=@"验证码接收手机:格式不正确"";//不能为空
//        msgReturn.errorType=@"02";
//        msgReturn.errorCode=@"-333";
//        msgReturn.errorPic=true;
//        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
//        
//        return;
//    }

    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 手机号码 备注:必填*/
    [businessparam setValue:phoneValueEditText.text forKey:@"mobileNo"];
    
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0002 business:businessparam delegate:self viewController:self];

    }




/*用户注册0003*/
NSString  *n0003=@"JY0003";
/*用户注册0003*/
-(void) request0003{
    
    
    if(userNameValueEditText.text==nil || [userNameValueEditText.text isEqualToString:@""])
    {
        //[self.view makeToast:@"请输入用户名"];
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        
        msgReturn.errorDesc=@"请输入用户名";//不能为空
        msgReturn.errorType=@"02";
        msgReturn.errorCode=@"-333";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        return ;
    }
    
  
    
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
    
    if(pwdValueEditText.text==nil || [pwdValueEditText.text isEqualToString:@""])
    {
       // [self.view makeToast:@"请输入密码"];
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        
        msgReturn.errorDesc=@"请输入密码";//不能为空
        msgReturn.errorType=@"02";
        msgReturn.errorCode=@"-333";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        return;
    }
    
    
    int count2=[pwdValueEditText.text length];
    if(!(count2>=6&&count2<=12))
    {
       // [self.view makeToast:@"请输入6位密码"];
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        
        msgReturn.errorDesc=@"请输入6到12位密码";//不能为空
        msgReturn.errorType=@"02";
        msgReturn.errorCode=@"-333";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        return ;
    }
    
    if(pwd2ValueEditText.text==nil || [pwd2ValueEditText.text isEqualToString:@""])
    {
       // [self.view makeToast:@"请输入确认密码"];
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        
        msgReturn.errorDesc=@"请输入确认密码";//不能为空
        msgReturn.errorType=@"02";
        msgReturn.errorCode=@"-333";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        return;
    }
    
    int count3=[pwd2ValueEditText.text length];
    if(   !(count3>=6&&count3<=12))
    {
        // [self.view makeToast:@"请输入确认密码"];
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        
        msgReturn.errorDesc=@"请输入6到12位确认密码";//不能为空
        msgReturn.errorType=@"02";
        msgReturn.errorCode=@"-333";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        return;
    }
    
    if(![pwd2ValueEditText.text isEqualToString:pwdValueEditText.text])
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
    /* 用户名 备注:必填*/
    [businessparam setValue:userNameValueEditText.text forKey:@"userName"];
    /* 手机号码 备注:必填*/
    [businessparam setValue:phoneValueEditText.text forKey:@"mobileNo"];
    /* 密码 备注:必填*/
    [businessparam setValue:pwdValueEditText.text forKey:@"passWord"];
    /* 手机验证码 备注:必填*/
    [businessparam setValue:codeValueEditText.text forKey:@"verificationCode"];
   
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    _sysBaseInfo.isOpenLoading=true;
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0003 business:businessparam delegate:self viewController:self];
}




/*手机验证码发送0053*/
NSString  *n0053=@"JY0053";
/*手机验证码发送0053*/
-(void) request0053{
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 手机号码 备注:必填*/
    [businessparam setValue:phoneValueEditText.text forKey:@"mobileNo"];
    
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0053 business:businessparam delegate:self viewController:self];
}





-(void) ReturnError:(MsgReturn*)msgReturn
{
    
     if ([msgReturn.formName isEqualToString:n0053] ||[msgReturn.formName isEqualToString:n0002]  ){
         secondsCountDown=60;
          [countDownTimer invalidate];
         
            [self.codepicButton setTitle:[NSString stringWithFormat:@"%@",@"获取验证码"] forState:UIControlStateNormal];
     }
}

-(void) ReturnData:(MsgReturn*)msgReturn
{
    
   // NSMutableArray *listData=[[NSMutableArray alloc]init];
    /*用户名唯一校验0001*/
    if ([msgReturn.formName isEqualToString:n0001]){
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnBody=[returnData objectForKey:@"returnBody"];
        

        //[self.view makeToast:@"用户名校验成功,请输入手机号"];
        
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        
        msgReturn.errorDesc=@"用户名校验成功,请输入手机号";//不能为空
        msgReturn.errorType=@"02";
        msgReturn.errorCode=@"-333";
        
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        
        phoneValueEditText.enabled=YES;
         [codepicButton setHidden:NO];
     
    }
    
    
    
    
    //NSMutableArray *listData=[[NSMutableArray alloc]init];
    /*手机号码唯一校验0002*/
    if ([msgReturn.formName isEqualToString:n0002]){
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnBody=[returnData objectForKey:@"returnBody"];
        //[self.view makeToast:@"手机号校验成功,请获取验证码"];
        
 
        
       // RespondParam0002 *commonItem=[[RespondParam0002 alloc]init];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            secondsCountDown=60;
              [countDownTimer invalidate];
                countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
            [self request0053];
        });
        
    }
    
    
    
    
    //NSMutableArray *listData=[[NSMutableArray alloc]init];
    /*用户注册0003*/
    if ([msgReturn.formName isEqualToString:n0003]){
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        RespondParam0003 *commonItem=[[RespondParam0003 alloc]init];
        /* 会员编号 备注:*/
        commonItem.cstmNo=[returnDataBody objectForKey:@"cstmNo"];
        if(commonItem.cstmNo!=nil && ![commonItem.cstmNo isEqualToString:@""])
        // [self.view makeToast:@"注册成功"];
            [self request0004];
    

        
       
       
    }
    
    
    
    
    //NSMutableArray *listData=[[NSMutableArray alloc]init];
    /*手机验证码发送0053*/
    if ([msgReturn.formName isEqualToString:n0053]){
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnBody=[returnData objectForKey:@"returnBody"];
        RespondParam0053 *commonItem=[[RespondParam0053 alloc]init];
        
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        msgReturn.errorCode=@"-334";//是否确认删除
        msgReturn.errorDesc=@"验证码发送成功,请查收";
        msgReturn.errorType=@"02";
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel)
         {
             
             
         }
         ];

        
        codeValueEditText.enabled=YES;
        pwdValueEditText.enabled=YES;
        pwd2ValueEditText.enabled=YES;
        pwd2ValueEditText.returnKeyType=UIReturnKeyDone;
        pwdValueEditText.returnKeyType=UIReturnKeyDone;
        rigistButton.enabled=YES;
    }
    
    
    
    
    
    
    
    
    /*会员登录0004*/
    if ([msgReturn.formName isEqualToString:nn0004]){
        
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnBody=[returnData objectForKey:@"returnBody"];
        
        RespondParam0004 *commonItem=[[RespondParam0004 alloc]init];
        /* 会员编号 备注:*/
        commonItem.cstmNo=[returnBody objectForKey:@"cstmNo"];
        /* 用户名 备注:*/
        commonItem.userName=[returnBody objectForKey:@"userName"];
        CstmMsg *cstmMsg=[CstmMsg sharedInstance];
        cstmMsg.cstmNo= commonItem.cstmNo;
        cstmMsg.cstmName=commonItem.userName;
        
        
//        if (self.remenberPwd.selected) {
//            
//            NSString *pwd= [pwdValueEditText text];
//            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//            [ud setObject:pwd forKey:@"pwd"];
//            [ud synchronize];
//        }else
//        {
//            
//            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//            [ud setObject:@"" forKey:@"pwd"];
//            [ud synchronize];
//        }
        
        
        if(commonItem.cstmNo!=nil)
        {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self request0008 ];
            });
            
            
        }
        
        
    }
    
    /*会员资料标准查询0008*/
    if ([msgReturn.formName isEqualToString:nn0008]){
        if(msgReturn.map==nil)
            return;
        
        NSLog(@"0008 %lu",(unsigned long)[msgReturn.map count]);
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        
        CstmMsg *cst=[CstmMsg sharedInstance];
        RespondParam0008 *commonItem=[[RespondParam0008 alloc]init];
        /* 用户头像图片ID 备注:用户头像URL地址*/
        commonItem.userPicID=[returnDataBody objectForKey:@"userPicID"];
        cst.userPicID=commonItem.userPicID;
        /* 用户名 备注:*/
        commonItem.userName=[returnDataBody objectForKey:@"userName"];
        cst.userName=commonItem.userName;
        /* 手机号码 备注:注册手机号码*/
        commonItem.mobileNo=[returnDataBody objectForKey:@"mobileNo"];
        cst.mobileNo=commonItem.mobileNo;
        /* 性别 备注:0：男
         1：女*/
        commonItem.userSex=[returnDataBody objectForKey:@"userSex"];
        cst.userSex=commonItem.userSex;
        /* 邮箱 备注:*/
        commonItem.email=[returnDataBody objectForKey:@"email"];
        cst.email=commonItem.email;
        /* 会员积分 备注:*/
        commonItem.cstmScore=[returnDataBody objectForKey:@"cstmScore"];
        cst.cstmScore=[NSString stringWithFormat:@"%d",commonItem.cstmScore];
        /* 是否历史集邮统版会员 备注:0：是
         1：否*/
        commonItem.isStampMember=[returnDataBody objectForKey:@"isStampMember"];
        cst.isStampMember=commonItem.isStampMember;
        /* 是否实名认证 备注:0：是
         1：否*/
        commonItem.isAutonym=[returnDataBody objectForKey:@"isAutonym"];
        cst.isAutonym=commonItem.isAutonym;
        /* 姓名 备注:未经过实名验证的会员这几项为空*/
        commonItem.cstmName=[returnDataBody objectForKey:@"cstmName"];
        cst.cstmName=commonItem.cstmName;
        /* 身份证号码 备注:*/
        commonItem.certNo=[returnDataBody objectForKey:@"certNo"];
        cst.certNo=commonItem.certNo;
        /* 认证手机号码 备注:*/
        commonItem.verifiMobileNo=[returnDataBody objectForKey:@"verifiMobileNo"];
        cst.verifiMobileNo=commonItem.verifiMobileNo;
        /* 省份代号 备注:2015/6/17 增加*/
        commonItem.provCode=[returnDataBody objectForKey:@"provCode"];
        cst.provCode =commonItem.provCode;
        /* 市代号 备注:2015/6/17增加*/
        commonItem.cityCode=[returnDataBody objectForKey:@"cityCode"];
        cst.cityCode=commonItem.cityCode;
        /* 县代号 备注:2015/6/17增加*/
        commonItem.countCode=[returnDataBody objectForKey:@"countCode"];
        cst.countCode=commonItem.countCode;
        /* 详细地址 备注:2015/6/17增加*/
        commonItem.detailAddress=[returnDataBody objectForKey:@"detailAddress"];
        cst.detailAddress =commonItem.detailAddress;
        /* 邮编 备注:2015/6/17增加*/
        commonItem.postCode=[returnDataBody objectForKey:@"postCode"];
        cst.postCode =commonItem.postCode;
        /* 营业员联系方式（营业员编号） 备注:2015/6/17 增加*/
        commonItem.brchMobNum=[returnDataBody objectForKey:@"brchMobNum"];
        cst.brchMobNum=commonItem.brchMobNum;
        /* 新邮自提机构代码 备注:2015/6/17增加*/
        commonItem.sinceBrchNo=[returnDataBody objectForKey:@"sinceBrchNo"];
        cst.sinceBrchNo =commonItem.sinceBrchNo;
        /* 零售自提机构代码 备注:2015/6/17增加*/
        commonItem.saleBrchNo=[returnDataBody objectForKey:@"saleBrchNo"];
        cst.saleBrchNo =commonItem.saleBrchNo;
        
        
        //        sinceBrchName	新邮自提机构名称	字符	10	2015/8/21 新增
        
        cst.sinceBrchName =[returnDataBody objectForKey:@"sinceBrchName"];
        //        sinceBrchAddress	新邮自提机构地址	字符	200	2015/8/21 新增
        
        cst.sinceBrchAddress =[returnDataBody objectForKey:@"sinceBrchAddress"];
        //        saleBrchName	零售自提机构名称	字符	10	2015/8/21 新增
        cst.saleBrchName = [returnDataBody objectForKey:@"saleBrchName"];
        
        //        saleBrchAddress	零售自提机构地址	字符	100	2015/8/21 新增
        cst.saleBrchAddress =  [returnDataBody objectForKey:@"saleBrchAddress"];
        
        
        
        
        /* 关联终端数量 备注:循环域开始*/
        commonItem.termNum=[returnDataBody objectForKey:@"termNum"];
        /* 关联终端类型 备注:01：adnroid
         02：ios
         03：微信*/
        commonItem.termType=[returnDataBody objectForKey:@"termType"];
        /* 关联终端编号 备注:微信类型的终端编号为Openid*/
        commonItem.termNo=[returnDataBody objectForKey:@"termNo"];
        /* 关联终端数量 备注:循环域结束*/
        commonItem.termNum=[returnDataBody objectForKey:@"termNum"];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
                
                                MsgReturn *msgReturn=[[MsgReturn alloc]init];
                
                
                                    msgReturn.errorCode=@"-0001";//不能为空
                                msgReturn.errorDesc=@"注册成功";
                                msgReturn.errorType=@"02";
                                    [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
            
            
            if (self.navigationController.viewControllers!=nil) {
                for (UIViewController* view in self.navigationController.viewControllers) {
                    if ([view isKindOfClass:[ProductdetailViewController class]]) {
                        
                        [((ProductdetailViewController*)view) viewDidLoad];
                        [self.navigationController popToViewController:view animated:YES];
                        
                    }
                }
            }else
            {  [self dismissViewControllerAnimated:NO completion:^(){}];
                
                AppDelegate *appDelegate1 = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                
                if(appDelegate1.loginView!=nil)
                {
                    
                    [appDelegate1.loginView dismissViewControllerAnimated:NO completion:^(){}];
                }
                
            }

            
        });
        
        
    }
    

    
   
}






/*会员登录0004*/
NSString  *nn0004=@"JY0004";
/*会员登录0004*/
-(void) request0004 {
    
    NSString *userName= [userNameValueEditText text];
    
 
    
    NSString *pwd= [pwdValueEditText text];
    
    
    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 登录号 备注:必填*/
    [businessparam setValue:userName forKey:@"loginNo"];
    /* 密码 备注:必填*/
    [businessparam setValue:pwd forKey:@"passWord"];
    
    
    
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    _sysBaseInfo.isOpenLoading=true;
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:nn0004 business:businessparam delegate:self viewController:self];
    
    
}





StampTranCall *stampTranCall;
/*会员资料标准查询0008*/
NSString  *nn0008=@"JY0008";
/*会员资料标准查询0008*/
-(void) request0008{
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 会员编号 备注:必填*/
    [businessparam setValue:_cstmMsg.cstmNo forKey:@"cstmNo"];
    /* 手机号码 备注:必填*/
    [businessparam setValue:@"" forKey:@"mobileNo"];
    //[serviceInvoker callWebservice:businessparam formName:n0008 ];
    
    
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    _sysBaseInfo.isOpenLoading=false;
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:nn0008 business:businessparam delegate:self viewController:self];
    
}







@end






