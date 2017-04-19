//
//  LeftViewController.m
//  Philately
//
//  Created by gdpost on 15/6/15.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "LeftViewController.h"
#import "SliderViewController.h"
#import "MainViewController.h"
#import "ShoppingCarViewController.h"
#import "AboutViewController.h"
#import "SVProgressHUD.h"
#import "AppDelegate.h"
#import "SqlQuerySignService.h"
#import "SignServiceEntity.h"
#import "AboutViewController.h"

@interface LeftViewController ()
{
    ServiceInvoker *serviceInvoker;
    
}

@end

@implementation LeftViewController

NSArray *_arData;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.tableview setDelegate:self];//指定委托
    
    [self.tableview setDataSource:self];//指定数据委托
    
    //@[@"关于", @"Link.png"],  @[@"注销", @"out.png"]@[@"帮助中心", @"lnfo.png"],

    
    _arData = @[
                @[@"关于", @"Flag.png"],
               
                @[@"咨询", @"New_Post.png"],
                           ];
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.subphoneView.frame=CGRectMake(0, self.view.bounds.size.height-170, self.view.bounds.size.width, 170);
    [self.phoneView addSubview:self.subphoneView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (void)backAction:(UIButton *)btn
{
    [[SliderViewController sharedSliderController] closeSideBar];
}

- (void)toNewViewbtn:(UIButton *)btn
{
    [[SliderViewController sharedSliderController] closeSideBarWithAnimate:YES complete:^(BOOL finished)
     {
     }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdetify = @"left";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];;
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    }
    
    NSArray *ar = [_arData objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[ar objectAtIndex:1]];
 
    
    CGSize itemsize =CGSizeMake(25,25);
    UIGraphicsBeginImageContext(itemsize);
    CGRect imagerect =CGRectMake(0, 0, itemsize.width, itemsize.height);
    [cell.imageView.image drawInRect:imagerect];
    cell.imageView.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    cell.textLabel.text = [ar objectAtIndex:0];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row)
    {
            
            //关于
        case 0:
        {
           
            AboutViewController *aboutViewController=[[AboutViewController alloc ] init ];
            [self.navigationController pushViewController:aboutViewController animated:NO];
            
            [[SliderViewController sharedSliderController] closeSideBarWithAnimate:YES complete:^(BOOL finished)
             {
              
             }];
//                 //[[SliderViewController sharedSliderController].navigationController pushViewController:orderFormDetailViewController animated:YES];
//                 //[self presentViewController:orderFormDetailViewController animated:NO completion:^{}];
//                 
//                 serviceInvoker=[[ServiceInvoker alloc]init];
//                 [serviceInvoker  setDelegate:self];
//                 
//                 NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//           
//                 // app名称
//                 NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
//                 // app版本
//                 NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//                 // app build版本
//                 NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
//                 
//                [SVProgressHUD showWithStatus:@"努力加载中..."];
//                 [serviceInvoker checkUpdates:@"stampStore_IOS" appVersion:app_Version ];
//                 
//                 
//             }];
            break;
        }
            //关于
//        case 2:
//        {
//            AboutViewController *about = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
//            
//           
//            
//            [[SliderViewController sharedSliderController] closeSideBarWithAnimate:YES complete:^(BOOL finished)
//             {
//                 [[SliderViewController sharedSliderController].navigationController pushViewController:about animated:YES];
//                 //[self presentViewController:orderFormDetailViewController animated:NO completion:^{}];
//             }];
//            break;
//        }
        case 1:
        {
            [[SliderViewController sharedSliderController] closeSideBarWithAnimate:YES complete:^(BOOL finished)
             {
                 self.subphoneView.frame=CGRectMake(0, self.view.bounds.size.height-170, self.view.bounds.size.width, 170);
                 [self.phoneView addSubview:self.subphoneView];
                 
                 SqlQuerySignService* signservice =[[SqlQuerySignService alloc]init];
                 NSString* titlestr =((SignServiceEntity*)[signservice querySignServiceWithKey:@"ASK_TEXT"]).serviceValue;
                 self.lbphone.text =titlestr;
                 
                 [[SliderViewController sharedSliderController].MainVC.view addSubview:self.phoneView];
                 
             }];
            

            break;
        }
        case 3:
        {
//            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"是否注销？"
//                                                            message:@""
//                                                           delegate:self
//                                                  cancelButtonTitle:@"取消"
//                                                  otherButtonTitles:@"确定", nil];
//            alert.tag=1;
//            
//            [alert show];
        }
            
            
            
        default:
            [self backAction:nil];
            break;
    }
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
       if (buttonIndex==1) {
           CstmMsg *cstmsg=[CstmMsg sharedInstance];
           [cstmsg clearCstmMsg];
           
           MsgReturn *msgReturn =[[MsgReturn alloc]init ];
           msgReturn.errorCode=@"";
           msgReturn.errorDesc=@"注销成功";
           msgReturn.errorType=@"02";
           [PromptError changeShowErrorMsg:msgReturn title:@"" viewController:self block:nil];
           
           AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
           [appDelegate.tabbar setSelectedIndex:0];
           
           
           //角标
           [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
           
           UITabBarItem *tabBarItem = [appDelegate.tabbar.tabBar.items objectAtIndex:1];
           
           [tabBarItem setBadgeValue:nil];
           
       }
   }
}

- (IBAction)docall:(id)sender {
    
    SqlQuerySignService* signservice =[[SqlQuerySignService alloc]init];
    NSString* telenum =((SignServiceEntity*)[signservice querySignServiceWithKey:@"ASK_TELEPHONE"]).serviceValue;
    
    NSURL* phoneurl =[[NSURL alloc]initWithString:[NSString stringWithFormat:@"tel://%@",telenum]];
    
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:phoneurl]];
    [self.view addSubview:callWebview];
    [self cancleCall:nil];
//    [[UIApplication sharedApplication] openURL:phoneurl];
}

- (IBAction)cancleCall:(id)sender {
        for (UIView* view in [[SliderViewController sharedSliderController].MainVC.view subviews]) {
            if (view ==self.phoneView) {
                [view removeFromSuperview];
            }
        }
}

@end
