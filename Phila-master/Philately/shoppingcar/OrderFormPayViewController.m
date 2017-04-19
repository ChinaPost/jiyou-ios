//注入网络请求,响应,等待提示



#import "OrderFormPayViewController.h"
#import "UIImageView+WebCache.h"
#import <Foundation/Foundation.h>
#import <PublicFramework/JSONKit.h>

#import "RespondParam0038.h"
#import "OrderFormListViewController.h"
#import "RespondParam0027.h"
#import "SectionRowChirld.h"
#import "OderPayViewTableViewCell.h"
#import "ProductOrderForm.h"
#import "ShoppingCarViewController.h"
#import "ProductdetailViewController.h"
#import "FirstPageViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "MainViewController.h"
#import "AppDelegate.h"
#import "PayedSuccessViewController.h"
#import "RespondParam0032.h"
//注入table功能
 NSString *OrderFormPayIdentifier = @"ShoppingCarEmptyTableViewCell";
@implementation OrderFormPayViewController

@synthesize orderForms;//RespondParam0038


@synthesize cacheCells;
//back
@synthesize backButton;
//购物车
@synthesize titleTextView;
//shoppingcar
@synthesize shoppingcarImageView;
//您的购物车是空的
@synthesize emptyTitleTextView;
//linehead
@synthesize lineheadImageView;
//热门推荐
@synthesize hotTitleTextView;
//linehead2
@synthesize linehead2ImageView;
//list
@synthesize tableView;
NSMutableArray *listData;

- (void)viewDidLoad
{
    [super viewDidLoad];
//table
    [tableView setDelegate:self];//指定委托
    [tableView setDataSource:self];//指定数据委托
     cacheCells = [NSMutableDictionary dictionary];
    
      self.tableView.tableFooterView=[[UIView alloc]init];//关键语句
    //使用自定义的Cell,需要向UITableView进行注册
    UINib *cellNib = [UINib nibWithNibName:@"ShoppingCarEmptyTableViewCell" bundle:nil];
    [tableView registerNib:cellNib forCellReuseIdentifier:OrderFormPayIdentifier];
 // UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handTap)];
   // [self.modifyPwdTextView addGestureRecognizer:tap];
     guestYouLikeViewController=[[GuestYouLikeViewController alloc] initWithNibName:@"GuestYouLikeViewController" bundle:nil];
    
    [self ui:nil];
    [self request0027];
}


//ui
-(void)ui:(NSMutableArray*)data
{
     //订单列表
    int x=self.scrollView.frame.origin.x;
    int y=2;
    int starty=self.scrollView.frame.origin.y;
    int width=self.scrollView.frame.size.width;
    int startheight=self.scrollView.frame.size.height;
    
    NSString *orderState=@"";
    for (RespondParam0038 *item in orderForms) {
         OderPayViewTableViewCell    *cell1 = [[[NSBundle mainBundle] loadNibNamed:@"OderPayViewTableViewCell" owner:self options:nil] lastObject];
         int height=cell1.frame.size.height;
        
        cell1.orderNoLabel.text=item.orderNo;
        cell1.orderFormPriceLabel.text=[NSString stringWithFormat:@"¥%.2f",item.orderTotalAmount];
        //cell1.payWayLabel.text=@"";

        orderState=item.orderStatus;
        
        [cell1 setFrame:CGRectMake(x, y , width, height)];
        y+=height+1;
        
        [self.scrollView addSubview:cell1];
    }
    
    //订单列表
    [self.scrollView setFrame:CGRectMake(x, starty, width, y)];
   
   //buttonView
    [self.buttonView setFrame:CGRectMake(x, self.scrollView.frame.origin.y+self.scrollView.frame.size.height, width, self.buttonView.frame.size.height)];

    
    
    
    
    
    if(data==nil || [data count]<1)
    {
        int guestViewstart=self.buttonView.frame.origin.y+self.buttonView.frame.size.height+1;
        [self.guestYouLikeView setFrame:CGRectMake(0, guestViewstart, self.guestYouLikeView.frame.size.width, self.guestYouLikeView.frame.size.height)];
    
    }else
    {
    //猜你喜欢View
    UIView  *realGuestView=[guestYouLikeViewController setUiValue:data type:@"" delegate:self];
    
    [realGuestView setFrame:CGRectMake(0, self.hotTitleTextView.frame.size.height+5, self.guestYouLikeView.frame.size.width, realGuestView.frame.size.height)];
    
    
    
     int guestViewstart=self.buttonView.frame.origin.y+self.buttonView.frame.size.height+1;
     [self.guestYouLikeView setFrame:CGRectMake(0, guestViewstart, self.guestYouLikeView.frame.size.width, realGuestView.frame.size.height+self.hotTitleTextView.frame.size.height+5)];
    
        //填空白
     [self.whiteView setFrame:CGRectMake(0, guestViewstart, self.whiteView.frame.size.width,
                                     
                                     self.view.frame.size.height-self.headView.frame.size.height-guestViewstart)];
     
    
    [self.guestYouLikeView addSubview:realGuestView];
    

        [self.scrollContainer setFrame:CGRectMake(0, self.headView.frame.size.height, self.headView.frame.size.width, self.view.frame.size.height-self.headView.frame.size.height)];
        
        self.scrollContainer.contentSize=CGSizeMake(self.scrollContainer.frame.size.width, self.guestYouLikeView.frame.origin.y+self.guestYouLikeView.frame.size.height) ;
   

    
    }
    
    //button
    if ([orderState isEqualToString:@"01"]) {//摇号
        
        [self.gotoOrderList addTarget:self action:@selector(gotoOrderListClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.goToPayBtn setHidden:NO];
        [self.gotoMain addTarget:self action:@selector(gotoMainClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.goToPayBtn setHidden:NO];
        [self.goToPayBtn addTarget:self action:@selector(goToPayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.goToPayBtn setHidden:YES];
        [self.tip setHidden:NO];
        
    }else if([orderState isEqualToString:@"02"])
    {//等待买家付款
        [self.goToPayBtn addTarget:self action:@selector(goToPayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.goToPayBtn setHidden:NO];
    
        
        //[self.goToPayBtn setFrame:CGRectMake(self.buttonView.frame.size.width/2-self.goToPayBtn.frame.size.width/2, self.buttonView.frame.size.height/2-self.goToPayBtn.frame.size.height/2, self.goToPayBtn.frame.size.width, self.goToPayBtn.frame.size.height)];
        
        [self.gotoOrderList addTarget:self action:@selector(gotoOrderListClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.gotoOrderList setHidden:YES];
        
        [self.gotoMain addTarget:self action:@selector(gotoMainClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.gotoMain setHidden:NO];
        [self.tip setHidden:YES];
    }else
    {
        
        [self.goToPayBtn setHidden:YES];
        [self.gotoOrderList setHidden:YES];
        
        [self.gotoMain addTarget:self action:@selector(gotoMainClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.gotoMain setHidden:NO];
        
        [self center:self.gotoMain parent:self.buttonView];
    
    }
    
   

}

-(void)center:(UIView*)chirld parent:(UIView*)parent
{

       [chirld setFrame:CGRectMake(parent.frame.size.width/2-chirld.frame.size.width/2, parent.frame.size.height/2-chirld.frame.size.height/2, chirld.frame.size.width, chirld.frame.size.height)];
    
}


-(void)gotoOrderListClick:(UIButton*)btn
{
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[MainViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}

-(void)gotoMainClick:(UIButton*)btn
{
    bool FirstPageViewControllerNavi=false;
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if (![controller isKindOfClass:[FirstPageViewController class]] && ![controller isKindOfClass:[ShoppingCarViewController class]]&& ![controller isKindOfClass:[MenberMainViewController class]]
            ) {
//            FirstPageViewControllerNavi=true;
//            [self.navigationController popToViewController:controller animated:YES];
            [controller removeFromParentViewController];

        }
    }
    
    
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [appDelegate.tabbar setSelectedIndex:0];
    
 
    
//    if (FirstPageViewControllerNavi==false) {
//        for (UIViewController *controller in self.navigationController.viewControllers) {
//            if ([controller isKindOfClass:[ShoppingCarViewController class]] ) {
//               
//                [self.navigationController popToViewController:controller animated:YES];
//                
////                  AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
////                [appDelegate.tabbar setHidesBottomBarWhenPushed:NO];
////                [appDelegate.tabbar setSelectedIndex:0];
//            }
//        }
//        
//    }
    
}


-(void)goToPayBtnClick:(UIButton*)btn
{
    [btn setEnabled:NO];
    
    [self performSelector:@selector(initPayBtn) withObject:nil afterDelay:30.0f];
    
    dispatch_async(dispatch_get_main_queue(), ^{
          [self makePay];
    });
  
    
    

}



/*购物车查询0032*/
NSString  *nnn0032=@"JY0032";
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
    
    _sysBaseInfo.isOpenLoading=false;
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:nnn0032 business:businessparam delegate:self viewController:self];
}




/*猜你喜欢0027*/
NSString  *nn0027=@"JY0027";
/*猜你喜欢0027*/
-(void) request0027{
    
    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 商品代号 备注:选填*/
    [businessparam setValue:[NSString stringWithFormat:@"%@",@"16565"  ] forKey:@"merchID"];
    
    [businessparam setValue:@"67" forKey:@"busiNo"];
    /* 当前页码 备注:必填*/
    [businessparam setValue:@"1" forKey:@"pageCode"];
    /* 页码大小 备注:必填*/
    [businessparam setValue:@"10" forKey:@"pageNum"];
    
    
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
      _sysBaseInfo.isOpenLoading=true;
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:nn0027 business:businessparam delegate:self viewController:self];
}


-(void) ReturnError:(MsgReturn*)msgReturn
{
    
}

-(void) ReturnData:(MsgReturn*)msgReturn
{
    
    //NSMutableArray *listData=[[NSMutableArray alloc]init];
    /*猜你喜欢0027*/
    if ([msgReturn.formName isEqualToString:nn0027]){
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        
        RespondParam0027 *commonItem1=[[RespondParam0027 alloc]init];
        /* 最大记录数 备注:*/
        commonItem1.totalNum=[[returnDataBody objectForKey:@"totalNum"] intValue];
        /* 本次返回的记录数 备注:循环域开始*/
        commonItem1.recordNum=[[returnDataBody objectForKey:@"recordNum"]intValue ];
        
        if (commonItem1.recordNum>6) {
            commonItem1.recordNum=6;
        }
        
        NSMutableArray *rows=[[NSMutableArray alloc] init ];
        for (int i=0; i<commonItem1.recordNum; i++) {
            RespondParam0027 *commonItem=[[RespondParam0027 alloc]init];
            /* 商品代号 备注:*/
            commonItem.merchID=[returnDataBody objectForKey:@"merchID"][i];
            /* 商品名称 备注:*/
            commonItem.merchName=[returnDataBody objectForKey:@"merchName"][i];
            /* 商品类别代号 备注:*/
            commonItem.merchType=[returnDataBody objectForKey:@"merchType"][i];
            /* 商品价格 备注:*/
            commonItem.merchPrice=[([returnDataBody objectForKey:@"merchPrice"][i]) floatValue];
            commonItem.merchPicID=[returnDataBody objectForKey:@"merchPicID"][i] ;
            commonItem.merchSaleType=[returnDataBody objectForKey:@"merchSaleType"][i] ;
            /* 图片ID 备注:*/
            commonItem.busiNo=[returnDataBody objectForKey:@"busiNo"][i];
            /* 本次返回的记录数 备注:循环域结束*/
            [rows addObject:commonItem];
        }
        
        
        Row *sectionRow;
        NSMutableArray *listdata=[[NSMutableArray alloc] init ];
        for (int i=0; i<[rows count]; i++) {
            RespondParam0027 *commonItem2=rows[i];
            
            
            if (i==0 || i%3==0) {
                sectionRow=[[Row alloc ] init];
                sectionRow.rowChirlds=[[NSMutableArray alloc]init];
                [listdata addObject:sectionRow];
                
                
            }
            
            Chirld *rowChirld=[[Chirld alloc] init ];
            rowChirld.businNo=commonItem2.busiNo;
            rowChirld.productId=commonItem2.merchID;
            rowChirld.pic=commonItem2.merchPicID;
            rowChirld.merchSaleType=commonItem2.merchSaleType;
            rowChirld.picName=commonItem2.merchName;
            rowChirld.picPrice=[NSString stringWithFormat:@"%.2f",commonItem2.merchPrice] ;
            
            //chirld add
            [sectionRow.rowChirlds addObject:rowChirld];
            
            
        }
        
        [self ui:listdata];
        
        dispatch_async(dispatch_get_main_queue(), ^{
              [self request0032];
        });
       
        
    }
    
    
    //NSMutableArray *listData=[[NSMutableArray alloc]init];
    /*购物车查询0032*/
    if ([msgReturn.formName isEqualToString:nnn0032]){
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
    }
    
}



//-(void)handTap{
//    [self presentViewController:updatePwdViewController animated:NO completion:^{}];
//[self dismissViewControllerAnimated:NO completion:^(){}]; 
//}
-(void) viewWillAppear:(BOOL)animated{
//table
[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
   
}


-(void) initPayBtn
{
   [self.goToPayBtn setEnabled:YES];

}


-(void)chirldViewCallBack:(NSString *)mtype data:(NSMutableArray *)mdata
{

    
 

}

#pragma mark - 支付宝支付
-(void)makePay
{
    NSMutableArray* orderlist=[NSMutableArray array];

    
    CstmMsg *_cstmmsg = [CstmMsg sharedInstance];
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    [para setValue:_cstmmsg.cstmNo forKey:@"cstmNo"];
    
    NSString* payMode =@"01";
    [para setValue:payMode forKey:@"payMode"];
    
    NSString* paytype =@"61";
    [para setValue:paytype forKey:@"payType"];
    
    
    NSString* ordernum =[NSString stringWithFormat:@"%lu",(unsigned long)orderForms.count];
    [para setValue:ordernum forKey:@"orderNoNum"];
    
    for (RespondParam0038 *item in orderForms) {
        [orderlist addObject:item.orderNo];
    }
    [para setValue:orderlist forKey:@"orderNo"];

    
    OrderPay0039* PayClass =[[OrderPay0039 alloc]init];
    [PayClass orderPay:para delegate:self];
}

-(void)payResult:(NSDictionary *)resultDic
{
     [self.goToPayBtn setEnabled:YES];
    
    NSLog(@"reslut = %@",resultDic);
    NSString*status =[resultDic objectForKey:@"resultStatus"];
    if ([status isEqual:@"9000"]) {
        NSLog(@"支付宝支付成功");
        
        NSString*strresult =[resultDic objectForKey:@"result"];
        NSLog(@"%@",strresult);
        NSArray* resultArr =[strresult componentsSeparatedByString:@"&"];
        NSMutableArray* keyArr =[[NSMutableArray alloc]init];
        NSMutableArray* valueArr =[[NSMutableArray alloc]init];
        
        for (int i =0; i<resultArr.count; i++) {
            NSArray* tmparr =[resultArr[i] componentsSeparatedByString:@"="];
            [keyArr addObject:tmparr[0]];
            [valueArr addObject:tmparr[1]];
        }
        
        NSDictionary *dicResult =[[NSDictionary alloc]initWithObjects:valueArr forKeys:keyArr];
        
        NSString* totalmoney =[[dicResult objectForKey:@"total_fee"] stringByReplacingOccurrencesOfString:@"\"" withString:@""] ;
        
        PayedSuccessViewController* paysuccessView =[[PayedSuccessViewController alloc]init];
        paysuccessView.money = totalmoney;
        [self.navigationController pushViewController:paysuccessView animated:YES];

    }else if ([status isEqual:@"6001"]) {
        NSLog(@"用户取消支付宝支付");
    }
    else
    {
        UIAlertView* alter =[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"支付宝支付失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        NSLog(@"支付宝支付失败");
    }
}
@end



