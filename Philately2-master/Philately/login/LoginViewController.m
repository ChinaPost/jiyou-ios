


#import "LoginViewController.h"
#import "UIImageView+WebCache.h"
#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import "StampTranCall.h"
#import "SliderViewController.h"
#import "PromptError.h"
#import "SysBaseInfo.h"
#import "RespondParam0004.h"
#import "RespondParam0008.h"
#import "RegistViewController.h"
#import "Toast+UIView.h"
#import "FindPwdViewController.h"
#import "AppDelegate.h"
#import "ProductdetailViewController.h"
#import "ShoppingCarViewController.h"
#import "RespondParam0032.h"
#import "SqlApp.H"
#import "UIButton+EnlargeTouchArea.h"

@implementation LoginViewController

@synthesize whereComeIn;
//back
@synthesize backImageView;
//用户登录
@synthesize titleTextView;
//注册
@synthesize rigistButton;
//用户名
@synthesize userNameTitleTextView;
//请输入用户名或手机号码
@synthesize userNameValueEditText;
//密码
@synthesize pwdTitleTextView;
//请输入密码
@synthesize pwdValueEditText;
//验证码
@synthesize codeTitleTextView;
//请输入验证码
@synthesize codeValueEditText;
//codePic
@synthesize codePicImageView;
//忘记密码
@synthesize forgetPwdButton;
//登录
@synthesize loginButton;

StampTranCall *stampTranCall;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
     stampTranCall=[[StampTranCall alloc] init ];
    //[ stampTranCall jyTranCall:nil  cstmMsg:nil formName:nil business:nil delegate:self];
    
    UITapGestureRecognizer *backImageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backImageViewHandTap)];
    [backImageView addGestureRecognizer:backImageViewTap];
    
    [backImageView setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    
    UITapGestureRecognizer *loginButtonTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginButtonHandTap)];
    [loginButton addGestureRecognizer:loginButtonTap];
    
    UITapGestureRecognizer *codeButtonTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapToGenerateCode)];
    [codePicImageView addGestureRecognizer:codeButtonTap];
    codeValueEditText.delegate=self;
   
    
    UITapGestureRecognizer *rigistButtonTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rigistButtonHandTap)];
    [rigistButton addGestureRecognizer:rigistButtonTap];
    
    
    [self.forgetPwdButton addTarget:self action:@selector(forgetPwdButtonclicked:) forControlEvents:UIControlEventTouchUpInside];
  
    [self.codeValueEditText setAutocorrectionType:UITextAutocorrectionTypeNo];
    self.codeValueEditText.keyboardType = UIKeyboardTypeAlphabet ;
    [self.userNameValueEditText setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.pwdValueEditText setAutocorrectionType:UITextAutocorrectionTypeNo];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *username=[ud objectForKey:@"cstmName"];
     NSString *pwd=[ud objectForKey:@"pwd"];
    self.userNameValueEditText.text=username;
    self.pwdValueEditText.text=pwd;
    self.userNameValueEditText.returnKeyType=UIReturnKeyNext;
    self.pwdValueEditText.returnKeyType=UIReturnKeyNext;
    self.codeValueEditText.returnKeyType=UIReturnKeyDone;
    
     [self onTapToGenerateCode ];
    
    UITapGestureRecognizer* closeKeyboardtap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKeyboard)];
    [self.view addGestureRecognizer:closeKeyboardtap];
    
    
    
    self.remenberPwd.selected=true;
    [self.remenberPwd  setBackgroundImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
    [self.remenberPwd  setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateSelected];
    
  
    [self.remenberPwd  addTarget:self action:@selector(remenberPwdCheck:) forControlEvents:UIControlEventTouchUpInside];
    

    
}

-(void)remenberPwdCheck:(UIButton *)btn{
    btn.selected = !btn.selected ;
    
 
}


-(void)closeKeyboard
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

-(void)forgetPwdButtonclicked:(UIButton *)btn{
    
    
    FindPwdViewController *findPwdViewController=[[FindPwdViewController alloc ] initWithNibName:@"FindPwdViewController" bundle:nil];
    
    [self presentViewController:findPwdViewController animated:YES completion:^{
        
    }];
}

-(void)backImageViewHandTap
{
    if ([whereComeIn isEqualToString:@"tabbar"]) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.tabbar setSelectedIndex:0];
    }
   
    
[self dismissViewControllerAnimated:NO completion:^(){}];
[self.navigationController popViewControllerAnimated:NO];
}

-(void)loginButtonHandTap
{
    [self request0004 ];
 
}

-(void)rigistButtonHandTap
{//注册
    RegistViewController *registViewController=[[RegistViewController alloc]initWithNibName:@"RegistViewController" bundle:nil];
    
 
    if (self.navigationController.viewControllers!=nil) {
        [self.navigationController pushViewController:registViewController animated:NO];
        

    }else
    {
       [self presentViewController:registViewController animated:YES completion:^{
        
        
    }];
        
    }
    
   
}

-(void) viewWillAppear:(BOOL)animated{
    AppDelegate *appDelegate1 = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    appDelegate1.loginView=self;
}


-(void) setUiValue{

}


/*会员登录0004*/
NSString  *n0004=@"JY0004";
/*会员登录0004*/
-(void) request0004{
    
    NSString *userName= [userNameValueEditText text];
    if(userName==nil ||[userName isEqualToString:@""])
    {
        //[ self.view makeToast:@"请输入用户名" ];
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
     
        msgReturn.errorCode=@"0001";//不能为空
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@"用户名"  viewController:self block:^(BOOL OKCancel)
         {
             if (OKCancel) {
                  
             }else
             {
             
             }
             return ;
         }
         ];
        
        
        return;
    } else if ([userName length]>20)
    {
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        msgReturn.errorDesc=@"请输入20位以内用户名";//不能为空
        msgReturn.errorType=@"02";
        msgReturn.errorCode=@"-333";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        return;
        
    }

    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:userName forKey:@"cstmName"];
    [ud synchronize];
    
    NSString *pwd= [pwdValueEditText text];
    if(pwd==nil ||[pwd isEqualToString:@""])
    {
            //[self.view makeToast:@"请输入密码" ];
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        msgReturn.errorCode=@"0001";//密码不能为空
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@"密码"  viewController:self block:^(BOOL OKCancel)
         {
             if (OKCancel) {
                 
             }else
             {
                 
             }
             return ;
         }
         ];

        return;
    }
    else if ([pwd length]>20)
    {
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        
        msgReturn.errorDesc=@"请输入20位以内的密码";//不能为空
        msgReturn.errorType=@"02";
        msgReturn.errorCode=@"-333";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        return;
        
    }
    
    NSString *code= [codeValueEditText text];
    if(code==nil ||[code isEqualToString:@""])
    {
         //[self.view makeToast:@"请输入验证码" ];
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        msgReturn.errorCode=@"0001";//不能为空
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@"验证码"  viewController:self block:^(BOOL OKCancel)
         {
             if (OKCancel) {
                 
             }else
             {
                 
             }
             return ;
         }
         ];

        return;
    }else if(![[code lowercaseString] isEqualToString:[validateCode lowercaseString] ])
               {
                   //[self.view makeToast:@"验证码错误,请重新输入"];
                   
                   MsgReturn *msgReturn=[[MsgReturn alloc]init];
                   
                   msgReturn.errorCode=@"-10001";//不能为空
                   msgReturn.errorDesc=@"验证码错误";
                   msgReturn.errorType=@"02";
                   msgReturn.errorPic=true;
                   [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel)
                    {
                        if (OKCancel) {
                            
                        }else
                        {
                            
                        }
                        return ;
                    }
                    ];
                   
                   [codeValueEditText setText:@""];
                   [self onTapToGenerateCode ];
                   return;
               }
    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 登录号 备注:必填*/
    [businessparam setValue:userName forKey:@"loginNo"];
    /* 密码 备注:必填*/
    [businessparam setValue:pwd forKey:@"passWord"];
   
    
    
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
     _sysBaseInfo.isOpenLoading=true;
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0004 business:businessparam delegate:self viewController:self];
    
    
}

/*购物车查询0032*/
NSString  *nnnn0032=@"JY0032";
/*购物车查询0032*/
-(void) request0032{
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    
    if (_cstmMsg.cstmNo==nil ) {
        return;
    }
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 会员编号 备注:必填*/
    [businessparam setValue:_cstmMsg.cstmNo forKey:@"cstmNo"];
    /* 业务代号 备注:选填*/
    [businessparam setValue:@"" forKey:@"busiNo"];
    
    
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:nnnn0032 business:businessparam delegate:self viewController:self];
}




StampTranCall *stampTranCall;
/*会员资料标准查询0008*/
NSString  *n0008=@"JY0008";
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
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0008 business:businessparam delegate:self viewController:self];
    
}


-(void) ReturnError:(MsgReturn*)msgReturn
{
}

-(void) ReturnData:(MsgReturn*)msgReturn
{
    NSMutableArray *listData=[[NSMutableArray alloc]init];
    /*会员登录0004*/
    if ([msgReturn.formName isEqualToString:n0004]){
        
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
        
        
        if (self.remenberPwd.selected) {
            
            NSString *pwd= [pwdValueEditText text];
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:pwd forKey:@"pwd"];
            [ud synchronize];
        }else
        {
        
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:@"" forKey:@"pwd"];
            [ud synchronize];
        }
        
     
        if(commonItem.cstmNo!=nil)
        {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                 [self request0008 ];
            });
           
        
        }
        
        
    }
 
    /*会员资料标准查询0008*/
    if ([msgReturn.formName isEqualToString:n0008]){
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
        
        commonItem.homePhone=[returnDataBody objectForKey:@"homePhone"];
        cst.homePhone=commonItem.homePhone;
        
        /* 性别 备注:0：男
         1：女*/
        commonItem.userSex=[returnDataBody objectForKey:@"userSex"];
         cst.userSex=commonItem.userSex;
        /* 邮箱 备注:*/
        commonItem.email=[returnDataBody objectForKey:@"email"];
         cst.email=commonItem.email;
        /* 会员积分 备注:*/
        commonItem.cstmScore=[[returnDataBody objectForKey:@"cstmScore"] intValue];
        
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
            
            SqlApp *sqlApp=[[SqlApp alloc ]init ];
            int queryis=[[sqlApp selectPM_SIGNSERVICE:@"SC_QUERY_HOMEPAGE" ] intValue];
            if(queryis==0)
            {
                [self request0032 ];
            }else{
                
//              
//                MsgReturn *msgReturn=[[MsgReturn alloc]init];
//                
//            
//                    msgReturn.errorCode=@"-0001";//不能为空
//                msgReturn.errorDesc=@"登陆成功";
//                msgReturn.errorType=@"02";
//                    [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
                
                for (UIViewController* view in self.navigationController.viewControllers) {
                    if ([view isKindOfClass:[ProductdetailViewController class]]) {
                        [((ProductdetailViewController*)view) viewDidLoad];
                        [self.navigationController popToViewController:view animated:YES];
                    }
                }
                
                
                [self dismissViewControllerAnimated:NO completion:^(){}];
            }
        });
    
      
    }

    
    
    /*购物车查询0032*/
    if ([msgReturn.formName isEqualToString:nnnn0032]){
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        RespondParam0032 *commonItem=[[RespondParam0032 alloc]init];
        /* 返回的记录数 备注:循环域开始*/
        commonItem.recordNum=[[returnDataBody objectForKey:@"recordNum"] intValue];
        
        NSMutableDictionary *dic =[[NSMutableDictionary alloc] init];
        
        for(int i=0;i<commonItem.recordNum;i++)
        {
            /* 购物车代号 备注:*/
            commonItem.shoppingCartID=[returnDataBody objectForKey:@"shoppingCartID"][i];
            /* 业务代号 备注:*/
            commonItem.busiNo=[returnDataBody objectForKey:@"busiNo"][i];
            /* 商品代号 备注:*/
            commonItem.merchID=[returnDataBody objectForKey:@"merchID"][i];
            
            
            /* 图片URL 备注:*/
            commonItem.merchPicID=[returnDataBody objectForKey:@"merchPicID"][i];
            /* 商品名称 备注:*/
            commonItem.merchName=[returnDataBody objectForKey:@"merchName"][i];
            /* 所属机构 备注:店铺名称*/
            commonItem.brchNo=[returnDataBody objectForKey:@"brchNo"][i];
            /* 商品规格 备注:20：单张
             30：四方连*/
            commonItem.normsType=[returnDataBody objectForKey:@"normsType"][i];
            /* 购买价格 备注:*/
            commonItem.buyPrice=[([returnDataBody objectForKey:@"buyPrice"][i]) floatValue];
            /* 创建时间 备注:*/
            commonItem.gmtCreate=[returnDataBody objectForKey:@"gmtCreate"][i];
            /* 修改时间 备注:*/
            commonItem.gmtModify=[returnDataBody objectForKey:@"gmtModify"][i];
            /* 是否实名验证商品 备注:2015/6/30新增：
             0：需要
             1：不需要*/
            commonItem.needAutonym=[returnDataBody objectForKey:@"needAutonym"][i];
            /* 是否手机验证码商品 备注:2015/6/30新增：
             0：需要
             1：不需要*/
            commonItem.needVerification=[returnDataBody objectForKey:@"needVerification"][i];
            /* 是否支持寄递 备注:2015/6/30新增：
             0：支持
             1：不支持*/
            commonItem.canPost=[returnDataBody objectForKey:@"canPost"][i];
            
            [dic setObject:commonItem forKey:commonItem.merchID];
        }
        
        //购物车数量
        if (dic==nil || [dic count]==0) {
            
            
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            UITabBarItem *tabBarItem = [appDelegate.tabbar.tabBar.items objectAtIndex:1];
            
            [tabBarItem setBadgeValue:nil];
            
        }else
        {
            
            
            
            //角标
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[dic count]];
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            UITabBarItem *tabBarItem = [appDelegate.tabbar.tabBar.items objectAtIndex:1];
            
            [tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d",[dic count]]];
            
        }
//        MsgReturn *msgReturn=[[MsgReturn alloc]init];
//        
//        
//        msgReturn.errorCode=@"-0001";//不能为空
//        msgReturn.errorDesc=@"登陆成功";
//        msgReturn.errorType=@"02";
//        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        
        for (UIViewController* view in self.navigationController.viewControllers) {
            if ([view isKindOfClass:[ProductdetailViewController class]]) {
                [((ProductdetailViewController*)view) viewDidLoad];
                [self.navigationController popToViewController:view animated:YES];
            }
        }
        
        
        [self dismissViewControllerAnimated:NO completion:^(){}];
    }

    
}



- (void)onTapToGenerateCode {
    
    

    float red = arc4random() % 100 / 100.0;
    float green = arc4random() % 100 / 100.0;
    float blue = arc4random() % 100 / 100.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:0.2];
    [self.codePicImageView setBackgroundColor:color];

    const int count = 4;
    char data[count];
    for (int x = 0; x < count; x++) {
        int j = '0' + (arc4random_uniform(75));
        if((j >= 58 && j <= 64) || (j >= 91 && j <= 96)){
            --x;
        }else{
            data[x] = (char)j;
        }
    }
    NSString *text = [[NSString alloc] initWithBytes:data
                                              length:count encoding:NSUTF8StringEncoding];
      validateCode= text;
  
    //self.codeValueEditText.text=validateCode;
    
       [self.codePicImageView setText:validateCode];
}



- (IBAction)backgroud:(id)sender {
    // 发送resignFirstResponder.
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (IBAction)username:(id)sender {
    
    [pwdValueEditText becomeFirstResponder];
    
    
}

- (IBAction)pwd:(id)sender {
    
    [codeValueEditText becomeFirstResponder];
    //[self onTapToGenerateCode ];
}

- (IBAction)code:(id)sender {
    [loginButton becomeFirstResponder];
   
    
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
  
   // [self onTapToGenerateCode ];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
  
    return YES;
}




@end







