//注入网络请求,响应,等待提示



#import "ProductdetailViewController.h"
#import "UIImageView+WebCache.h"
#import <Foundation/Foundation.h>
#import <PublicFramework/JSONKit.h>
#import "RespondParam0026.h"
#import "RespondParam0027.h"
#import "ProductOrderForm.h"
#import "RespondParam0032.h"
#import <objc/runtime.h>
#import "PromptError.h"
#import "ShoppingCarViewController.h"
#import "LoginViewController.h"
#import "OrderFormPayViewController.h"

#import "GxhPostageViewController.h"
#import "SqlApp.h"
#import "FirstPageViewController.h"
#import "ProductDetailTitleTableViewCell.h"
#import "ProductDetailPriceTableViewCell.h"
#import "ProductDetailStypeTableViewCell.h"
#import "DateConvert.h"
#import "AppDelegate.h"
#import "ShoppingCarViewController.h"
#import "Toast+UIView.h"
#import "AuthenticationViewController.h"
//注入table功能
NSString *ProductdetailIdentifier = @"ProductdetailTableViewCell";
@implementation ProductdetailViewController

//产品图片

//back
@synthesize backButton;
//产品详情
@synthesize titleTextView;
//car
@synthesize carImageView;
//购物车数量
@synthesize carnumTextView;
@synthesize needFenTitleTextView;
//0
@synthesize needFenValueTextView;
//获得积分:
@synthesize getFenTitleTextView;
//3
@synthesize getFenValueTextView;
//扣除积分:
@synthesize deleteFenTextView;
//0
@synthesize deleteFenValueTextView;
//所属机构:
@synthesize belongTitleTextView;
//中国邮政网上
@synthesize belongValueTextView;
//发行时间:
@synthesize timeTextView;
//2015
@synthesize timeValueTextView;
//销售时间
@synthesize saletimeTextView;
//2015
@synthesize saletimeValueTextView;
//开始
@synthesize startTextView;
//简要描述
@synthesize detailTitleTextView;
//作者
@synthesize detailValueTextView;
//猜你喜欢

//立即购买
@synthesize buyButton;
//放进购物车
@synthesize addbuycarButton;

@synthesize productId;
@synthesize busiNo;


UIView *realGuestView;


int oneNum=1;
int fourNum=1;

static NSMutableArray *typeProducts;

NSMutableArray *pics;

RespondParam0026 *baseProductInfo=nil;

NSMutableArray *cachView;


NSString * busiNo;
NSString *productId;

AddShopping *addShopping;
GuestYouLikeViewController *guestYouLikeViewController;

int kDeviceWidth1;
int kDeviceHeight1;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.picScrollView.showsHorizontalScrollIndicator=NO;
    
    typeProducts=[[NSMutableArray alloc ]init];
    cachView=[[NSMutableArray alloc ]init];
    pics=[[NSMutableArray alloc ]init];
    
    UITapGestureRecognizer *carImageViewtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(carImageViewhandTap)];
    [self.carImageView addGestureRecognizer:carImageViewtap];
    
    
    ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
    productId=productOrderForm.productNo;
    busiNo=productOrderForm.businNo;
    
    guestYouLikeViewController=[[GuestYouLikeViewController alloc ] initWithNibName:@"GuestYouLikeViewController" bundle:nil];
    
    
    
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchDown];
    
    
    [buyButton addTarget:self action:@selector(buyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [addbuycarButton addTarget:self action:@selector(addbuycarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.diyBtn addTarget:self action:@selector(diyBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotif:) name:@"ReloadView" object:nil];
    
    
    
    if ([busiNo isEqualToString:@"71"]) {
        
        
        
        self.titleTextView.text=@"商品详情";
    }else
    {
        
        self.titleTextView.text=@"商品详情";
        
    }
    
    
    UITapGestureRecognizer *viewtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapHandle:)];
    
    [self.view addGestureRecognizer:viewtap];
    
    
    
    touchy=0;
    movelength=0;
    keyboardHeight=0;
    
    
    if(shoppingcarpicW==0)
    {
        shoppingcarpicW= self.shoppingcarpic.frame.size.width;
    }
    if(shoppingcarpicH==0)
    {
        shoppingcarpicH=self.shoppingcarpic.frame.size.height;
    }
    
    if(shoppingcarpicWEmpty==0)
    {
        shoppingcarpicWEmpty=shoppingcarpicW-10;
    }
    if(shoppingcarpicHEmpty==0)
    {
        shoppingcarpicHEmpty=shoppingcarpicH-5;
    }
    [self.shoppingcarpic setFrame:CGRectMake(self.shoppingcarpic.frame.origin.x
                                             , self.shoppingcarpic.frame.origin.y
                                             , shoppingcarpicWEmpty, shoppingcarpicHEmpty)];
    

    

        myTimer= [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(handleSchedule1) userInfo:nil repeats:YES];
 
    
    dispatch_async(dispatch_get_main_queue(), ^{
          [self request0026];
    });
  
    
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ReloadView" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    
        //取消定时器
        [myTimer invalidate];
        myTimer = nil;
}

-(void)diyBtnClicked:(UIButton*)btn
{
    if (![self isLogin]) {
        return;
    }
    
    for (RespondParam0026 *product in typeProducts) {
        if(product.isCheck)
        {
            
            if ([baseProductInfo.needAutonym isEqualToString:@"0"]) {//需要实名验证
                
                
                if ([[CstmMsg sharedInstance].isAutonym isEqualToString:@"1"]) {
                    //没有实名验证
                    AuthenticationViewController *authenticationViewController=[[AuthenticationViewController alloc ] init ];
                    
                    authenticationViewController.refreshData=^(NSString*cstmName,NSString*certNo)
                    {
                        
                        
                        
                        
                    };
                    self.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:authenticationViewController animated:YES];
                    
                    return;
                }else   if ([[CstmMsg sharedInstance].isAutonym isEqualToString:@"0"]) {
                    //已经实名验证
                }
                
            }
            
            
            GxhPostageViewController* gxhPostageView =[[GxhPostageViewController alloc]initWithNibName:@"GxhPostageViewController" bundle:nil];
            gxhPostageView.merchNum =[NSString stringWithFormat:@"%d", product.checkNum ];
            gxhPostageView.merchPrice=baseProductInfo.merchPrice;
            gxhPostageView.merchId=product.merchID;
            gxhPostageView.isModify=@"";
            gxhPostageView.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:gxhPostageView animated:YES];
        }
    }
    
    
    
}


-(void)receivedNotif:(NSNotification *)notification {
    touchy=0;
    movelength=0;
    keyboardHeight=0;
    
    typeProducts=[[NSMutableArray alloc ]init];
    
    for (UIView *view in cachView) {
        [view removeFromSuperview];
    }
    [cachView removeAllObjects];
    
    ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
    productId=productOrderForm.productNo;
    busiNo=productOrderForm.businNo;
    
    guestYouLikeViewController=[[GuestYouLikeViewController alloc ] initWithNibName:@"GuestYouLikeViewController" bundle:nil];
    [pics removeAllObjects];
    
    
    if (self.detailValueTextView!=nil) {
 
    [self.detailValueTextView setFrame:CGRectMake(self.detailValueTextView.frame.origin.x
                                                  , self.detailValueTextView.frame.origin.y
                                                  , self.detailValueTextView.frame.size.width
                                                  ,30)];
        
    }
    
    [self request0026];
    
}





-(BOOL)isLogin
{
    CstmMsg *cstmsg=[CstmMsg sharedInstance];
    if (cstmsg.cstmNo==nil) {
        
        LoginViewController *login=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        
        [self.navigationController pushViewController:login animated:NO];
        // [self presentViewController:login animated:NO completion:^{
        // }];
        
        return false;
    }
    return true;
}


-(void)carImageViewhandTap
{
    
    if (![self isLogin]) {
        return;
    }
    
    
    [self gotoShoppingView];
    
}


-(void) gotoShoppingView
{
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[ShoppingCarViewController class]] ) {
            
            [self.navigationController popToViewController:controller animated:NO];
        }else if([controller isKindOfClass:[FirstPageViewController class]] )
        {
            [self.navigationController popToViewController:controller animated:NO];
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate.tabbar setSelectedIndex:1];
            
        }
        
    }
}

bool isLeave=false;
-(void)buyButtonClicked:(UIButton *)btn{
    
    if (![self isLogin]) {
        return;
    }
    
    
    if ([baseProductInfo.needAutonym isEqualToString:@"0"]) {//需要实名验证
        
        
        if ([[CstmMsg sharedInstance].isAutonym isEqualToString:@"1"]) {
            //没有实名验证
            AuthenticationViewController *authenticationViewController=[[AuthenticationViewController alloc ] init ];
            
            authenticationViewController.refreshData=^(NSString*cstmName,NSString*certNo)
            {
                
                
                
                
            };
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:authenticationViewController animated:YES];
            
            return;
        }else   if ([[CstmMsg sharedInstance].isAutonym isEqualToString:@"0"]) {
            //已经实名验证
        }
        
    }
    
    
    
    
    NSMutableArray *tempTypeProducts=[[NSMutableArray alloc] init ];
    for (RespondParam0026 *product in  typeProducts) {
        if (product.isCheck) {
            [tempTypeProducts addObject:product];
        }
        
    }
    
    if ([tempTypeProducts count]<1) {
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        msgReturn.errorCode=@"-100";//不能为空
        msgReturn.errorDesc=@"请选择规格";
        msgReturn.errorType=@"02";
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        return;
    }
    
    
    
    
    addShopping=[[AddShopping alloc ] init ];
    [addShopping shoppingUnionCheck:productId businNo:busiNo typeProduct:tempTypeProducts delegate:self];
    isLeave=true;
    
}
-(void)addbuycarButtonClicked:(UIButton *)btn{
    
    
    if (![self isLogin]) {
        return;
    }
    
    if ([baseProductInfo.needAutonym isEqualToString:@"0"]) {//需要实名验证
        
        
        if ([[CstmMsg sharedInstance].isAutonym isEqualToString:@"1"]) {
            //没有实名验证
            AuthenticationViewController *authenticationViewController=[[AuthenticationViewController alloc ] init ];
            
            authenticationViewController.refreshData=^(NSString*cstmName,NSString*certNo)
            {
                
                
                
                
            };
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:authenticationViewController animated:YES];
            
            return;
        }else   if ([[CstmMsg sharedInstance].isAutonym isEqualToString:@"0"]) {
            //已经实名验证
        }
        
    }
    
    NSMutableArray *tempTypeProducts=[[NSMutableArray alloc] init ];
    for (RespondParam0026 *product in  typeProducts) {
        if (product.isCheck) {
            [tempTypeProducts addObject:product];
        }
        
    }
    
    if ([tempTypeProducts count]<1) {
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        msgReturn.errorCode=@"-100";//不能为空
        msgReturn.errorDesc=@"请选择规格";
        msgReturn.errorType=@"02";
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        return;
    }
    
    
    
    addShopping=[[AddShopping alloc ] init ];
    [addShopping shoppingUnionCheck:productId businNo:busiNo typeProduct:tempTypeProducts delegate:self];
    isLeave=false;
    
}

-(void)backButtonClicked:(UIButton *)btn{
    //    [self dismissViewControllerAnimated:YES completion:^{
    //
    //    }];
    
    for (UIViewController* view in self.navigationController.viewControllers) {
        if ([view isKindOfClass:[ShoppingCarViewController class]]) {
            [((ShoppingCarViewController*)view) viewDidLoad];
            [self.navigationController popToViewController:view animated:YES];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)oneCheckButtonClicked:(UIButton *)btn{
    //objc_setAssociatedObject(btn, "productId", productId, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//控件与数据绑定
    
    btn.selected = !btn.selected;
    
    
    int i=btn.tag;
    
    RespondParam0026 *product =  typeProducts[i];
    
    if (btn.selected) {
        product.isCheck=true;
    }else
    {
        product.isCheck=false;
    }
    
    
    
    //用于butoon做checkBox控件
}


-(void)oneCheckReduceButtonClicked:(UIButton *)btn{
    
    //取数据  //btn.selected = !btn.selected;
    //用于butoon做checkBox控件
    int i=btn.tag;
    
    UITextField *numTextView= objc_getAssociatedObject(btn, "numView");
    
    RespondParam0026 *product =  typeProducts[i];
    int num=product.checkNum;
    if (num>1) {
        num--;
        product.checkNum=num;
        [numTextView setText:[NSString stringWithFormat:@"%d",num]];
    }else
    {
        
        num=1;
        product.checkNum=num;
        
    }
    
}

-(void)oneCheckAddButtonClicked:(UIButton *)btn{
    
    
    UITextField *numTextView= objc_getAssociatedObject(btn, "numView");
    int i=btn.tag;
    
    RespondParam0026 *product =  typeProducts[i];
    
    int num=product.checkNum;
    
    if (num>=product.limitNum) {
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        msgReturn.errorCode=@"-100";//不能为空
        msgReturn.errorDesc=@"超过限购套数";
        msgReturn.errorType=@"01";
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        return;
    }
    
    num++;
    product.checkNum=num;
    
    [numTextView setText:[NSString stringWithFormat:@"%d",num]];
    
}



-(void)viewDidLayoutSubviews
{//table被挡住时用
    
}



-(void) setUiValue {
    
}





/*商品详情0026*/
NSString  *n0026=@"JY0026";
/*商品详情0026*/
-(void) request0026{
    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 业务代号 备注:必填*/
    [businessparam setValue:busiNo forKey:@"busiNo"];
    NSLog(@"jy0026 busino[%@]",busiNo);
    /* 商品代号 备注:必填*/
    [businessparam setValue:productId forKey:@"merchID"];
    NSLog(@"jy0026 merchID[%@]",productId);
    
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    _sysBaseInfo.isOpenLoading=true;
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0026 business:businessparam delegate:self viewController:self];
}


/*猜你喜欢0027*/
NSString  *n0027=@"JY0027";
/*猜你喜欢0027*/
-(void) request0027{
    
    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 商品代号 备注:选填*/
    [businessparam setValue:[NSString stringWithFormat:@"%@",productId  ] forKey:@"merchID"];
    
    [businessparam setValue:busiNo forKey:@"busiNo"];
    /* 当前页码 备注:必填*/
    [businessparam setValue:@"1" forKey:@"pageCode"];
    /* 页码大小 备注:必填*/
    [businessparam setValue:@"10" forKey:@"pageNum"];
    
    
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
      _sysBaseInfo.isOpenLoading=false;
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0027 business:businessparam delegate:self viewController:self];
}



/*购物车查询0032*/
NSString  *nn0032=@"JY0032";
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
    [businessparam setValue:busiNo forKey:@"busiNo"];
    
    
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:nn0032 business:businessparam delegate:self viewController:self];
}


-(void) webViewDidStartLoad:(UIWebView *)webView
{
   
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{

    
//    NSString *str = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '80%'";
//    [webView stringByEvaluatingJavaScriptFromString:str];
    
    
    //webview 自适应高度
    CGRect frame = webView.frame;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    webView.frame = frame;
    
    [self refresh:nil];
}



-(void) ReturnError:(MsgReturn*)msgReturn
{
    
}



-(void) ReturnData:(MsgReturn*)msgReturn
{
    
    /*商品详情0026*/
    if ([msgReturn.formName isEqualToString:n0026]){
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        RespondParam0026 *commonItem=[[RespondParam0026 alloc]init];
        
        
        /* 业务代号 备注:*/
        commonItem.busiNo=[returnDataBody objectForKey:@"busiNo"];
        // businNo=commonItem.busiNo;
        /* 商品代号 备注:*/
        commonItem.merchID=[returnDataBody objectForKey:@"merchID"];
        productId=commonItem.merchID;
        
        /* 商品类别代号 备注:*/
        commonItem.merchType=[returnDataBody objectForKey:@"merchType"];
        
        /* 商品名称 备注:*/
        commonItem.merchName=[returnDataBody objectForKey:@"merchName"];
        //中国古代文学
        
        
        /* 商品状态 备注:内容待定*/
        commonItem.merchStatus=[returnDataBody objectForKey:@"merchStatus"];
        commonItem.curRepertory=[[returnDataBody objectForKey:@"curRepertory"] intValue];//库存数量
        
        /* 商品内部编号 备注:*/
        commonItem.merchInterNum=[returnDataBody objectForKey:@"merchInterNum"];
        /* 商品销售价格 备注:*/
        commonItem.merchPrice=[[returnDataBody objectForKey:@"merchPrice"] floatValue];
        /* 上架机构 备注:*/
        commonItem.brchNo=[NSString stringWithFormat:@"%@",[returnDataBody objectForKey:@"brchNo"]] ;
        
        
        ////所属机构:
        //[belongTitleTextView setValue:]
        ////中国邮政网上
        belongValueTextView.text= [NSString stringWithFormat:@"%@",[returnDataBody objectForKey:@"brchName"]] ;
        
        
        /* 商品简单描述 备注:*/
        commonItem.merchDesc=[returnDataBody objectForKey:@"merchDesc"];
        ////简要描述
        //[detailTitleTextView setValue:]
        ////作者
        
        
        
        
        //detailValueTextView.text=  commonItem.merchDesc;
        
        
        
        
        /* 商品描述（URL） 备注:*/
        commonItem.merchURL=[returnDataBody objectForKey:@"merchURL"];
        /* 商品销售属性 备注:预售、销售等*/
        commonItem.merchSaleType=[returnDataBody objectForKey:@"merchSaleType"];
        
        
        /* 获取积分 备注:*/
        commonItem.gainScore=[([returnDataBody objectForKey:@"gainScore"]) intValue];
        ////获得积分:
        //[getFenTitleTextView setValue:]
        ////3
        getFenValueTextView.text=[NSString stringWithFormat:@"%d", commonItem.gainScore]  ;
        
        
        commonItem.leastScore=[([returnDataBody objectForKey:@"leastScore"]) intValue];
        ////所需最低积分
        needFenValueTextView.text=
        [NSString stringWithFormat:@"%d", commonItem.leastScore]  ;
        
        commonItem.deductScore=[([returnDataBody objectForKey:@"deductScore"]) intValue];
        ////扣除积分:
        
        deleteFenValueTextView.text=[NSString stringWithFormat:@"%d", commonItem.deductScore]  ;
        
        
        
        
        
        /* 志号编号（专业编号） 备注:*/
        commonItem.professionNum=[returnDataBody objectForKey:@"professionNum"];
        /* 发行日期 备注:格式：yyyymmdd*/
        commonItem.launchDate=[returnDataBody objectForKey:@"launchDate"];
        ////发行时间:
        //[timeTextView setValue:]
        ////2015
        
        if ([busiNo isEqualToString:@"66"]) {
            timeValueTextView.text=[NSString stringWithFormat:@"%@年",commonItem.launchDate];
        }
        else
        {
            timeValueTextView.text=[NSString stringWithFormat:@"%@",[DateConvert convertDateFromString: commonItem.launchDate] ];
        }
        
        /* 当前商品所属销售阶段 备注:针对新邮业务：以旧换新阶段、增量阶段*/
        commonItem.saleStage=[returnDataBody objectForKey:@"saleStage"];
        /* 是否实名验证商品 备注:0：需要
         1：不需要*/
        commonItem.needAutonym=[returnDataBody objectForKey:@"needAutonym"];
        /* 是否手机验证码商品 备注:0：需要
         1：不需要*/
        commonItem.needVerification=[returnDataBody objectForKey:@"needVerification"];
        
        /* 包括图片数量 备注:循环域开始*/
        commonItem.picNum=[[returnDataBody objectForKey:@"picNum"] intValue];
        for (int i=0; i<commonItem.picNum; i++) {
            RespondParam0026 *commonItem1=[[RespondParam0026 alloc]init];
            /* 图片ID 备注:*/
            commonItem1.merchPicID=[returnDataBody objectForKey:@"merchPicID"][i];
            
            [pics addObject:commonItem1.merchPicID];
            
            
            /* 图片属性 备注:主图、缩略图等*/
            commonItem1.picType=[returnDataBody objectForKey:@"picType"][i];
            /* 尺寸类型 备注:小0、中1、大2*/
            commonItem1.sizeType=[returnDataBody objectForKey:@"sizeType"][i];
            
            
            
            /* 图片顺序号 备注:*/
            commonItem1.picIndex=[([returnDataBody objectForKey:@"picIndex"][i]) intValue];
            /* 包括图片数量 备注:循环域结束*/
            
            
        }
        if (commonItem.picNum==0) {
            [pics addObject:@""];
        }
        
        
        /* 包括商品规格数量 备注:循环域开始*/
        commonItem.merchNormsNum=[[returnDataBody objectForKey:@"merchNormsNum"] intValue];
        
        
        
        for (int i=0; i<commonItem.merchNormsNum; i++) {
            RespondParam0026 *commonItem2=[[RespondParam0026 alloc]init];
            /* 商品规格 备注:单张、四方连*/
            commonItem2.normsType=[returnDataBody objectForKey:@"normsType"][i];
            
            commonItem2.normsName=[returnDataBody objectForKey:@"normsName"][i];
            /* 模式单价 备注:*/
            commonItem2.normsPrice=[([returnDataBody objectForKey:@"normsPrice"][i]) floatValue];
            
            
            /* 限购数量 备注:*/
            commonItem2.limitNum=[([returnDataBody objectForKey:@"limitNum"][i]) intValue];
            
            
            
            
            RespondParam0026  *oneInfo=[[RespondParam0026 alloc] init];
            oneInfo.limitNum=commonItem2.limitNum;
            oneInfo.normsType=commonItem2.normsType;
            oneInfo.normsName=commonItem2.normsName;
            oneInfo.merchID=commonItem.merchID;
            oneInfo.busiNo=commonItem.busiNo;
            oneInfo.merchStatus=commonItem.merchStatus;
            oneInfo.normsPrice=commonItem2.normsPrice;
            oneInfo.checkNum=1;
            oneInfo.isCheck=true;
            [typeProducts addObject:oneInfo];
            
            
            /* 包括商品规格数量 备注:循环域结束*/
            
        }
        
        
        /* 商品销售时间属性数量 备注:循环域开始*/
        commonItem.saleTimeNum=[[returnDataBody objectForKey:@"saleTimeNum"] intValue];
        for (int i=0; i<commonItem.saleTimeNum; i++) {
            RespondParam0026 *commonItem3=[[RespondParam0026 alloc]init];
            /* 时间类型 备注:0销售时间、1以旧换新时间、2增量时间*/
            commonItem3.saleTimeType=[returnDataBody objectForKey:@"saleTimeType"][i];
            
            
            /* 起始时间 备注:格式：yymmddhhmmss*/
            commonItem3.startTime=[returnDataBody objectForKey:@"startTime"][i];
            /* 截止时间 备注:*/
            commonItem3.endTime=[returnDataBody objectForKey:@"endTime"][i];
            
            if ([commonItem3.saleTimeType isEqualToString:@"0"]) {
                ////销售时间
                //[saletimeTextView setValue:]
                ////2015
                
                saletimeTextView.text=@"销售时间:";
                
                
                NSString *time=[DateConvert convertDateFromString:commonItem3.startTime];
                if (time==nil || [time isEqualToString:@""]) {
                    saletimeValueTextView.text=[NSString stringWithFormat:@"%@ ",[DateConvert convertDateFromString:commonItem3.startTime ]]  ;
                }else
                {
                    saletimeValueTextView.text=[NSString stringWithFormat:@"%@ 开始",[DateConvert convertDateFromString:commonItem3.startTime ]]  ;
                }
                
                
                NSString *time2=[DateConvert convertDateFromString:commonItem3.endTime ];
                if (time2==nil || [time2 isEqualToString:@""]) {
                    self.saleTimeValueEndTextView.text=[NSString stringWithFormat:@"%@",[DateConvert convertDateFromString:commonItem3.endTime ]]  ;
                }else
                {
                    self.saleTimeValueEndTextView.text=[NSString stringWithFormat:@"%@ 结束",[DateConvert convertDateFromString:commonItem3.endTime ]]  ;
                }
                
                ////开始
                //[startTextView setValue:]
            }   if ([commonItem3.saleTimeType isEqualToString:@"1"]) {
                ////以旧换新时间
                //[saletimeTextView setValue:]
                ////2015
                
                
                saletimeTextView.text=@"以旧换新时间:";
                
                
                NSString *time=[DateConvert convertDateFromString:commonItem3.startTime ];
                if (time==nil || [time isEqualToString:@""]) {
                    saletimeValueTextView.text=[NSString stringWithFormat:@"%@ ",[DateConvert convertDateFromString:commonItem3.startTime ]]  ;
                }else
                {
                    saletimeValueTextView.text=[NSString stringWithFormat:@"%@ 开始",[DateConvert convertDateFromString:commonItem3.startTime ]]  ;
                }
                
                
                NSString *time2=[DateConvert convertDateFromString:commonItem3.endTime ];
                if (time2==nil || [time2 isEqualToString:@""]) {
                    self.saleTimeValueEndTextView.text=[NSString stringWithFormat:@"%@ ",[DateConvert convertDateFromString:commonItem3.endTime ]]  ;
                }else
                {
                    self.saleTimeValueEndTextView.text=[NSString stringWithFormat:@"%@ 结束",[DateConvert convertDateFromString:commonItem3.endTime ]]  ;
                    
                }
                
                ////开始
                //[startTextView setValue:]
            }   if ([commonItem3.saleTimeType isEqualToString:@"2"]) {
                ////销售时间
                //[saletimeTextView setValue:]
                ////2015
                
                
                self.moreTimeTitleTextView.text=@"增量时间:";
                
                NSString *time=[DateConvert convertDateFromString:commonItem3.startTime ];
                if (time==nil || [time isEqualToString:@""]) {
                    self.moreTimeValueTextView.text=[NSString stringWithFormat:@"%@ ",[DateConvert convertDateFromString:commonItem3.startTime ]]  ;
                }else
                {
                    self.moreTimeValueTextView.text=[NSString stringWithFormat:@"%@ 开始",[DateConvert convertDateFromString:commonItem3.startTime ]]  ;
                }
                
                
                NSString *time2=[DateConvert convertDateFromString:commonItem3.endTime ];
                if (time2==nil || [time2 isEqualToString:@""]) {
                    self.moreTimeValueEndTextView.text=[NSString stringWithFormat:@"%@ ",[DateConvert convertDateFromString:commonItem3.endTime ]]  ;
                }else
                {
                    self.moreTimeValueEndTextView.text=[NSString stringWithFormat:@"%@ 结束",[DateConvert convertDateFromString:commonItem3.endTime ]]  ;
                }
                
                ////开始
                //[startTextView setValue:]
            }
            
            
            /* 商品销售时间属性数量 备注:循环域结束*/
            
        }
        
        baseProductInfo=commonItem;
        
        
       
       // dispatch_async(dispatch_get_main_queue(), ^{
        
            
            //            NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(downloadImage:) object:kURL];
            //            [thread start];
            //            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[baseProductInfo.merchDesc dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            
            // self.detailValueTextView.attributedText = attrStr;
        
        
        
             NSString *html=[NSString stringWithFormat:@"%@",  baseProductInfo.merchDesc ];
        
        
        NSString *searchText =html;
        searchText= [searchText stringByReplacingOccurrencesOfString:@"<p>" withString:@"<p style=\"FONT-SIZE: 10pt\">"];
       // searchText= [searchText stringByReplacingOccurrencesOfString:@"</p>" withString:@"</font></p>"];
        NSError *error = NULL;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(height).*?(\\d+)" options:NSRegularExpressionCaseInsensitive error:&error];
        NSArray *array= [regex matchesInString:searchText options:0 range:NSMakeRange(0, [searchText length])];
        
        int height=0;
        for (NSTextCheckingResult* b in array)
        {
            
            NSString *str1 = [searchText substringWithRange:b.range];
            NSArray *list=[str1 componentsSeparatedByString:@":"];
            
            height+=[list[1] intValue]-10;
            
        }

        
        height+=[self heightForString:searchText fontSize:12 andWidth:self.detailValueTextView.frame.size.width];
        
        
            [self.detailValueTextView setDelegate:self];
            [self.detailValueTextView loadHTMLString:searchText baseURL:nil];
      
       
        
        
        [self.detailValueTextView setFrame:CGRectMake(self.detailValueTextView.frame.origin.x
                                                      , self.detailValueTextView.frame.origin.y
                                                      , self.detailValueTextView.frame.size.width
                                                      ,height)];
        
        
        [self refresh:nil];
        
         [self request0027 ];
      //  }) ;
        
    }
    
    
    
    //NSMutableArray *listData=[[NSMutableArray alloc]init];
    /*猜你喜欢0027*/
    if ([msgReturn.formName isEqualToString:n0027]){
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
        NSMutableArray *guestYouLikeListData=[[NSMutableArray alloc] init ];
        for (int i=0; i<[rows count]; i++) {
            RespondParam0027 *commonItem2=rows[i];
            
            
            if (i==0 || i%3==0) {
                sectionRow=[[Row alloc ] init];
                sectionRow.rowChirlds=[[NSMutableArray alloc]init];
                [guestYouLikeListData addObject:sectionRow];
                
                
            }
            
            Chirld *rowChirld=[[Chirld alloc] init ];
            rowChirld.businNo=commonItem2.busiNo;
            rowChirld.productId=commonItem2.merchID;
            rowChirld.pic=commonItem2.merchPicID;
            rowChirld.picName=commonItem2.merchName;
            rowChirld.merchSaleType=commonItem2.merchSaleType;
            rowChirld.picPrice=[NSString stringWithFormat:@"%.2f",commonItem2.merchPrice] ;
            
            //chirld add
            [sectionRow.rowChirlds addObject:rowChirld];
            
            
        }
        
        [self refresh:guestYouLikeListData];
        
       // dispatch_async(dispatch_get_main_queue(), ^{
         //   [self request0032];
        //}) ;
        
  
        
        
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        UITabBarItem *tabBarItem = [appDelegate.tabbar.tabBar.items objectAtIndex:1];
        
       int shoppingcount= [[tabBarItem badgeValue] intValue];
        
        
        SqlApp *sqlApp=[[SqlApp alloc ]init ];
        int queryis=[[sqlApp selectPM_SIGNSERVICE:@"SC_QUERY_HOMEPAGE" ] intValue];
        if(queryis==0  )
        {//显示数量
            
            //购物车数量
            if (shoppingcount==0) {
                carnumTextView.text=@"";
                [self.shoppingcarpic setImage:[UIImage imageNamed:@"shoppingcarwhiteempty.png"]];
                [self.shoppingcarpic setFrame:CGRectMake(self.shoppingcarpic.frame.origin.x
                                                         , self.shoppingcarpic.frame.origin.y
                                                         , shoppingcarpicWEmpty, shoppingcarpicHEmpty)];
                
            }else
            {
                carnumTextView.text=[NSString stringWithFormat:@"%d",shoppingcount];
                [self.shoppingcarpic setImage:[UIImage imageNamed:@"shoppingcarwhite.png"]];
                [self.shoppingcarpic setFrame:CGRectMake(self.shoppingcarpic.frame.origin.x
                                                         , self.shoppingcarpic.frame.origin.y
                                                         , shoppingcarpicW, shoppingcarpicH)];
                
                
            }

        }else
        {
        
            
            carnumTextView.text=@"";
            [self.shoppingcarpic setImage:[UIImage imageNamed:@"shoppingcarwhiteempty.png"]];
            [self.shoppingcarpic setFrame:CGRectMake(self.shoppingcarpic.frame.origin.x
                                                     , self.shoppingcarpic.frame.origin.y
                                                     , shoppingcarpicWEmpty, shoppingcarpicHEmpty)];
        }
        
        
       
        
        
        
    }
    
    
    //NSMutableArray *listData=[[NSMutableArray alloc]init];
    /*购物车查询0032*/
    if ([msgReturn.formName isEqualToString:nn0032]){
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
            carnumTextView.text=@"";
            [self.shoppingcarpic setImage:[UIImage imageNamed:@"shoppingcarwhiteempty.png"]];
            [self.shoppingcarpic setFrame:CGRectMake(self.shoppingcarpic.frame.origin.x
                                                     , self.shoppingcarpic.frame.origin.y
                                                     , shoppingcarpicWEmpty, shoppingcarpicHEmpty)];
            
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            UITabBarItem *tabBarItem = [appDelegate.tabbar.tabBar.items objectAtIndex:1];
            
            [tabBarItem setBadgeValue:nil];
            
        }else
        {
            carnumTextView.text=[NSString stringWithFormat:@"%d",[dic count]];
            [self.shoppingcarpic setImage:[UIImage imageNamed:@"shoppingcarwhite.png"]];
            [self.shoppingcarpic setFrame:CGRectMake(self.shoppingcarpic.frame.origin.x
                                                     , self.shoppingcarpic.frame.origin.y
                                                     , shoppingcarpicW, shoppingcarpicH)];
            
            
            //角标
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[dic count]];
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            UITabBarItem *tabBarItem = [appDelegate.tabbar.tabBar.items objectAtIndex:1];
            
            [tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d",[dic count]]];
            
           
            
        }
        
        
        
        
        
    }
    
    
}



//-(void)downloadImage:(NSString *) url{
//    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
//    UIImage *image = [[UIImage alloc]initWithData:data];
//    if(image == nil){
//
//    }else{
//        [self performSelectorOnMainThread:@selector(updateUI:) withObject:image waitUntilDone:YES];
//    }
//}
//
//-(void)updateUI:(UIImage*) image{
//    self.imageView.image = image;
//}


-(void) refresh:(NSMutableArray*)listData
{
    int width=self.scrollView.frame.size.width;
    
    //产品图片
    
    [self initPicScrollView:pics];
    
    //产品名字
    ProductDetailTitleTableViewCell  *productDetailTitleTableViewCell = [[[NSBundle mainBundle] loadNibNamed:@"ProductDetailTitleTableViewCell" owner:self options:nil] lastObject];
    
    
    SqlApp *sql=[[SqlApp alloc ] init ];
    NSString *businoCn=[sql selectPM_ARRAYSERVICEByCode:@"BUSINESS" code:busiNo];
    
    NSString *merchSaleTypecn=[sql selectPM_ARRAYSERVICEByCode:@"MERCHSALETYPE" code:baseProductInfo.merchSaleType];
    
    if ([merchSaleTypecn isEqualToString:@""]) {
        productDetailTitleTableViewCell.preOrderTextView.text=[NSString stringWithFormat:@"%@",businoCn] ;
        productDetailTitleTableViewCell.stateView.text=[NSString stringWithFormat:@"%@",merchSaleTypecn] ;
        
        
    }else
    {
        productDetailTitleTableViewCell.preOrderTextView.text=[NSString stringWithFormat:@"%@",businoCn] ;
        
        productDetailTitleTableViewCell.stateView.text=[NSString stringWithFormat:@"[%@]",merchSaleTypecn] ;
    }
    
    //label动态高度
    productDetailTitleTableViewCell.productNameTextView.text=baseProductInfo.merchName;
    [productDetailTitleTableViewCell.productNameTextView setNumberOfLines:0];
    productDetailTitleTableViewCell.productNameTextView.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGSize productDetailTitleTableViewCellSize = [ productDetailTitleTableViewCell.productNameTextView  sizeThatFits:CGSizeMake(productDetailTitleTableViewCell.productNameTextView.frame.size.width, MAXFLOAT)];
    
    [productDetailTitleTableViewCell.productNameTextView setFrame:CGRectMake(productDetailTitleTableViewCell.productNameTextView.frame.origin.x
                                                                             , productDetailTitleTableViewCell.productNameTextView.frame.origin.y, productDetailTitleTableViewCell.productNameTextView.frame.size.width, productDetailTitleTableViewCellSize.height)];
    
    [productDetailTitleTableViewCell setFrame:CGRectMake(0, self.productPicView.frame.origin.y+self.productPicView.frame.size.height+1, width, productDetailTitleTableViewCellSize.height+15)];
    [cachView addObject:productDetailTitleTableViewCell];
    [self.scrollView addSubview:productDetailTitleTableViewCell];
    
    
    
    //价格
    int productDetailPriceTableViewCelly=productDetailTitleTableViewCell.frame.origin.y+productDetailTitleTableViewCell.frame.size.height+1;
    int productDetailPriceTableViewCellHeight=0;
    
    
    for (RespondParam0026 *product in  typeProducts) {
        
        ProductDetailPriceTableViewCell *productDetailPriceTableViewCell = [[[NSBundle mainBundle] loadNibNamed:@"ProductDetailPriceTableViewCell" owner:self options:nil] lastObject];
        
        //         NSString *normsTypeCn=[sql selectPM_ARRAYSERVICEByCode:@"MERCHNORMS" code:product.normsType];
        productDetailPriceTableViewCell.onePriceTextView.text=product.normsName;
        productDetailPriceTableViewCell.onePriceValueTextView.text=[NSString stringWithFormat:@"¥%.2f",  product.normsPrice];
        
        [productDetailPriceTableViewCell setFrame:CGRectMake(0, productDetailPriceTableViewCelly+productDetailPriceTableViewCellHeight, width, productDetailPriceTableViewCell.frame.size.height)];
        
        
        productDetailPriceTableViewCellHeight+=productDetailPriceTableViewCell.frame.size.height;
        [cachView addObject:productDetailPriceTableViewCell];
        [self.scrollView addSubview:productDetailPriceTableViewCell];
        
    }
    
    
    //选中 加减
    int productDetailStypeTableViewCelly=productDetailPriceTableViewCelly+productDetailPriceTableViewCellHeight+1;
    int productDetailStypeTableViewCellHeight=0;
    int i=0;
    for (RespondParam0026 *product in  typeProducts) {
        ProductDetailStypeTableViewCell *productDetailStypeTableViewCell = [[[NSBundle mainBundle] loadNibNamed:@"ProductDetailStypeTableViewCell" owner:self options:nil] lastObject];
        
        [productDetailStypeTableViewCell setFrame:CGRectMake(0, productDetailStypeTableViewCelly+productDetailStypeTableViewCellHeight, width, productDetailStypeTableViewCell.frame.size.height)];
        
        
        productDetailStypeTableViewCellHeight+=productDetailStypeTableViewCell.frame.size.height;
        
        [cachView addObject:productDetailStypeTableViewCell];
        [self.scrollView addSubview:productDetailStypeTableViewCell];
        
        // NSString *normsTypeCn=[sql selectPM_ARRAYSERVICEByCode:@"MERCHNORMS" code:product.normsType];
        productDetailStypeTableViewCell.oneCheckTitleTextView.text=product.normsName;
        productDetailStypeTableViewCell.oneCheckLimiteTextView.text=[NSString stringWithFormat:@"(限购%d套)",  product.limitNum];
        
        
        //check
        [productDetailStypeTableViewCell.oneCheckButton addTarget:self action:@selector(oneCheckButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        productDetailStypeTableViewCell.oneCheckButton.tag=i;
        productDetailStypeTableViewCell.oneCheckButton.selected=YES;
        [productDetailStypeTableViewCell.oneCheckButton setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateSelected];
        [productDetailStypeTableViewCell.oneCheckButton setBackgroundImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        
        
        
        //reduce
        productDetailStypeTableViewCell.oneCheckReduceButton.tag=i;
        
        objc_setAssociatedObject(productDetailStypeTableViewCell.oneCheckReduceButton, "numView",productDetailStypeTableViewCell.oneCheckNumEditText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [productDetailStypeTableViewCell.oneCheckReduceButton addTarget:self action:@selector(oneCheckReduceButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        //add
        productDetailStypeTableViewCell.oneCheckAddButton.tag=i;
        objc_setAssociatedObject(productDetailStypeTableViewCell.oneCheckAddButton, "numView",productDetailStypeTableViewCell.oneCheckNumEditText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [productDetailStypeTableViewCell.oneCheckAddButton addTarget:self action:@selector(oneCheckAddButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [productDetailStypeTableViewCell.oneCheckNumEditText setText:[NSString stringWithFormat:@"%d",oneNum]];
        
        
        
        
        
        //edit
        int carfourNum=product.checkNum;
        productDetailStypeTableViewCell.oneCheckNumEditText.text=[NSString  stringWithFormat:@"%d",carfourNum];
        
        
        productDetailStypeTableViewCell.oneCheckNumEditText.tag=i;
        
        
        [ productDetailStypeTableViewCell.oneCheckNumEditText addTarget:self action:@selector(oneNumEditTextEditTextDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
        
        [ productDetailStypeTableViewCell.oneCheckNumEditText addTarget:self action:@selector(oneNumEditTextEditTextDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
        
        
        // UITapGestureRecognizer *onenumguest=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneNumEditTextTapHandle:)];
        
        //onenumguest.delegate = self;
        //onenumguest.cancelsTouchesInView = NO;
        
        // [productDetailStypeTableViewCell.oneCheckNumEditText   addGestureRecognizer:onenumguest];
        
        
        productDetailStypeTableViewCell.oneCheckNumEditText .keyboardType=UIKeyboardTypeNumberPad;
        
        
        i++;
        
    }
    
    
    
    if ([busiNo isEqualToString:@"66"]) {//新邮预订
        
        [self.moreTimeView setFrame:CGRectMake(self.moreTimeView.frame.origin.x, self.moreTimeView.frame.origin.y, self.moreTimeView.frame.size.width, self.moreTimeView.frame.size.height)];
        [self.moreTimeView setHidden:NO];
        [self.otherInfoView setFrame:CGRectMake(0, productDetailPriceTableViewCelly+productDetailPriceTableViewCellHeight+productDetailStypeTableViewCellHeight+2, width, self.otherInfoView.frame.size.height)];
    }else
    {
        
        [self.moreTimeView setFrame:CGRectMake(self.moreTimeView.frame.origin.x, self.moreTimeView.frame.origin.y, self.moreTimeView.frame.size.width,0)];
        NSLog(@"%@",self.moreTimeView);
        [self.moreTimeView setHidden:YES];
        
        [self.otherInfoView setFrame:CGRectMake(0, productDetailPriceTableViewCelly+productDetailPriceTableViewCellHeight+productDetailStypeTableViewCellHeight+2, width, self.moreTimeView.frame.origin.y)];
        NSLog(@"%@",self.otherInfoView);
    }
    
    
    
    //简介
    
    [self.detailValueTextView setFrame:CGRectMake(self.detailValueTextView.frame.origin.x
                                                  , self.detailValueTextView.frame.origin.y
                                                  , self.detailValueTextView.frame.size.width
                                                  ,self.detailValueTextView.frame.size.height)];
    
    
    int  detailTitleHeight=self.detailTitleTextView.frame.size.height;
    
    [self.productDescView setFrame:CGRectMake(self.productDescView.frame.origin.x
                                              ,  self.otherInfoView.frame.origin.y
                                              +self.otherInfoView.frame.size.height
                                              +1, self.productDescView.frame.size.width
                                              , self.detailValueTextView.frame.size.height+detailTitleHeight+25)];

    
    
    

    
    if (listData==nil ||[listData count]<1 ) {
        
        
        [self.guestView setFrame:CGRectMake(0, self.productDescView.frame.origin.y+self.productDescView.frame.size.height+2, self.guestView.frame.size.width, self.guestView.frame.size.height)];
    }else
    {
        //猜你喜欢
        //    if (realGuestView!=nil) {
        //        [realGuestView removeFromSuperview];
        //    }
        realGuestView=[guestYouLikeViewController setUiValue:listData type:@"" delegate:self];
        
        [realGuestView setFrame:CGRectMake(0, self.guestTitle.frame.size.height+2, self.guestView.frame.size.width, realGuestView.frame.size.height)];
        
        
        [self.guestView setFrame:CGRectMake(0, self.productDescView.frame.origin.y+self.productDescView.frame.size.height+2, self.guestView.frame.size.width, realGuestView.frame.size.height+self.guestTitle.frame.size.height+15)];
        
        //     for(UIView *view in  self.guestView.subviews)
        //     {
        //         [view removeFromSuperview];
        //     }
        
        [self.guestView addSubview:realGuestView];
    }
    
    
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    [self.scrollView setFrame:CGRectMake(0, self.headView.frame.size.height, self.headView.frame.size.width, self.view.frame.size.height-self.view2.frame.size.height- self.headView.frame.size.height)];
    
    self.scrollView.contentSize=CGSizeMake(self.scrollView.frame.size.width,self.guestView.frame.origin.y+self.guestView.frame.size.height);
    
    
    //最底下按钮行
    [self.view2 setFrame:CGRectMake(0, self.view.frame.size.height-self.view2.frame.size.height, self.guestView.frame.size.width, self.view2.frame.size.height)];
    
    
    
    
    
    
    if ([busiNo isEqualToString:@"71"]) {
        [self.diyBtn setHidden:NO];
        [self.buyButton setHidden:YES];
        [self.addbuycarButton setHidden:YES];
        [self.sellall setHidden:YES];
        
        
        
        if (baseProductInfo.curRepertory==0  || ![baseProductInfo.merchStatus isEqualToString:@"1"])
        {
            [self.addbuycarButton setHidden:YES];
            [self.buyButton setHidden:YES];
            [self.diyBtn setHidden:YES];
            [self.sellall setHidden:NO];
            [self.sellall setTitle:@"已售罄" forState:UIControlStateNormal];
            [self.sellall setTitle:@"已售罄" forState:UIControlStateSelected];
            
            
            if ( [baseProductInfo.merchSaleType isEqualToString:@"2"])
            {//不在销售期
                [self.addbuycarButton setHidden:YES];
                [self.buyButton setHidden:YES];
                [self.diyBtn setHidden:YES];
                [self.sellall setHidden:NO];
                [self.sellall setTitle:@"商品不在销售期" forState:UIControlStateNormal];
                [self.sellall setTitle:@"商品不在销售期" forState:UIControlStateSelected];
                
            }
            
            return;
            
            
        }
        
        if ( [baseProductInfo.merchSaleType isEqualToString:@"2"])
        {//不在销售期
            [self.addbuycarButton setHidden:YES];
            [self.buyButton setHidden:YES];
            [self.diyBtn setHidden:YES];
            [self.sellall setHidden:NO];
            [self.sellall setTitle:@"商品不在销售期" forState:UIControlStateNormal];
            [self.sellall setTitle:@"商品不在销售期" forState:UIControlStateSelected];
            
        }
        
        
    }else
    {
        if (baseProductInfo.curRepertory==0  || ![baseProductInfo.merchStatus isEqualToString:@"1"])
        {
            [self.addbuycarButton setHidden:YES];
            [self.buyButton setHidden:YES];
            [self.diyBtn setHidden:YES];
            [self.sellall setHidden:NO];
            [self.sellall setTitle:@"已售罄" forState:UIControlStateNormal];
            [self.sellall setTitle:@"已售罄" forState:UIControlStateSelected];
            
            
            if ( [baseProductInfo.merchSaleType isEqualToString:@"2"])
            {//不在销售期
                [self.addbuycarButton setHidden:YES];
                [self.buyButton setHidden:YES];
                [self.diyBtn setHidden:YES];
                [self.sellall setHidden:NO];
                [self.sellall setTitle:@"商品不在销售期" forState:UIControlStateNormal];
                [self.sellall setTitle:@"商品不在销售期" forState:UIControlStateSelected];
                
            }
            
            return;
            
            
        }
        
        if ( [baseProductInfo.merchSaleType isEqualToString:@"2"])
        {//不在销售期
            [self.addbuycarButton setHidden:YES];
            [self.buyButton setHidden:YES];
            [self.diyBtn setHidden:YES];
            [self.sellall setHidden:NO];
            [self.sellall setTitle:@"商品不在销售期" forState:UIControlStateNormal];
            [self.sellall setTitle:@"商品不在销售期" forState:UIControlStateSelected];
            
        }
        
        else
        {
            
            [self.addbuycarButton setHidden:NO];
            [self.buyButton setHidden:NO];
            [self.diyBtn setHidden:YES];
            [self.sellall setHidden:YES];
        }}
    
    
}



// GuestYouLikeChirldViewCallBackDelegate
-(void) chirldViewCallBack:(NSString*)mtype  data:(NSMutableArray*)mdata
{
    
}

-(void)addShoppingDelegateCallBackError:(MsgReturn*)msgReturn
{


}

-(void)addShoppingDelegateCallBack:(MsgReturn*)msgReturn
{
    
    if ([msgReturn.errorCode isEqualToString:@"0023"] && isLeave) {
        
        [self gotoShoppingView];
        
        
    } else if ([msgReturn.errorCode isEqualToString:@"0023"] && !isLeave) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [PromptError changeShowErrorMsg:msgReturn title:nil  viewController:self block:^(BOOL goOrnotgo){
                
                if (goOrnotgo) {
                    
                    [self gotoShoppingView];
                }else
                {
                    
                }
            } okBtnName:@"去结算" cancelBtnName:@"继续购物"];
            
            
            
            NSMutableDictionary *map= msgReturn.map;
            int *count=[[map objectForKey:@"count"] intValue];
            
            
            
            SqlApp *sqlApp=[[SqlApp alloc ]init ];
            int queryis=[[sqlApp selectPM_SIGNSERVICE:@"SC_QUERY_HOMEPAGE" ] intValue];
            if(queryis==0  )
            {//显示数量
                
                //购物车数量
                if (count==nil ||  count==0) {
                    carnumTextView.text=@"";
                    [self.shoppingcarpic setImage:[UIImage imageNamed:@"shoppingcarwhiteempty.png"]];
                    
                    [self.shoppingcarpic setFrame:CGRectMake(self.shoppingcarpic.frame.origin.x
                                                             , self.shoppingcarpic.frame.origin.y
                                                             , shoppingcarpicWEmpty, shoppingcarpicHEmpty)];
                 
                    
                    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
                    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                    UITabBarItem *tabBarItem = [appDelegate.tabbar.tabBar.items objectAtIndex:1];
                    
                    [tabBarItem setBadgeValue:nil];
                    
                }else
                {
                    carnumTextView.text=[NSString stringWithFormat:@"%d",count];
                    [self.shoppingcarpic setImage:[UIImage imageNamed:@"shoppingcarwhite.png"]];
                    [self.shoppingcarpic setFrame:CGRectMake(self.shoppingcarpic.frame.origin.x
                                                             , self.shoppingcarpic.frame.origin.y
                                                             , shoppingcarpicW, shoppingcarpicH)];
                    
                    
                    //角标
                    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:count];
                    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                    UITabBarItem *tabBarItem = [appDelegate.tabbar.tabBar.items objectAtIndex:1];
                    
                    [tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", count]];
                    
                }

            }else
            {
            
                
                carnumTextView.text=@"";
                [self.shoppingcarpic setImage:[UIImage imageNamed:@"shoppingcarwhiteempty.png"]];
                
                [self.shoppingcarpic setFrame:CGRectMake(self.shoppingcarpic.frame.origin.x
                                                         , self.shoppingcarpic.frame.origin.y
                                                         , shoppingcarpicWEmpty, shoppingcarpicHEmpty)];
                
                
                [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                UITabBarItem *tabBarItem = [appDelegate.tabbar.tabBar.items objectAtIndex:1];
                
                [tabBarItem setBadgeValue:nil];
            }
            
            
            
        }
                       );
        
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [PromptError changeShowErrorMsg:msgReturn title:nil viewController:self block:^(BOOL ok){}];
        });
    }
    
}







//广告star

// 实现手动滚动效果：
-(void)initPicScrollView:(NSMutableArray*)imageArr{
    imagearr=imageArr;
    for (UIView *view in self.picScrollView.subviews)
    {
        [view removeFromSuperview];
    }
    
     kDeviceWidth1=[UIScreen mainScreen].bounds.size.width;
     kDeviceHeight1=[UIScreen mainScreen].bounds.size.height;
    
    self.picScrollView.contentSize=CGSizeMake(kDeviceWidth1*imageArr.count,self.picScrollView.frame.size.height);
    
    self.picScrollView.delegate=self;
    
    self.picScrollView.scrollEnabled=YES;
    
    for(int i=0;i<imageArr.count;i++){
        
        UIImageView * firstImg=[[UIImageView alloc]init];
        
        NSString *url=[imageArr[i] isKindOfClass:[NSNull class]]?@"":imageArr[i];
        [firstImg   setImageWithURL: [NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"productpic.png"] progressbar:YES];
        
        
        
        firstImg.frame=CGRectMake(kDeviceWidth1*i, 0, kDeviceWidth1, self.picScrollView.frame.size.height);
        
        [ self.picScrollView addSubview:firstImg];
        
    }
    
    if ([imageArr count]>1) {
        [self.picPagecontrol setHidden:NO];
    }else
    {
        [self.picPagecontrol setHidden:YES];
    }
    
    [self initPageControl];
    
 
    
    

   
    
    self.picScrollView.showsHorizontalScrollIndicator=NO;
    
    self.picPagecontrol.pageIndicatorTintColor = [UIColor blackColor];//设置点的默认颜色，非选中的点
    
    self.picPagecontrol.currentPageIndicatorTintColor = [UIColor redColor];//设置点的选中颜色
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    //    NSMutableString *urlt =[[NSMutableString alloc] initWithString:REFRESH_IP];
    //    [urlt appendString:@"/ios.html"];
    //    NSString* DOWNLOAD =[urlt copy];
    
    NSString* DOWNLOAD =@"https://dn-philately.qbox.me/ios.html";
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
                    break;
                default:
                    NSLog(@"不更新");
                    break;
            }
        }
            break;
    }
    
}




// 2 加UIPageControl，做翻页效果，即产生白点
//方法实现如下：

-(void)initPageControl{

    // self.pagecontrol=[[UIPageControlalloc]initWithFrame:CGRectMake(kDeviceWidth/2-10, kDeviceHeight/3*2-20, 20, 20)];

    self.picPagecontrol.numberOfPages=imagearr.count;

    self.picPagecontrol.currentPage=0;

    //[self.picPagecontrol addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];

}

////可以不要下面这个方法，此方法是手动点击白点的时候跳转相应页面视图
//
////点击page控件时，即白点
-(void)changePage:(id)sender{
    int page=self.picPagecontrol.currentPage;
    [self.picScrollView setContentOffset:CGPointMake(kDeviceWidth1*page, 0) animated:YES];
}

////并且记得在手动滚动的时候更改pageControl的页码

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    //int kDeviceWidth=[UIScreen mainScreen].bounds.size.width;
    //int kDeviceHeight=[UIScreen mainScreen].bounds.size.height;

    int page=scrollView.contentOffset.x/kDeviceWidth1;

    self.picPagecontrol.currentPage=page;

}


bool Tend1=YES;

////3 定时任务方法调用：（注意计算好最后一页循环滚动）

-(void)handleSchedule1{

    ++self.picPagecontrol.currentPage;

    if(Tend1){

        [self.picScrollView setContentOffset:CGPointMake(0, 0) animated:YES];

        self.picPagecontrol.currentPage=0;

    }else{

        [self.picScrollView setContentOffset:CGPointMake(self.picPagecontrol.currentPage*kDeviceWidth1, 0) animated:YES];

    }

    if (self.picPagecontrol.currentPage==self.picPagecontrol.numberOfPages-1) {

        Tend1=YES;

    }else{

        Tend1=NO;

    }
}


//广告End



-(void)viewWillAppear:(BOOL)animated
{
    
  
    
    //table
    
    //    CstmMsg *cst=[CstmMsg sharedInstance];
    //
    //    if (cst.cstmNo!=nil) {
    //        [self request0032];
    //    }
    
    touchy=0;
    movelength=0;
    keyboardHeight=0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    
    
    
}




- (void)keyboardWillShow:(NSNotification *)notification {
    
    
    
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
    
    
    
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    //
    //    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    
    
    touchy=500;
    
    keyboardHeight=keyboardTop;
    
    if(touchy>keyboardHeight)
    {
        movelength=touchy-keyboardHeight;
        [self MoveView:(-movelength)];
    }else
    {
        movelength=0;
        [self MoveView:(-movelength)];
    }
    
    
    [UIView commitAnimations];
    
    
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary* userInfo = [notification userInfo];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the disappearance of the keyboard.
     */
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    
    
    [self MoveView:(movelength)];
    
    
    [UIView commitAnimations];
}



-(void)oneNumEditTextEditTextDidEnd:(UITextField *)textField{
    [self.view becomeFirstResponder];
    
    int nownum=[textField.text intValue];
    
    int i=textField.tag;
    
    
    
    
    
    RespondParam0026 *product =  typeProducts[i];
    
    
    int caroneNum=product.checkNum;
    
    
    
    if(nownum==caroneNum)
    {
        return;
    }
    
    if(nownum<1)
    {
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        msgReturn.errorCode=@"-100";//不能为空
        msgReturn.errorDesc=@"购买数量不能小于1";
        msgReturn.errorType=@"01";
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        textField.text=[NSString stringWithFormat:@"%d",caroneNum] ;
        return;
    }
    
    if (nownum>product.limitNum) {
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        msgReturn.errorCode=@"-100";//不能为空
        msgReturn.errorDesc=@"超过限购套数";
        msgReturn.errorType=@"01";
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        textField.text=[NSString stringWithFormat:@"%d",caroneNum] ;
        return;
        
        
    }
    
    
    
    
    product.checkNum=nownum;
    
    
}

-(void)oneNumEditTextEditTextDidBegin:(UITextField *)textField
{
    
}



#pragma mark- 点击textField,根据键盘上移视图
-(void)MoveView:(int)h{
    // if (isUp) {
    
    if (h<0) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationBeginsFromCurrentState: YES];
        self.scrollView.frame = CGRectMake(self.scrollView.frame.origin.x, self.headView.frame.size.height + h, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        [UIView commitAnimations];
    }else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationBeginsFromCurrentState: YES];
        
        self.scrollView.frame = CGRectMake(self.scrollView.frame.origin.x, self.headView.frame.size.height , self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        [UIView commitAnimations];
    }
    
    
}

//键盘消失
-(void)viewTapHandle:(UITapGestureRecognizer *)sender

{
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}


- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.height;
}

@end















