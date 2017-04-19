//
//  MainViewController.m
//  Philately
//
//  Created by gdpost on 15/6/15.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "MainViewController.h"
#import "LoginViewController.h"
#import  "UpdatePwdViewController.h"
#import "FirstPageViewController.h"

#import "Device.h"
#import "ShoppingCarViewController.h"
#import "AppDelegate.h"

@interface MainViewController ()

@end
ServiceInvoker *serviceInvoker;

UpdatePwdViewController *updatePwdViewController;
LoginViewController *loginViewController;
FirstPageViewController *firstPageViewController;

ShoppingCarViewController *shoppingCarViewController;
static int tabHeight;
@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    _tabC = [[UITabBarController alloc] init];
    appDelegate.tabbar=_tabC;
    [_tabC.tabBar setBackgroundColor:[UIColor clearColor]];
    [_tabC.view setFrame:self.view.frame];
    _tabC.delegate=self;
    
    UIView * transitionView = [[_tabC.view subviews] objectAtIndex:0];
    int controllerView=transitionView.frame.size.height;
    int tabheight=_tabC.tabBar.frame.size.height;
   
    //[self.navigationController addChildViewController:_tabC.view];
    [self.view addSubview:_tabC.view];;
    
    
    firstPageViewController = [[FirstPageViewController alloc]initWithNibName:@"FirstPageViewController" bundle:nil];
    
     //[firstPageViewController.view setFrame:CGRectMake(0,0,self.contentView.frame.size.width,self.contentView.frame.size.height)];
   
    
    menberMainViewController = [[MenberMainViewController alloc]initWithNibName:@"MenberMainViewController" bundle:nil];
    menberMainViewController.title=@"MenberMainViewController";
    
       shoppingCarViewController = [[ShoppingCarViewController alloc]initWithNibName:@"ShoppingCarViewController" bundle:nil];
    shoppingCarViewController.title=@"ShoppingCarViewController";
    shoppingCarViewController.whereCome=@"MainPage";

    
    /*balieyong add*/
    UINavigationController*firstNav =[[UINavigationController alloc]initWithRootViewController:firstPageViewController];
    UINavigationController*menberNav =[[UINavigationController alloc]initWithRootViewController:menberMainViewController];
    UINavigationController*shopingNav =[[UINavigationController alloc]initWithRootViewController:shoppingCarViewController];
    
    _tabC.viewControllers = @[firstNav,shopingNav,menberNav];
    /*balieyong end*/
    
    //_tabC.viewControllers = @[firstPageViewController,shoppingCarViewController,menberMainViewController];

    
     [self reloadImage];
    
//    [[UITabBarItem appearance] setTitleTextAttributes:
//     [NSDictionary dictionaryWithObjectsAndKeys:RGBA(96, 164, 222, 1), UITextAttributeTextColor, nil] forState:UIControlStateSelected];
    
     [_tabC setSelectedIndex:0];
    
    [Device sharedInstance].tabHeight=_tabC.tabBar.frame.size.height;

  //  [self.contentView addSubview:firstPageViewController.view];
    
   // [self.firstPageBtn addTarget:self action:@selector(firstPageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f],
//                                                        NSForegroundColorAttributeName : [UIColor whiteColor]
//                                                        } forState:UIControlStateSelected];
    
    // doing this results in an easier to read unselected state then the default iOS 7 one
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:13.0f],
                                                        NSForegroundColorAttributeName : [UIColor blackColor]
                                                        } forState:UIControlStateNormal];

    
    appDelegate.isMainpage=true;
    
   
}

-(void)firstPageBtnClick:(UIButton*)btn
{
[self.contentView addSubview:firstPageViewController.view];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
  
}

-(void)viewWillAppear:(BOOL)animated{
//[self btnTouchMy];

}



//登录页
#define SELECTED_VIEW_CONTROLLER_TAG 98456345





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (void)reloadImage
{
 
    
    NSString *imageName = nil;
//    if (isIos7 >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1 && [QHConfiguredObj defaultConfigure].nThemeIndex != 0)
//    {
//        imageName = @"tabbar_bg_ios7.png";
//    }else
    //{
      //  imageName = @"tabbar_bg.png";
    //}
    [_tabC.tabBar setBackgroundImage:[UIImage imageNamed:imageName]];
    
    NSArray *ar = _tabC.viewControllers;
    NSMutableArray *arD = [NSMutableArray new];
    [ar enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop)
     {
         //        UITabBarItem *item = viewController.tabBarItem;
         UITabBarItem *item = nil;
         switch (idx)
         {
             case 0:
             {
                 UIImage *image = [UIImage imageNamed:@"main.png"];
                
                 CGSize itemsize =CGSizeMake(50,50);
                 UIGraphicsBeginImageContext(itemsize);
                 CGRect imagerect =CGRectMake(0, 0, itemsize.width, itemsize.height);
                 [image drawInRect:imagerect];
                 image=UIGraphicsGetImageFromCurrentImageContext();
                 UIGraphicsEndImageContext();

                 
                 
                 item = [[UITabBarItem alloc] initWithTitle:@"首页" image:[[UIImage imageNamed:@"main.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"main_select.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
               
                 break;
             }
             case 1:
             {
                 item = [[UITabBarItem alloc] initWithTitle:@"购物车" image:[[UIImage imageNamed:@"car_unselect.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"car.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                 break;
             }
             case 2:
             {
                 item = [[UITabBarItem alloc] initWithTitle:@"我的" image:[[UIImage imageNamed:@"my.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"my_select.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                 break;
             }
           
         }
         
         
         
         //item.imageInsets = UIEdgeInsetsMake(0.0, -1.0, 0.0, -1.0);
         viewController.tabBarItem = item;
         [arD addObject:viewController];
     }];
    _tabC.viewControllers = arD;
}



-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    id no= [CstmMsg sharedInstance].cstmNo;
    
    
    if([viewController.title isEqualToString:@"MenberMainViewController"] || [viewController.title isEqualToString:@"ShoppingCarViewController"])
    {
        
        if ([CstmMsg sharedInstance].cstmNo==nil  ) {
            loginViewController=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            loginViewController.whereComeIn=@"tabbar";
            [self presentViewController:loginViewController animated:NO completion:^{}];
        }
        
        
        
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        appDelegate.isMainpage=false;
    }else
    {
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        appDelegate.isMainpage=true;
    }
    
    
    NSLog(@"clicked");
    return YES;
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    NSLog(@"%@",viewController.title);
}

-(void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray *)viewControllers{
    NSLog(@"will Customize");
}

-(void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed{
    if (changed) {
        NSLog(@"changed!");
    }else{
        NSLog(@"not changed");
    }
    for (UIViewController *vcs in viewControllers) {
        NSLog(@"%@",vcs.title);
    }
}

-(void)tabBarController:(UITabBarController *)tabBarController DidEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed{
    
}

@end
