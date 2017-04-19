


#import "AboutViewController.h"
#import "UIImageView+WebCache.h"
#import <Foundation/Foundation.h>
#import <PublicFramework/JSONKit.h>
#import <objc/runtime.h>
#import "SliderViewController.h"
#import "SqlApp.h"
#import "SVProgressHUD.h"
#import "PromptError.h"
#import "CstmMsg.h"
#import "AppDelegate.h"
@implementation AboutViewController
//产品图片
@synthesize projectPicImageView;
//中国集邮
@synthesize projectNameTextView;
//当前版本：
@synthesize versionTitleTextView;
//2.9.1
@synthesize versionTextView;
//更新日期：
@synthesize updateTimeTextView;
//20150101
@synthesize updateTimeValueTextView;
//中共集邮
@synthesize detailTextView;
//二维码
@synthesize twoLevevImageView;
//扫描二维码你的朋友也可下载中国集邮客户端
@synthesize shaoTextView;
//检测更新
@synthesize checkUpdateButton;
//Copyright@2015中国邮政集邮公司版权所有
@synthesize whosTextView;
//back
@synthesize backButton;
//关于我们
@synthesize titleTextView;

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    // app名称
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    SqlApp *sqlApp=[[SqlApp alloc ]init ];
   
    
 
//当前版本：

//2.9.1
    
[self.versionTextView setText:app_Version];
//更新日期：

//20150101
[self.updateTimeValueTextView setText:[sqlApp selectPM_SIGNSERVICE:@"updateTime" ]];
    
//中共集邮
[self.detailTextView setText:[sqlApp selectPM_SIGNSERVICE:@"APP_PROFILE" ]];
    
    



[self.checkUpdateButton addTarget:self action:@selector(checkUpdateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    
[self.backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    [self scrollUI];
}

-(void) viewWillAppear:(BOOL)animated{
}




-(void) scrollUI{
   
    int height=0;
    int width=self.scrollView.frame.size.width;
    int x=0;
    int y=0;
    

    
    
    [self.contentView setFrame:CGRectMake(x, y+height, width, self.contentView.frame.size.height)];
    
    height+=self.contentView.frame.size.height;
    [self.scrollView addSubview:self.contentView];
    
    
    
    //scrollView
    self.scrollView.contentSize=CGSizeMake(width, height+40);
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    [self.scrollView setFrame:CGRectMake(0, self.head.frame.size.height, self.scrollView.frame.size.width, self.view.frame.size.height-self.head.frame.size.height)];
    
  
}



-(void)checkUpdateButtonClicked:(UIButton *)btn{
id mId = objc_getAssociatedObject(btn, "mId");
//取绑定数据int mId2 = btn.tag;
//取绑定数据
    
    
    
    [[SliderViewController sharedSliderController] closeSideBarWithAnimate:YES complete:^(BOOL finished)
     {
         //[[SliderViewController sharedSliderController].navigationController pushViewController:orderFormDetailViewController animated:YES];
         //[self presentViewController:orderFormDetailViewController animated:NO completion:^{}];
         
         serviceInvoker=[[ServiceInvoker alloc]init];
         [serviceInvoker  setDelegate:self];
         
         NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
         
         // app名称
         NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
         // app版本
         NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
         // app build版本
         NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
         
         [SVProgressHUD showWithStatus:@"努力加载中..."];
         [serviceInvoker checkUpdates:@"stampStore_IOS" appVersion:app_Version ];
         
         
     }];
  

}

-(void)backButtonClicked:(UIButton *)btn{
id mId = objc_getAssociatedObject(btn, "mId");
//取绑定数据int mId2 = btn.tag;
//取绑定数据
    [self.navigationController popViewControllerAnimated:NO];
}




//业务请求返回错误
-(void)serviceInvokerError:(MsgReturn*)msgReturn
{
    
    [SVProgressHUD dismiss];
    
    
    if(msgReturn.formName!=nil && [msgReturn.formName isEqualToString:@"checkUpdates"])
    {    //版本检测失败
        //appver超了
        
        [PromptError changeShowErrorMsg:msgReturn title:@"" viewController:self block:nil];
        
        return;
    }
    else
    {
        //网络错误 服务器错误  传输格式错误
        if([msgReturn.errorCode isEqualToString:ERROR_DATA_FORMAT_ERROR] || [msgReturn.errorCode isEqualToString:ERROR_SERVICE_IN_ERROR] || [msgReturn.errorCode isEqualToString:ERROR_NOT_NET])
            
        {
            
            
            [PromptError changeShowErrorMsg:msgReturn title:@"" viewController:self block:nil];
        }
    }
    
    NSLog(@"%@ %@",msgReturn.formName,msgReturn.errorDesc);
    
}



//业务请求返回数据
-(void)serviceInvokerReturnData:(MsgReturn*)msgReturn
{
    [SVProgressHUD dismiss];
    if([msgReturn.errorCode isEqualToString:ERROR_SUCCESS] && [msgReturn.formName isEqualToString:@"checkUpdates"])
    {
        //配置文件更新成功
        
        NSLog(@"%@",@"版本检测成功");
        
        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        
        // app名称
        NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
        // app版本
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        // app build版本
        NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
        
        
        NSString *serverAppVersion = [msgReturn.map objectForKey:@"appVersion"];
        
        
        if ([app_Version isEqualToString:serverAppVersion]||[serverAppVersion isEqualToString:@""]) {
            
            
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"您所使用的已是最新版本"
                                                            message:@""
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"确定", nil];
            
            
            [alert show];
            
        }else
        {
            
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"有新版本，是否更新？"
                                                            message:@""
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"更新", nil];
            alert.tag=0;
            
            appUrl = [msgReturn.map objectForKey:@"appUrl"];//app下载地址
            [alert show];
            
        }
        
        
        
        
        
        
    }
    
    
    else if([msgReturn.errorCode isEqualToString:ERROR_SUCCESS])
    {//callWebservice成功
        
        
        
        
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==0)
    {//有新版本，是否更新？
        if (buttonIndex==1) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appUrl]];
        }
        
    }else if(alertView.tag==1)
    {//是否注销？
           
    }
}



@end//end viewController

