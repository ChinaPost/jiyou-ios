


#import "RelateMobilePhoneViewController.h"
#import "UIImageView+WebCache.h"
#import <Foundation/Foundation.h>
#import <PublicFramework/JSONKit.h>
#import <objc/runtime.h>
#import "RespondParam0002.h"
#import "RespondParam0009.h"
#import "RespondParam0053.h"
#import "PromptError.h"
#import "CstmMsg.h"
#import "SysBaseInfo.h"
#import "StampTranCall.h"
#import "ProductOrderForm.h"
@implementation RelateMobilePhoneViewController


//back
@synthesize backImageView;
//back
@synthesize backButton;
//关联手机号
@synthesize titleTextView;
//手机号码：
@synthesize phoneTitleTextView;
//请输入新的手机号
@synthesize phoneValueEditText;
//验证码：
@synthesize validateTitleTextView;
//请输入验证码
@synthesize validateValueEditText;
//获取验证码
@synthesize getValidateButton;
//关联
@synthesize relateButton;




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*手机验证码发送0053*/
   nnn0053=@"JY0053";
    /*手机号码唯一校验0002*/
   n0002=@"JY0002";
   /*注册手机号码修改0009*/
    n0009=@"JY0009";
     secondsCountDown2 = 60;//60秒倒计时
    

[self.backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

 
self.phoneValueEditText.returnKeyType=UIReturnKeyDone;
    self.phoneValueEditText.keyboardType=UIKeyboardTypePhonePad;


[self.phoneValueEditText addTarget:self action:@selector(phoneValueEditTextDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];

[self.phoneValueEditText addTarget:self action:@selector(phoneValueEditTextDidEnd:) forControlEvents:UIControlEventEditingDidEnd];

    UITapGestureRecognizer *phoneValueEditTextTapGuest=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editTextTapHandle:)];
phoneValueEditTextTapGuest.delegate = self;//头文<UIGestureRecognizerDelegate>
    [ self.phoneValueEditText  addGestureRecognizer:phoneValueEditTextTapGuest];


 
self.validateValueEditText.returnKeyType=UIReturnKeyDone;


[self.validateValueEditText addTarget:self action:@selector(validateValueEditTextDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];

[self.validateValueEditText addTarget:self action:@selector(validateValueEditTextDidEnd:) forControlEvents:UIControlEventEditingDidEnd];

    UITapGestureRecognizer *validateValueEditTextTapGuest=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editTextTapHandle:)];
validateValueEditTextTapGuest.delegate = self;//头文件<UIGestureRecognizerDelegate>
    [ self.validateValueEditText  addGestureRecognizer:validateValueEditTextTapGuest];


    
[self.getValidateButton addTarget:self action:@selector(getValidateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    
[self.relateButton addTarget:self action:@selector(relateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //键盘顶起
    UITapGestureRecognizer* closeKeyboardtap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKeyboardBlankPlaceTapHandle:)];
    [self.view addGestureRecognizer:closeKeyboardtap];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardDidHideNotification object:nil];
    
}

-(void) viewWillAppear:(BOOL)animated{
}

-(void)backButtonClicked:(UIButton *)btn{
id mId = objc_getAssociatedObject(btn, "mId");
//取绑定数据int mId2 = btn.tag;
//取绑定数据
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
 
}



-(void)phoneValueEditTextDidEndOnExit:(UITextField *)textField{
 [self.view becomeFirstResponder];//把焦点给别人 键盘消失
// int  orderFormIndex= textField.tag;
//     OrderForm *orderform=orderForms[orderFormIndex ];
//     orderform.invoiceMsg=textField.text;
}

-(void)phoneValueEditTextDidEnd:(UITextField *)textField{
 [self.view becomeFirstResponder];//把焦点给别人 键盘消失
//id mId = objc_getAssociatedObject(btn, "mId");
////取绑定数据 int  orderFormIndex= textField.tag;
//     OrderForm *orderform=orderForms[orderFormIndex ];
//     orderform.invoiceMsg=textField.text;
}

-(void)validateValueEditTextDidEndOnExit:(UITextField *)textField{
 [self.view becomeFirstResponder];//把焦点给别人 键盘消失
// int  orderFormIndex= textField.tag;
//     OrderForm *orderform=orderForms[orderFormIndex ];
//     orderform.invoiceMsg=textField.text;
}

-(void)validateValueEditTextDidEnd:(UITextField *)textField{
 [self.view becomeFirstResponder];//把焦点给别人 键盘消失
//id mId = objc_getAssociatedObject(btn, "mId");
////取绑定数据 int  orderFormIndex= textField.tag;
//     OrderForm *orderform=orderForms[orderFormIndex ];
//     orderform.invoiceMsg=textField.text;
}

-(void)getValidateButtonClicked:(UIButton *)btn{
id mId = objc_getAssociatedObject(btn, "mId");
//取绑定数据int mId2 = btn.tag;
//取绑定数据
    
    
    
    
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
    
    if(phoneValueEditText.text.length!=11)
    {
        
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        
        msgReturn.errorDesc=@"请输入11位手机号";//不能为空
        msgReturn.errorType=@"02";
        msgReturn.errorCode=@"-333";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        
        return;
    }
    
    
    
   
    
 
    
    
    secondsCountDown2=60;
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    countDownTimer2 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    btn.userInteractionEnabled=NO;
    
    [self request0002];
}

-(void)timeFireMethod{
    secondsCountDown2--;
    [self.getValidateButton setTitle:[NSString stringWithFormat:@"%d",secondsCountDown2] forState:UIControlStateNormal];
    
    if(secondsCountDown2==0){
        [countDownTimer2 invalidate];
        self.getValidateButton.userInteractionEnabled=YES;
        [self.getValidateButton setTitle:[NSString stringWithFormat:@"%@",@"获取验证码"] forState:UIControlStateNormal];
        
    }
}

-(void)relateButtonClicked:(UIButton *)btn{
id mId = objc_getAssociatedObject(btn, "mId");
//取绑定数据int mId2 = btn.tag;
//取绑定数据
    
    
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
    
    
    if(phoneValueEditText.text.length!=11)
    {
        
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        
        msgReturn.errorDesc=@"请输入11位手机号";//不能为空
        msgReturn.errorType=@"02";
        msgReturn.errorCode=@"-333";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        
        return;
    }
    
    if(validateValueEditText.text==nil || [validateValueEditText.text isEqualToString:@""])
    {
        
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        
        msgReturn.errorDesc=@"请输入验证码";//不能为空
        msgReturn.errorType=@"02";
        msgReturn.errorCode=@"-333";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        
        return;
    }
    
    
    [self request0009];
}

//编辑框键盘顶起start
   float touchy1;
   int   movelength1;
   int  keyboardHeight1;
   bool keyboardOpen;

//注销键盘监听
-(void)viewDidDisappear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    
}

//<UIGestureRecognizerDelegate>
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
    
    
}

//点空白区域键盘消失
-(void)closeKeyboardBlankPlaceTapHandle:(UITapGestureRecognizer *)sender
{
  
    if (keyboardOpen) {
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    }
    
}

//touchY 触摸位置
-(void)editTextTapHandle:(UITapGestureRecognizer *)sender
{
    
     if (keyboardOpen) {
         return;
     }
    
    CGPoint point = [sender locationInView:self.view];
    touchy1=point.y+15;
    
    if(keyboardHeight1>0)
    {
        if(touchy1>keyboardHeight1)
        {
            movelength1=touchy1-keyboardHeight1;
            [self MoveView:(-movelength1)];
        }else
        {
            movelength1=0;
            [self MoveView:(-movelength1)];
        }
    }
    
}

//键盘打开监听回调
- (void)keyboardWillShow:(NSNotification *)notification {
    
    
    keyboardOpen=true;
    /*
     Reduce the size of the text view so that it's not obscured by the keyboard.
     Animate the resize so that it's in sync with the appearance of the keyboard.
     */
    
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    float keyboardTop = keyboardRect.origin.y;
    
    
    
    if(keyboardHeight1==0)
    {
        // Get the duration of the animation.
        NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        NSTimeInterval animationDuration;
        [animationDurationValue getValue:&animationDuration];
        //
        //    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:animationDuration];
        
        keyboardHeight1=keyboardTop;
        
        if(touchy1>keyboardHeight1)
        {
            movelength1=touchy1-keyboardHeight1;
            [self MoveView:(-movelength1)];
        }else
        {
            movelength1=0;
            [self MoveView:(-movelength1)];
        }
    
    
        
           [UIView commitAnimations];
    }
    
    
 
    
    
}

//键盘关闭监听回调
- (void)keyboardWillHide:(NSNotification *)notification {
    
      keyboardOpen=false;
    NSDictionary* userInfo = [notification userInfo];
    
    
    
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the disappearance of the keyboard.
     */
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    
    
    [self MoveView:(movelength1)];
    
    
    [UIView commitAnimations];
}

-(void)MoveView:(int)h{
    
    
    if (h<0) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [self.view setFrame: CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + h, self.view.frame.size.width, self.view.frame.size.height)];
        [UIView commitAnimations];
    }else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [self.view setFrame: CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+h , self.view.frame.size.width, self.view.frame.size.height)];
        [UIView commitAnimations];
    }
    
    
    
}
//编辑框键盘顶起end



/*手机号码唯一校验0002*/
-(void) request0002{
     CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 手机号码 备注:必填*/
    
    [businessparam setValue:phoneValueEditText.text forKey:@"mobileNo"];
    
    
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0002 business:businessparam delegate:self viewController:self];
  
}






/*注册手机号码修改0009*/
-(void) request0009{
     CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 会员编号 备注:必填*/
    [businessparam setValue:_cstmMsg.cstmNo forKey:@"cstmNo"];
    /* 新手机号码 备注:必填*/
    [businessparam setValue:phoneValueEditText.text forKey:@"mobileNo"];
    /* 手机验证码 备注:必填*/
    [businessparam setValue:validateValueEditText.text forKey:@"verificationCode"];
    
      [businessparam setValue:@"0" forKey:@"userSex"];
    
    
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0009 business:businessparam delegate:self viewController:self];

}





/*手机验证码发送0053*/
-(void) request0053{
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 手机号码 备注:必填*/
  
        
        [businessparam setValue:phoneValueEditText.text forKey:@"mobileNo"];
    
    
    
    
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:nnn0053 business:businessparam delegate:self viewController:self];
}


-(void) ReturnError:(MsgReturn*)msgReturn
{

    /*手机号码唯一校验0002*/
    if ([msgReturn.formName isEqualToString:n0002]){
        [countDownTimer2 invalidate];
        self.getValidateButton.userInteractionEnabled=YES;
        [self.getValidateButton setTitle:[NSString stringWithFormat:@"%@",@"获取验证码"] forState:UIControlStateNormal];
    }  /*手机验证码发送0053*/
    else if ([msgReturn.formName isEqualToString:nnn0053]){
        [countDownTimer2 invalidate];
        self.getValidateButton.userInteractionEnabled=YES;
        [self.getValidateButton setTitle:[NSString stringWithFormat:@"%@",@"获取验证码"] forState:UIControlStateNormal];
    }
    
}

-(void) ReturnData:(MsgReturn*)msgReturn
{
    
    

    /*手机号码唯一校验0002*/
    if ([msgReturn.formName isEqualToString:n0002]){
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnBody=[returnData objectForKey:@"returnBody"];
        
        RespondParam0002 *commonItem=[[RespondParam0002 alloc]init];
        
        [self request0053];
    }
    
    
    
    
  
    /*注册手机号码修改0009*/
    if ([msgReturn.formName isEqualToString:n0009]){
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnBody=[returnData objectForKey:@"returnBody"];
        
        RespondParam0009 *commonItem=[[RespondParam0009 alloc]init];
        
        
        ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
        productOrderForm.relateMobilePhone=phoneValueEditText.text;
        
        MsgReturn * msgReturn =[[MsgReturn alloc]init];
        msgReturn.errorCode=@"-0024";
        msgReturn.errorType=@"01";
        msgReturn.errorDesc=@"关联成功";
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){
        
            
             CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
            _cstmMsg.mobileNo=phoneValueEditText.text;
            
            [self dismissViewControllerAnimated:NO completion:^{
                
            }];
        
        }];
    }

    
    
    
    /*手机验证码发送0053*/
    if ([msgReturn.formName isEqualToString:nnn0053]){
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnBody=[returnData objectForKey:@"returnBody"];
        RespondParam0053 *commonItem=[[RespondParam0053 alloc]init];
        
        MsgReturn * msgReturn =[[MsgReturn alloc]init];
        msgReturn.errorCode=@"0024";
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){}];
        
        
        
    }
}




@end//end viewController


