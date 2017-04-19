//
//  ViewController.m
//  PublicLibUI
//
//  Created by gdpost on 15/5/13.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "ViewController.h"
#import "JSONKit.h"




@interface ViewController ()

@end



@implementation ViewController

//sdd
@synthesize sddTextView;
//专题
@synthesize zhuangTextView;
//1分种
@synthesize miniTextView;
//北京强力禁烟
@synthesize msgTextView;
//热点
@synthesize hotTextView;
@synthesize btn;

ServiceInvoker *serviceInvoker;

- (void)viewDidLoad {
    [super viewDidLoad];
    

     //serviceInvoker=[[ServiceInvoker alloc]init];
   //[serviceInvoker  setDelegate:self];
    //[serviceInvoker appSignIn:@"gd.proj183.ios.new" appVersion:@"1.0" ];

    [hotTextView setText:@"nimade"];
    
    
    [btn addTarget:self
            action:@selector(myAction:)
       forControlEvents:UIControlEventTouchUpInside];
    
    //两种方法，一种是用导航条的 push方法。另一种是 present方法

   // [self.navigationController pushViewController:hv animated:YES];
   // self presentModalViewController:你要切换的视图 animated:YES];
    
   // [self presentModalViewController:controller animated:YES];//YES有动画效果
   // -----返回之前的视图    [self dismissModalViewControllerAnimated:YES];
    
//
//    使用presentModalViewControllerAnimated方法从A->B->C，若想在C中直接返回A，则可这样实现：
//    
//    C中返回事件：
//    
//    void back
//    {
//        [self dismissModalViewControllerAnimated:NO];//注意一定是NO！！
//        [[NSNotificationCenter  defaultCenter]postNotificationName:@"backback" object:nil];
//    }
//    然后在B中，
//    
//    //在viewdidload中：
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(back) name:@"backback" object:nil];
//    
//    -(void)back
//    {
//        [self dismissModalViewControllerAnimated:YES];  
//    }
    
}

-(void)myAction:(id)sender
{
      [zhuangTextView setText:@""];
  //  [serviceInvoker checkUpdates];
    
 
    

    
    
    
    //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"dd"bundle:nil];
  //  NineTableViewController *nineTableViewController = [storyboard instantiateViewControllerWithIdentifier:@"nineTableViewController"];
  
//[self.navigationController pushViewController:nineTableViewController animated:YES];
    
    
    
//     DoctorViewController *hv=[[DoctorViewController alloc] initWithNibName:@"DoctorViewController" bundle:nil];
//   //[self.navigationController pushViewController:hv animated:YES];
//
//    [self presentModalViewController:hv animated:YES];
    
    
//    //页面跳转传值方法二：利用notification
//    NSDictionary *dicts = [NSDictionary dictionaryWithObjectsAndKeys:@"one1",@"one",@"two2",@"two",@"three3",@"three", nil];
//    //注册(第一步)
//    NSNotification *notification  =[NSNotification notificationWithName:@"mynotification" object:firstField.text];
//    //发送（第二步）
//    [[NSNotificationCenter defaultCenter] postNotification:notification];
//    
//    //注册+发送也可以一行完成(等效于以上两行)
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"mynotification2" object:dicts];//发送一个字典过去
    
    //接受端：接受（第一步）
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler2:) name:@"mynotification" object:nil];
//    //自定义接收字典信息的方法
//    -(void) notificationHandler2:(NSNotification *) notification2{
//        
//        NSDictionary *dict = [notification2 object];
//        NSLog(@"receive dict :%@,forkey:%@",dict,[dict objectForKey:@"one"]);
//        
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
