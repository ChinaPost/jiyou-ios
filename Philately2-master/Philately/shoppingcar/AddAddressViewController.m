//注入网络请求,响应,等待提示



#import "AddAddressViewController.h"
#import "UIImageView+WebCache.h"
#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import "DropDownViewController.h"
#import "SqlApp.h"
#import <objc/runtime.h>
#import "PromptError.h"

@implementation AddAddressViewController
//back
@synthesize backButton;
//新建地址
@synthesize titleTextView;
//保存
@synthesize saveButton;
//必填
@synthesize mustinputImageView;
//姓名
@synthesize usernameTitleTextView;
//最少两个字
@synthesize usernameValueEditText;
//lineblack
@synthesize lineblackImageView;
//手机
@synthesize phoneTitleTextView;
//请输入手机号码
@synthesize phoneValueTextView;
//地区
@synthesize areaTitleTextView;
//广东
@synthesize provinceTextView;
//down
@synthesize downImageView;
//东莞
@synthesize cityTextView;
//虎门
@synthesize streemTextView;
//地址
@synthesize addressTitleTextView;
//最少五个字，精确到门牌号
@synthesize addressValueTextView;
//邮编:
@synthesize areacodeTitleTextView;
//6位邮政编码
@synthesize areacodeValueEditText;
//check
@synthesize checkButton;
//设为默认地址
@synthesize defaultTextView;

NSString *proviendCode;
NSString *cityCode;
NSString *streemCode;

- (void)viewDidLoad
{
    [super viewDidLoad];
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handTap)];
    //[self.modifyPwdTextView addGestureRecognizer:tap];
    
    dropDown=nil;
 
    
  
    [self.provinceTextView addTarget:self action:@selector(provinceTextViewhandTap:) forControlEvents:UIControlEventTouchUpInside];
    

    [self.cityTextView addTarget:self action:@selector(cityTextViewhandTap:) forControlEvents:UIControlEventTouchUpInside];
    
  
    [self.streemTextView addTarget:self action:@selector(streemTextViewhandTap:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.checkButton  setBackgroundImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    [self.checkButton  setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateSelected];
    
      [self.checkButton addTarget:self action:@selector(checkButtonhandTap:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
      [self.backButton addTarget:self action:@selector(backButtonhandTap:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
      [self.saveButton addTarget:self action:@selector(saveButtonhandTap:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tfname addTarget:self action:@selector(tfnameclick:) forControlEvents:UIControlEventEditingDidEndOnExit];
       self.tfname.returnKeyType=UIReturnKeyDone;
    
    [self.tfmobile addTarget:self action:@selector(tfmobileclick:) forControlEvents:UIControlEventEditingDidEndOnExit];
     self.tfmobile.returnKeyType=UIReturnKeyDone;
    
    [self.tfaddr addTarget:self action:@selector(tfaddrclick:) forControlEvents:UIControlEventEditingDidEndOnExit];
     self.tfaddr.returnKeyType=UIReturnKeyDone;
    
   [ self.tfpostcode addTarget:self action:@selector(tfpostcodeclick:) forControlEvents:UIControlEventEditingChanged];
    
   [ self.tfpostcode addTarget:self action:@selector(tfpostcodeclickEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    self.tfpostcode.returnKeyType=UIReturnKeyDone;
   
    
}

-(void)tfpostcodeclickEndOnExit:(UITextField*)textField
{
[self.view  becomeFirstResponder];

}

-(void)tfpostcodeclick:(UITextField*)textField
{
    //[self.view  becomeFirstResponder];
    

        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
        }

}

-(void)tfaddrclick:(UITextField*)txt
{
    [self.view  becomeFirstResponder];
}

-(void)tfmobileclick:(UITextField*)txt
{
    [self.view  becomeFirstResponder];
}

-(void)tfnameclick:(UITextField*)txt
{
    [self.view  becomeFirstResponder];
}


-(void)backButtonhandTap:(UIButton*)btn
{
  [self dismissViewControllerAnimated:NO completion:^{
      
  }];
}




-(void)checkButtonhandTap:(UIButton*)btn{
      btn.selected=!btn.selected;
    
    
}

-(void)provinceTextViewhandTap:(UIButton*)btn{

    btn.selected=!btn.selected;
    
    if (btn.selected) {
        if(dropDown==nil )
        {
            dropDown = [[DropDownViewController alloc]initWithNibName:@"DropDownViewController" bundle:nil];
          
         [self.view addSubview:dropDown.view];
          
            
        }
        
        [dropDown setParentView:btn name:@"pro" delegate:self];
        
        SqlApp *sqlApp=[[SqlApp alloc ]init ];
        NSMutableArray *arr=[sqlApp selectPM_REGION:@"000000" withLevel:@"2"];
        [dropDown setUiValue:arr];
        
        dropDown.view.hidden=false;
    }else
    {
        dropDown.view.hidden=true;
        
    }
}

-(void)cityTextViewhandTap:(UIButton*)btn{
    
    btn.selected=!btn.selected;
    
    if (btn.selected) {
        if(dropDown==nil )
        {
            
            
          dropDown = [[DropDownViewController alloc]initWithNibName:@"DropDownViewController" bundle:nil];
            
            [self.view addSubview:dropDown.view];
          
            
        }
        
        [dropDown setParentView:btn name:@"city" delegate:self];
        
        SqlApp *sqlApp=[[SqlApp alloc ]init ];
        NSMutableArray *arr=[sqlApp selectPM_REGION:proviendCode withLevel:@"3"];
        
        [dropDown setUiValue:arr];
        
        if (arr==nil || [arr count]<0) {
            
        }else
        {
            dropDown.view.hidden=false;
        }
    }else
    {
        dropDown.view.hidden=true;
        
    }
}

-(void)streemTextViewhandTap:(UIButton*)btn{
    
    btn.selected=!btn.selected;
    
    if (btn.selected) {
        if(dropDown==nil )
        {

         dropDown = [[DropDownViewController alloc]initWithNibName:@"DropDownViewController" bundle:nil];
        
           [self.view addSubview:dropDown.view];
        }
        
       [dropDown setParentView:btn name:@"streem" delegate:self];
        
        SqlApp *sqlApp=[[SqlApp alloc ]init ];
        NSMutableArray *arr=[sqlApp selectPM_REGION:cityCode withLevel:@"4"];
        
        [dropDown setUiValue:arr];
        
        if (arr==nil || [arr count]<0) {
            
        }else
        {
        dropDown.view.hidden=false;
        }
    }else
    {
        dropDown.view.hidden=true;
        
    }

}


-(void) dropDownCallBack:(NSString *)code name:(NSString *)name selectWhich:(int)selectWhich
{

    if ([name isEqualToString:@"pro"]) {
        proviendCode=code;
        
    }
    
    
    if ([name isEqualToString:@"city"]) {
        cityCode=code;
        
    }
    
    if ([name isEqualToString:@"streem"]) {
        streemCode=code;
        
    }
}

-(void) viewWillAppear:(BOOL)animated{
}


-(void) setUiValue{


}






// 下拉
DropDownViewController *dropDown ;




//保存
- (void)saveButtonhandTap:(id)sender {
   [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    MsgReturn *msgReturn=[[MsgReturn alloc]init];
    
    if(self.tfname.text==nil ||[self.tfname.text isEqualToString:@""])
    {
        msgReturn.errorCode=@"0001";//不能为空
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
    }
    if(self.tfmobile.text==nil ||[self.tfmobile.text isEqualToString:@""])
    {
        msgReturn.errorCode=@"0001";//不能为空
        [PromptError changeShowErrorMsg:msgReturn title:@"手机号码"  viewController:self block:^(BOOL OKCancel){}];
        return;
    }
    else
    {
        if (self.tfmobile.text.length<11) {
            msgReturn.errorCode=@"0002";//长度过短
             msgReturn.errorPic=true;
            [PromptError changeShowErrorMsg:msgReturn title:@"手机号码"  viewController:self block:^(BOOL OKCancel){}];
            return;
        }
    }
    if(proviendCode==nil
       ||[proviendCode isEqualToString:@""])
    {
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        msgReturn.errorCode=@"0001";//不能为空
        [PromptError changeShowErrorMsg:msgReturn title:@"省份"  viewController:self block:^(BOOL OKCancel){}];
        return;
    }
    if(cityCode ==nil
       ||[cityCode isEqualToString:@""])
    {
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        msgReturn.errorCode=@"0001";//不能为空
        [PromptError changeShowErrorMsg:msgReturn title:@"城市"  viewController:self block:^(BOOL OKCancel){}];
        return;
    }
    if(streemCode==nil
       ||[streemCode isEqualToString:@""])
    {
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        msgReturn.errorCode=@"0001";//不能为空
        [PromptError changeShowErrorMsg:msgReturn title:@"区县"  viewController:self block:^(BOOL OKCancel){}];
        return;
    }
    if(self.tfaddr.text==nil ||[self.tfaddr.text isEqualToString:@""])
    {
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        msgReturn.errorCode=@"0001";//不能为空
        [PromptError changeShowErrorMsg:msgReturn title:@"地址"  viewController:self block:^(BOOL OKCancel){}];        return;
    }
    else
    {
        if (self.tfaddr.text.length<5) {
            msgReturn.errorCode=@"0002";//长度过短
            msgReturn.errorPic=true;
            [PromptError changeShowErrorMsg:msgReturn title:@"地址"  viewController:self block:^(BOOL OKCancel){}];
            return;
        }
    }
    
    
    [self request0012];
}


/*新增收货地址0012*/
NSString  *nn0012=@"JY0012";
/*新增收货地址0012*/
-(void) request0012{
    
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    
    NSString *recvname = self.tfname.text;
    NSString*provcode = proviendCode;
    NSString*citycode =  cityCode;
    NSString*countcode = streemCode;
    NSString*detailaddr = self.tfaddr.text;
    NSString*mobileno = self.tfmobile.text;
    NSString*postcode = self.tfpostcode.text;
    
    NSString *isdefaultaddr = @"1";
    if(checkButton.selected)
    {
        isdefaultaddr=@"0";
    }else
    {
    isdefaultaddr=@"1";
    }

    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 会员编号 必填*/
    [businessparam setValue:_cstmMsg.cstmNo forKey:@"cstmNo"];
    /* 收货人姓名 必填 */
    [businessparam setValue:recvname forKey:@"recvName"];
    /* 省份代号 必填 */
    [businessparam setValue:provcode forKey:@"provCode"];
    /* 市代号 必填 */
    [businessparam setValue:citycode forKey:@"cityCode"];
    /* 县代号  必填*/
    [businessparam setValue:countcode forKey:@"countCode"];
    /* 详细地址 必填  */
    [businessparam setValue:detailaddr forKey:@"detailAddress"];
    /* 收件手机号码 必填 */
    [businessparam setValue:mobileno forKey:@"mobileNo"];
    /* 邮编  */
    [businessparam setValue:postcode forKey:@"postCode"];
    /* 是否默认地址  必填 0：是
     其它：否
 */
    [businessparam setValue:isdefaultaddr forKey:@"isDefaultAddress"];
    
    
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:nn0012 business:businessparam delegate:self viewController:self];
    
}


-(void) ReturnError:(MsgReturn*)msgReturn
{
    
}

#pragma mark - 发送交易请求后 返回处理
-(void) ReturnData:(MsgReturn*)msgReturn
{
    /*收货地址新增 0012*/
    if ([msgReturn.formName isEqualToString:nn0012])
    {
        if(msgReturn.map==nil)
            return;
        
        NSLog(@"0012 %lu",(unsigned long)[msgReturn.map count]);
        //        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        //        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        //        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        //        NSString *respCode=[returnHead objectForKey:@"respCode"];
        //        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        
        msgReturn.errorCode =@"0035";
        [PromptError changeShowErrorMsg:msgReturn title:@"新增地址"  viewController:self block:^(BOOL OKCancel){
            if(OKCancel)
            {
                [self dismissViewControllerAnimated:NO completion:^{
                    
                }];
                [self.navigationController popViewControllerAnimated:NO];
                
            }
            else
            {
            
            }
        }];
        
        
        [self dismissViewControllerAnimated:NO completion:^{
            
        }];
        [self.navigationController popViewControllerAnimated:NO];
        
    }
}



@end





