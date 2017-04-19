


#import "MenberMainViewController.h"
#import "UIImageView+WebCache.h"
#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import "UpdatePwdViewController.h"
#import "OrderFormListViewController.h"

#import "MyReplaceOrdersViewController.h"//我的换货单
#import "MemberNewsViewController.h"//我的消息
#import "AddressListViewController.h"//我的地址

#import "ReservationViewController.h"//预定资格查询
#import "EditMemberViewController.h"//会员信息编辑
#import "TouSuListViewController.h"//我的投诉
#import "ReplenishmentOrderViewController.h"//我的补退款
#import "MyYaoHaoViewController.h"//我的摇号
#import "Device.h"
#import "AppDelegate.h"
@implementation MenberMainViewController
//我的账户
@synthesize titleTextView;
//张三
@synthesize userNameTextView;
//完善资料
@synthesize toCompleteInfoTextView;
//修改密码
@synthesize modifyPwdTextView;
//我的消息pic
@synthesize myMessagePicImageView;
//我的消息
@synthesize myMessageTextView;
//right
@synthesize rightImageView;
//我的订单pic
@synthesize myOrderFormImageView;
//待支付
@synthesize waitPayButton;
//待收货
@synthesize waitReceiveButton;
//全部订单
@synthesize allOrderFormButton;
//零售订单pic
@synthesize retailOrderFormPicImageView;
//零售订单
@synthesize retailOrderFormTextView;
//right

//新邮预订订单pic
@synthesize postnewOrderFormPicImageView;
//新邮预订订单
@synthesize postnewOrderFormTextView;
//right

//diyOrderFormPic
@synthesize diyOrderFormPicImageView;
//个性化定制订单
@synthesize diyOrderFromTextView;
//right

//我的补退款
@synthesize myBackMoneyPicImageView;
//我的补退款
@synthesize myBackMoneyTextView;
//right

//我的换货pic
@synthesize myChangePicImageView;
//我的换货
@synthesize myChangeTextView;
//right

//我的投诉pic
@synthesize myComplainImageView;
//我的投诉
@synthesize myComplanTextView;
//right

//我的地址pic
@synthesize myAddressPicImageView;
//我的地址
@synthesize myAddressTextView;
//right

//我的预订资格
@synthesize myBookIsPicImageView;
//我的预订资格
@synthesize myBookIsTextView;
//right

bool waitPay;
bool waitReceive;
bool all;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    
    UITapGestureRecognizer *_left = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handTap)];
    [self.modifyPwdTextView addGestureRecognizer:_left];
    
    
 

    UITapGestureRecognizer *myOrderGestutre = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myOrderTap)];
    [self.myOrder addGestureRecognizer:myOrderGestutre];
    
    
    /*会员信息编辑 begin*/
    self.toCompleteInfoTextView.userInteractionEnabled=YES;
    UITapGestureRecognizer *editMemberGestutre = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editMemberTap)];
    [self.toCompleteInfoTextView addGestureRecognizer:editMemberGestutre];
    /*会员信息编辑 end*/
    
    /*我的消息 begin*/
    self.myMessageTextView.userInteractionEnabled=YES;
    UITapGestureRecognizer *myNewGestutre = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myNewTap)];
    [self.myMessageTextView addGestureRecognizer:myNewGestutre];
    /*我的消息 end*/
    
    /*我的摇号 begin*/

    UITapGestureRecognizer *myYaoHaoGestutre = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myYaoHaoTap)];
    [self.myYaoHaoView addGestureRecognizer:myYaoHaoGestutre];
    /*我的补退款 end*/
    
    /*我的补退款 begin*/
    self.myBackMoneyTextView.userInteractionEnabled=YES;
    UITapGestureRecognizer *myBackMoneyGestutre = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myBackMoneyTap)];
    [self.myBackMoneyTextView addGestureRecognizer:myBackMoneyGestutre];
    /*我的补退款 end*/
    
    /*我的换货 begin*/
    self.myChangeTextView.userInteractionEnabled =YES;
    UITapGestureRecognizer *myReplaceOrderGestutre = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myReplaceOrderTap)];
    [self.myChangeTextView addGestureRecognizer:myReplaceOrderGestutre];
    /*我的换货 end*/
    
    /*我的投诉 begin*/
    self.myComplanTextView.userInteractionEnabled=YES;
    UITapGestureRecognizer *myComplanGestutre = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myComplanTap)];
    [self.myComplanTextView addGestureRecognizer:myComplanGestutre];
    /*我的投诉 end*/
    
    /*我的地址 begin*/
    self.myAddressTextView.userInteractionEnabled=YES;
    UITapGestureRecognizer *myAddressGestutre = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myAddressTap)];
    [self.myAddressTextView addGestureRecognizer:myAddressGestutre];
    /*我的地址 end*/
    
    
    /*我的预定资格 begin*/
    self.myBookIsTextView.userInteractionEnabled=YES;
    UITapGestureRecognizer *myBookGestutre = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myBookTap)];
    [self.myBookIsTextView addGestureRecognizer:myBookGestutre];
    /*我的预定资格 end*/
    
    
    //零售订单
    UITapGestureRecognizer *retailOrderFormTextViewtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(retailOrderFormTextViewhandtap)];
    [self.retailOrderFormTextView addGestureRecognizer:retailOrderFormTextViewtap];
    
    
    UITapGestureRecognizer *youpinglingshoulabeltap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(youpinglingshoulabelhandtap)];
    [self.youpinglingshoulabel addGestureRecognizer:youpinglingshoulabeltap];
    
    
    //新邮预订订单
    UITapGestureRecognizer *postnewOrderFormTextViewtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(postnewOrderFormTextViewhandtap)];
    [self.postnewOrderFormTextView addGestureRecognizer:postnewOrderFormTextViewtap];
    
    //个性化订单
    UITapGestureRecognizer *diyOrderFromTextViewtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(diyOrderFromTextViewhandtap)];
    [self.diyOrderFromTextView addGestureRecognizer:diyOrderFromTextViewtap];
    
    
    //个性化订单
    UITapGestureRecognizer *logouttap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(logouthandtap)];
    [self.logout addGestureRecognizer:logouttap];
    
    
    
    self.waitAllSegment.segmentedControlStyle = UISegmentedControlStylePlain;
   
    //瞬时单击
    //segmentedControl.momentary = YES; //按钮被按下后很快恢复，默认为选中状态就一直保持
    
    // 待支付  待收货  全部
     self.waitAllSegment.selectedSegmentIndex = 2; //初始指定第0个选中
     waitPay=false;
     waitReceive=false;
     all=true;
    
    
    [ self.waitAllSegment addTarget:self action:@selector(controlPressed:) forControlEvents:UIControlEventValueChanged];
    
    [self uiInit];
 
    
}

-(void)logouthandtap
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"是否注销？"
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定", nil];
    alert.tag=1;
    
    [alert show];

}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==0)
    {//有新版本，是否更新？
        if (buttonIndex==1) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps ://itunes.apple.com/gb/app/yi-dong-cai-bian/id391945719?mt=8"]];
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


-(void)diyOrderFromTextViewhandtap
{
    OrderFormListViewController *orderFormListViewController=[[OrderFormListViewController alloc ] initWithNibName:@"OrderFormListViewController" bundle:nil];
   
    orderFormListViewController.orderFormTypeNo=@"71";//个性化
    orderFormListViewController.waitPay=waitPay;
    orderFormListViewController.waitReceive=waitReceive;
    orderFormListViewController.all=all;
    
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:orderFormListViewController animated:YES];
     self.hidesBottomBarWhenPushed=NO;
//    [self presentViewController:orderFormListViewController animated:NO completion:^{}];

}




-(void)postnewOrderFormTextViewhandtap
{
    OrderFormListViewController *orderFormListViewController=[[OrderFormListViewController alloc ] initWithNibName:@"OrderFormListViewController" bundle:nil];
       orderFormListViewController.orderFormTypeNo=@"66";//新邮预订
    orderFormListViewController.waitPay=waitPay;
    orderFormListViewController.waitReceive=waitReceive;
    orderFormListViewController.all=all;
    
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:orderFormListViewController animated:YES];
     self.hidesBottomBarWhenPushed=NO;
//    [self presentViewController:orderFormListViewController animated:NO completion:^{}];

}

-(void)retailOrderFormTextViewhandtap
{
    OrderFormListViewController *orderFormListViewController=[[OrderFormListViewController alloc ] initWithNibName:@"OrderFormListViewController" bundle:nil];
       orderFormListViewController.orderFormTypeNo=@"67";//邮票零售
    orderFormListViewController.waitPay=waitPay;
    orderFormListViewController.waitReceive=waitReceive;
    orderFormListViewController.all=all;
    
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:orderFormListViewController animated:YES];
    self.hidesBottomBarWhenPushed=NO;
//    [self presentViewController:orderFormListViewController animated:NO completion:^{}];

}
-(void)youpinglingshoulabelhandtap
{
    OrderFormListViewController *orderFormListViewController=[[OrderFormListViewController alloc ] initWithNibName:@"OrderFormListViewController" bundle:nil];
      orderFormListViewController.orderFormTypeNo=@"68";//邮品零售
    orderFormListViewController.waitPay=waitPay;
    orderFormListViewController.waitReceive=waitReceive;
    orderFormListViewController.all=all;
    
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:orderFormListViewController animated:YES];
     self.hidesBottomBarWhenPushed=NO;
//    [self presentViewController:orderFormListViewController animated:NO completion:^{}];
    
}



-(void) viewWillAppear:(BOOL)animated{
    
    CstmMsg *cst=[CstmMsg sharedInstance];
    [userNameTextView setText:cst.userName];
    
}



//SegmentedControl触发的动作
-(void)controlPressed:(id)sender{
    
    UISegmentedControl *control = (UISegmentedControl *)sender;
    
    if (control ==  self.waitAllSegment) {
        
        int x = control.selectedSegmentIndex;
        
        /*添加代码，对片段变化做出响应*/
        if(x==0)
        {//待支付
            waitPay=true;
            waitReceive=false;
            all=false;
        }else if (x==1)
        {//待收货
            waitPay=false;
            waitReceive=true;
            all=false;
            
        }else if(x==2)
        {//全部订单
            
            waitPay=false;
            waitReceive=false;
            all=true;
            
        }
        
    }
    
}


-(void)myOrderTap
{
    OrderFormListViewController *orderFormListViewController=[[OrderFormListViewController alloc ] initWithNibName:@"OrderFormListViewController" bundle:nil];
       orderFormListViewController.orderFormTypeNo=@"67";//邮票零售
    
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:orderFormListViewController animated:YES];
     self.hidesBottomBarWhenPushed=NO;
//      [self presentViewController:orderFormListViewController animated:NO completion:^{}];
}

-(void)handTap
{
     UpdatePwdViewController *updatePwdViewController=[[UpdatePwdViewController alloc] initWithNibName:@"UpdatePwdViewController" bundle:nil];
//    [self.navigationController pushViewController:updatePwdViewController animated:NO];
   [self presentViewController:updatePwdViewController animated:NO completion:^{}];
  
}



-(void) setUiValue{

////我的账户
//[titleTextView setValue:]
////张三
//[userNameTextView setValue:]
////完善资料
//[toCompleteInfoTextView setValue:]
////修改密码
//[modifyPwdTextView setValue:]
////我的消息pic
//[myMessagePicImageView setImage:[UIImage imageNamed:@"1.jpeg"]]
//[myMessagePicImageView setImageWithURL:[NSURL URLWithString:  placeholderImage:[UIImage imageNamed:@"default.jpg"]];
////我的消息
//[myMessageTextView setValue:]
////right
//[rightImageView setImage:[UIImage imageNamed:@"1.jpeg"]]
//[rightImageView setImageWithURL:[NSURL URLWithString:  placeholderImage:[UIImage imageNamed:@"default.jpg"]];
////我的订单pic
//[myOrderFormImageView setImage:[UIImage imageNamed:@"1.jpeg"]]
//[myOrderFormImageView setImageWithURL:[NSURL URLWithString:  placeholderImage:[UIImage imageNamed:@"default.jpg"]];
////零售订单pic
//[retailOrderFormPicImageView setImage:[UIImage imageNamed:@"1.jpeg"]]
//[retailOrderFormPicImageView setImageWithURL:[NSURL URLWithString:  placeholderImage:[UIImage imageNamed:@"default.jpg"]];
////零售订单
//[retailOrderFormTextView setValue:]
////right
//[rightImageView setImage:[UIImage imageNamed:@"1.jpeg"]]
//[rightImageView setImageWithURL:[NSURL URLWithString:  placeholderImage:[UIImage imageNamed:@"default.jpg"]];
////新邮预订订单pic
//[postnewOrderFormPicImageView setImage:[UIImage imageNamed:@"1.jpeg"]]
//[postnewOrderFormPicImageView setImageWithURL:[NSURL URLWithString:  placeholderImage:[UIImage imageNamed:@"default.jpg"]];
////新邮预订订单
//[newPostOrderFormTextView setValue:]
////right
//[rightImageView setImage:[UIImage imageNamed:@"1.jpeg"]]
//[rightImageView setImageWithURL:[NSURL URLWithString:  placeholderImage:[UIImage imageNamed:@"default.jpg"]];
////diyOrderFormPic
//[diyOrderFormPicImageView setImage:[UIImage imageNamed:@"1.jpeg"]]
//[diyOrderFormPicImageView setImageWithURL:[NSURL URLWithString:  placeholderImage:[UIImage imageNamed:@"default.jpg"]];
////个性化定制订单
//[diyOrderFromTextView setValue:]
////right
//[rightImageView setImage:[UIImage imageNamed:@"1.jpeg"]]
//[rightImageView setImageWithURL:[NSURL URLWithString:  placeholderImage:[UIImage imageNamed:@"default.jpg"]];
////我的补退款
//[myBackMoneyPicImageView setImage:[UIImage imageNamed:@"1.jpeg"]]
//[myBackMoneyPicImageView setImageWithURL:[NSURL URLWithString:  placeholderImage:[UIImage imageNamed:@"default.jpg"]];
////我的补退款
//[myBackMoneyTextView setValue:]
////right
//[rightImageView setImage:[UIImage imageNamed:@"1.jpeg"]]
//[rightImageView setImageWithURL:[NSURL URLWithString:  placeholderImage:[UIImage imageNamed:@"default.jpg"]];
////我的换货pic
//[myChangePicImageView setImage:[UIImage imageNamed:@"1.jpeg"]]
//[myChangePicImageView setImageWithURL:[NSURL URLWithString:  placeholderImage:[UIImage imageNamed:@"default.jpg"]];
////我的换货
//[myChangeTextView setValue:]
////right
//[rightImageView setImage:[UIImage imageNamed:@"1.jpeg"]]
//[rightImageView setImageWithURL:[NSURL URLWithString:  placeholderImage:[UIImage imageNamed:@"default.jpg"]];
////我的投诉pic
//[myComplainImageView setImage:[UIImage imageNamed:@"1.jpeg"]]
//[myComplainImageView setImageWithURL:[NSURL URLWithString:  placeholderImage:[UIImage imageNamed:@"default.jpg"]];
////我的投诉
//[myComplanTextView setValue:]
////right
//[rightImageView setImage:[UIImage imageNamed:@"1.jpeg"]]
//[rightImageView setImageWithURL:[NSURL URLWithString:  placeholderImage:[UIImage imageNamed:@"default.jpg"]];
////我的地址pic
//[myAddressPicImageView setImage:[UIImage imageNamed:@"1.jpeg"]]
//[myAddressPicImageView setImageWithURL:[NSURL URLWithString:  placeholderImage:[UIImage imageNamed:@"default.jpg"]];
////我的地址
//[myAddressTextView setValue:]
////right
//[rightImageView setImage:[UIImage imageNamed:@"1.jpeg"]]
//[rightImageView setImageWithURL:[NSURL URLWithString:  placeholderImage:[UIImage imageNamed:@"default.jpg"]];
////我的预订资格
//[myBookIsPicImageView setImage:[UIImage imageNamed:@"1.jpeg"]]
//[myBookIsPicImageView setImageWithURL:[NSURL URLWithString:  placeholderImage:[UIImage imageNamed:@"default.jpg"]];
////我的预订资格
//[myBookIsTextView setValue:]
////right
//[rightImageView setImage:[UIImage imageNamed:@"1.jpeg"]]
//[rightImageView setImageWithURL:[NSURL URLWithString:  placeholderImage:[UIImage imageNamed:@"default.jpg"]];
}

#pragma mark -会员信息编辑
-(void)editMemberTap
{
    EditMemberViewController *view =[[EditMemberViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:view animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark -我的消息
-(void)myNewTap
{
    MemberNewsViewController*myNewView =[[MemberNewsViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myNewView animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark -我的摇号
-(void)myYaoHaoTap
{
    MyYaoHaoViewController *view =[[MyYaoHaoViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:view animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}


#pragma mark -我的补退款
-(void)myBackMoneyTap
{
    ReplenishmentOrderViewController *view =[[ReplenishmentOrderViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:view animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark- 我的换货
-(void)myReplaceOrderTap
{
    MyReplaceOrdersViewController *myReplaceOrderView =[[MyReplaceOrdersViewController alloc]init];
     self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myReplaceOrderView animated:YES];
    self.hidesBottomBarWhenPushed = NO;

}

#pragma mark -我的投诉
-(void)myComplanTap
{
    TouSuListViewController *view =[[TouSuListViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    view.orderNo=@"";
    [self.navigationController pushViewController:view animated:YES];
    self.hidesBottomBarWhenPushed = NO;

}

#pragma mark -我的地址
-(void)myAddressTap
{
    AddressListViewController*view =[[AddressListViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:view animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark -我的预定资格
-(void)myBookTap
{
     ReservationViewController *view =[[ReservationViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:view animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}


-(void) uiInit
{
    int y=self.headView.frame.origin.y
    +self.headView.frame.size.height;
    
    int tabH=[Device sharedInstance].tabHeight;
    
    
  
    
    [self.scroll setFrame:CGRectMake(0, self.headView.frame.origin.y
                                    +self.headView.frame.size.height-20
                                     , self.scroll.frame.size.width, self.view.frame.size.height-self.headView.frame.size.height-tabH+0)];
    self.scroll.contentSize=CGSizeMake(320, self.scroll.frame.size.height+120);
}
@end

