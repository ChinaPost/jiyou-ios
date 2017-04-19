//
//  WelcomeViewController.m
//  Philately
//
//  Created by gdpost on 15/6/17.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "WelcomeViewController.h"

#import "LeftViewController.h"
#import "SliderViewController.h"
#import "MainViewController.h"
#import <CoreGraphics/CGAffineTransform.h>
#import "MLBlackTransition.h"

#import "PromptError.h"
#import "SysBaseInfo.h"
#import "PromptError.h"
#import "Toast+UIView.h"
#import "SVProgressHUD.h"
#import "AppDelegate.h"

#import "SqlQuerySignService.h"
#import "SignServiceEntity.h"

#import "BasicClass.h"
#import "WGradientProgress.h"

@interface WelcomeViewController ()

@end

ServiceInvoker *serviceInvoker;

@implementation WelcomeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.navigationController.navigationBarHidden=YES;
    
    
    WGradientProgress *gradProg = [WGradientProgress sharedInstance];
   
        [gradProg showOnParent:self.progress position:1];
        [gradProg setProgress:1.0];

    
    [self request];
}

-(void)request
{
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


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//业务请求返回错误
-(void)serviceInvokerError:(MsgReturn*)msgReturn
{
    [SVProgressHUD dismiss];
    
    
 
    [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel)
     {
         if (OKCancel) {
             [self request];
         }else
         {
             AppDelegate *app = [UIApplication sharedApplication].delegate;
             UIWindow *window = app.window;
             
             [UIView animateWithDuration:1.0f animations:^{
                 window.alpha = 0;
                 window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
             } completion:^(BOOL finished) {
                 exit(0);
             }];
             
         }
         return ;
     }
     okBtnName:@"重试" cancelBtnName:@"退出"];

    
    
//    //签到失败
//    if([msgReturn.formName isEqualToString:@"appSignIn"]  && [msgReturn.errorCode isEqualToString:ERROR_SINGIN_ERROR])
//    {
//        [self.view makeToast:msgReturn.errorDesc];
//        return;
//    }
//    
//    
//    
//    
//     if(msgReturn.formName!=nil && [msgReturn.formName isEqualToString:@"checkUpdates"])
//    {    //版本检测失败
//        //appver超了
//        
//        [self.view makeToast:msgReturn.errorDesc];
//        return;
//    }
//    
//    if(msgReturn.formName!=nil && [msgReturn.errorCode isEqualToString:ERROR_FAILED])
//    {//交易失败
//        
//        return;
//    }
//    
//    else
//    {
//        //网络错误 服务器错误  传输格式错误
//        if([msgReturn.errorCode isEqualToString:ERROR_DATA_FORMAT_ERROR] || [msgReturn.errorCode isEqualToString:ERROR_SERVICE_IN_ERROR] || [msgReturn.errorCode isEqualToString:ERROR_NOT_NET])
//            
//        {
//            
//            //[self.view makeToast:msgReturn.errorDesc];
//            
//            [PromptError changeShowErrorMsg:msgReturn title:@"" viewController:self block:nil];
//        }
//    }
//    
//    NSLog(@"%@ %@",msgReturn.formName,msgReturn.errorDesc);
    
}



//业务请求返回数据
-(void)serviceInvokerReturnData:(MsgReturn*)msgReturn
{
 [SVProgressHUD dismiss];
    //签到成功
    if([msgReturn.errorCode isEqualToString:ERROR_SUCCESS] && [msgReturn.formName isEqualToString:@"appSignIn"])
    {
      
        SysBaseInfo *sysBaseInfo=[SysBaseInfo sharedInstance];
      
        sysBaseInfo.appID=@"stampStore_IOS";
        sysBaseInfo.appVersion=@"1.0";
        sysBaseInfo.appConfigVersion=@"1.0";
        sysBaseInfo.curTermType=@"02";//终端类型 02ios
        sysBaseInfo.curTermNo=@"";//当时终端号 android ios为空
        sysBaseInfo.channelNo=@"17";//渠道号 android ios 17
        sysBaseInfo.IP=@"";
        sysBaseInfo.tranNum=@"";//终端流水号 暂时为空
        
        NSLog(@"%@",@"签到成功");
        // [zhuangTextView setText:@"签到成功"];
      
        
        
        LeftViewController *leftVC = [[LeftViewController alloc] init];
        [SliderViewController sharedSliderController].LeftVC = leftVC;
        [SliderViewController sharedSliderController].MainVC = [[MainViewController alloc] init];
        [SliderViewController sharedSliderController].LeftSContentOffset=275;
        [SliderViewController sharedSliderController].LeftContentViewSContentOffset = 90;
        [SliderViewController sharedSliderController].LeftSContentScale=0.77;
        [SliderViewController sharedSliderController].LeftSJudgeOffset=160;
        [SliderViewController sharedSliderController].changeLeftView = ^(CGFloat sca, CGFloat transX)
        {
            //        leftVC.contentView.layer.anchorPoint = CGPointMake(1, 1);
            CGAffineTransform ltransS = CGAffineTransformMakeScale(sca, sca);
            CGAffineTransform ltransT = CGAffineTransformMakeTranslation(transX, 0);
            CGAffineTransform lconT = CGAffineTransformConcat(ltransT, ltransS);
            leftVC.contentView.transform = lconT;
        };
        
        
        //手势返回更新为MLBlackTransition
        [MLBlackTransition validatePanPackWithMLBlackTransitionGestureRecognizerType:MLBlackTransitionGestureRecognizerTypePan];
        
        UINavigationController *naviC = [[UINavigationController alloc] initWithRootViewController:[SliderViewController sharedSliderController]];
        
        [self.navigationController pushViewController:[SliderViewController sharedSliderController] animated:NO];

        
        /////balieyong add begin
        
//        SqlQuerySignService* signservice =[[SqlQuerySignService alloc]init];
//        NSString* updateflag = ((SignServiceEntity*)[signservice querySignServiceWithKey:@"IOS_UPDATE_FLAG"]).serviceValue;
        
//        if ([updateflag isEqual:@"1"]) {//1：从第三方平台升级
//            [self updateApp];
//        }
        /////end
            
        //  [serviceInvoker checkUpdates];
        
        
        
        
    }
    else if([msgReturn.errorCode isEqualToString:ERROR_SUCCESS] && [msgReturn.formName isEqualToString:@"checkUpdates"])
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
          oldVersionEnable = [msgReturn.map objectForKey:@"oldVersionEnable"];
        
        
        if ([app_Version isEqualToString:serverAppVersion] || [serverAppVersion isEqualToString:@""]) {
            
            
          [serviceInvoker appSignIn:@"stampStore_IOS" appVersion:app_Version ];
            
        }else
        {
            
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"有新版本，是否更新？"
                                                            message:@""
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"更新", nil];
               appUrl = [msgReturn.map objectForKey:@"appUrl"];//app下载地址
            

            
            alert.tag=1;

            [alert show];
            
        }

        
        
        
    }
    
    
    else if([msgReturn.errorCode isEqualToString:ERROR_SUCCESS])
    {//callWebservice成功
        
        
        
        
        
    }
    
}

//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    
//    if (buttonIndex==1) {
//        
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps ://itunes.apple.com/gb/app/yi-dong-cai-bian/id391945719?mt=8"]];
//    }else
//    {
//     [serviceInvoker appSignIn:@"stampStore_IOS" appVersion:@"1.0" ];
//    }
//}

//检查服务器是否有最新版本，如果有，则提示更新；
//static NSString * refreshURL =@"https://dn-jtjyscyz.qbox.me";//测试环境
static NSString * refreshURL =@"https://dn-philately.qbox.me";//生产环境
-(void)updateApp{
    
    //    NSMutableString *urlt =[[NSMutableString alloc] initWithString:REFRESH_IP];
    //    [urlt appendString:@"/gdpostAPP.plist"];
    NSString*urlt =[NSString stringWithFormat:@"%@%@",refreshURL,@"/gdpostAPP.plist"];
    NSDictionary* dict = [NSDictionary dictionaryWithContentsOfURL:[NSURL URLWithString:[urlt copy]]];
    
    if (dict) {
        
        NSArray* list = [dict objectForKey:@"items"];
        NSDictionary* dict2 = [list objectAtIndex:0];
        
        NSDictionary* dict3 = [dict2 objectForKey:@"metadata"];
        NSString* newVersion = [dict3 objectForKey:@"bundle-version"];
        
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        NSString *myVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
        
        if (![newVersion isEqualToString:myVersion]) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"有新版本" delegate:self cancelButtonTitle:@"马上去更新" otherButtonTitles:@"暂不更新", nil];
            alert.tag =0;
            [alert show];
        }
        else
        {
        }
    }
    else{
        //        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请检查网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        //        alert.tag =2;
        //        [alert show];

    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    //    NSMutableString *urlt =[[NSMutableString alloc] initWithString:REFRESH_IP];
    //    [urlt appendString:@"/ios.html"];
    //    NSString* DOWNLOAD =[urlt copy];
    
//    NSString* DOWNLOAD =@"https://dn-philately.qbox.me/ios.html";
    NSString* DOWNLOAD  =[NSString stringWithFormat:@"%@%@",refreshURL,@"/ios.html"];
    switch (alertView.tag)
    {
        case 0:
        {
            switch (buttonIndex)
            {
                case 0:
                    NSLog(@"更新");
                    NSLog(@"%@",DOWNLOAD);
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:DOWNLOAD]];
                    return;
                default:
                    NSLog(@"不更新");
                    return;
            }
        }
        case 1:
        {
            if (buttonIndex==1) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appUrl]];
            }else
            {
                NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
                
                // app名称
                NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
                // app版本
                NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
                // app build版本
                NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
                
                if ([oldVersionEnable intValue]==1) {//非强制升级
                     [serviceInvoker appSignIn:@"stampStore_IOS" appVersion:@"1.0"];
                }else
                {
                   
                    AppDelegate *app = [UIApplication sharedApplication].delegate;
                    UIWindow *window = app.window;
                    
                    [UIView animateWithDuration:1.0f animations:^{
                        window.alpha = 0;
                        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
                    } completion:^(BOOL finished) {
                        exit(0);
                    }];
                  
                }
               
            }
        }
          
            
            break;
    }
    
}

@end
