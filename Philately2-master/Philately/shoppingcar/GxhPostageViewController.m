//
//  GxhPostageViewController.m
//  Philately
//
//  Created by Mirror on 15/7/22.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//
#import <CommonCrypto/CommonDigest.h>
#import <AVFoundation/AVFoundation.h>

#import "BasicClass.h"

#import "GxhPostageViewController.h"
#import "GxhPostageXieYiViewController.h"
#import "LoginViewController.h"
#import "GxhPostageAttrViewController.h"
#import "GxhPostageFuTuViewController.h"
#import "ShoppingCarViewController.h"
#import "OrderFormDetailViewController.h"

#import "ServiceEntity.h"
#import "SqlQueryService.h"
#import "SqlQuerySignService.h"
#import "SignServiceEntity.h"

#import "FirstPageViewController.h"
#import "MenberMainViewController.h"
#import "AppDelegate.h"

#import "UIImageView+WebCache.h"

#import "AsynImageView.h"

#import "GxhPostageCopyImgViewController.h"

#define ORIGINAL_MAX_WIDTH 640.0f


@implementation PicClass
@synthesize contentid;
@synthesize img;
@synthesize original;
@synthesize pheight;
@synthesize pwidth;
@synthesize px;
@synthesize py;
@synthesize pimgView;
@end

@implementation ContentClass
@synthesize contentid;
@synthesize imageid;
@synthesize img;
@synthesize original;
@synthesize contentnotice;
@synthesize type;
@synthesize contentheight;
@synthesize contentwidth;
@end

@interface GxhPostageViewController ()

@property (nonatomic, strong) ALAssetsLibrary *specialLibrary;

@end

@implementation GxhPostageViewController
@synthesize orderNo;
@synthesize merchNum;
@synthesize merchId;
@synthesize merchPrice;
@synthesize isModify;
@synthesize fromflag;

int width;//附图填充区 高度
int rowindex=0; //附图排版，第几行，每行3列排版
int columnindex =0; //附图排版，第几列

CGRect rect;//
CGFloat imgtwidth;//背景图片宽度
CGFloat imgheight;//背景图片高度
int picnum =0;//上传图片的位置
int modpicnum =0;//修改的，需要上传图片的数量

static CGFloat scalevale=0;//图片压缩比例
static NSString* picflag=@"1";//1表示拍照，2表示选择照片

static NSString* tmpiset ;
static NSString* tmpxzno;
static NSString* tmpsxno;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
//    NSString* strwidth =   ([UIScreen mainScreen].bounds.size.height>=568)?[NSString stringWithFormat:@"%.0f",([UIScreen mainScreen].bounds.size.width -30)/6]:[NSString stringWithFormat:@"%.0f",([UIScreen mainScreen].bounds.size.width -30)/3];
    NSString* strwidth = [NSString stringWithFormat:@"%.0f",([UIScreen mainScreen].bounds.size.width -30)/3];
    NSLog(@"mainScreen height:[%.2f]",[UIScreen mainScreen].bounds.size.height);
    NSLog(@"mainScreen width:[%.2f]",[UIScreen mainScreen].bounds.size.width);
    width = [strwidth intValue];
    
    contentList=[NSMutableArray array];
    picList=[NSMutableArray array];
    oldcontentList =[NSMutableArray array];

    
    UITapGestureRecognizer* tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doShouQuanImg)];
    [self.certnoView addGestureRecognizer:tap1];
    
    self.xieYiImg.userInteractionEnabled=YES;
    UITapGestureRecognizer* tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doReadXieYiImg)];
    [self.readView addGestureRecognizer:tap2];
    
    SaleRuleInfo =[[CSaleRuleInfo alloc]init];
    selMerchID =[NSMutableArray array];
    
    [self.basicView setHidden:YES];
    [self queryOrder0049];
    
 
    SqlQuerySignService* signservice =[[SqlQuerySignService alloc]init];
    scalevale = [((SignServiceEntity*)[signservice querySignServiceWithKey:@"GXH_PIC_COMPRESSION"]).serviceValue floatValue];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



-(void)initData
{

    
    imgtwidth =[Ety0049.templateWidth floatValue];
    imgheight =[Ety0049.templateHeight floatValue];
    
    self.lbmoBan.text =[NSString stringWithFormat:@"模板:%@",Ety0049.templateName];
    
    NSString* tmpcstmname =[CstmMsg sharedInstance].cstmName.length>1?[NSString stringWithFormat:@"*%@",[[CstmMsg sharedInstance].cstmName  substringFromIndex:1]]:[CstmMsg sharedInstance].cstmName;
    NSString* tmpcertno = [CstmMsg sharedInstance].certNo.length>4?[NSString stringWithFormat:@"%@******%@",[[CstmMsg sharedInstance].certNo  substringToIndex:4],[[CstmMsg sharedInstance].certNo  substringFromIndex:([CstmMsg sharedInstance].certNo.length-4)]]:[CstmMsg sharedInstance].certNo;
    
    self.lbauthName.text=tmpcstmname;
    self.lbauthCertNo.text =tmpcertno;
    
    isread=YES;
    isauth=YES;
    readImg =@[[UIImage imageNamed:@"check2.png"],[UIImage imageNamed:@"uncheck2.png"]];
    authImg =@[[UIImage imageNamed:@"check1.png"],[UIImage imageNamed:@"uncheck1.png"]];
    if (isread) {
        self.xieYiImg.image =readImg[0];
    }
    else
    {
        self.xieYiImg.image =readImg[1];
    }
    
    if (isauth) {
        self.shouQuanImg.image =authImg[0];
    }
    else
    {
        self.shouQuanImg.image =authImg[1];
    }
    
    //设置背景图片
    

    if (orderNo ==nil || [orderNo isEqual:@""]) {
        merchPrice = Ety0049.mainMerchPrice;
    }
    
    /*
    UIImage*img1;
    if (Ety0052.recordNum>0) {
        flag =@"1";//修改
        selMerchID = Ety0052.affMerchID;
        if ([Ety0052.isEt isEqualToString:@"0"]) {
            img1 =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:Ety0052.interPicURL]]];
            if (img1==nil) {
                img1 =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:Ety0052.etPicURL]]];
            }
        }
        else if([Ety0052.isEt isEqualToString:@"1"]) {
            img1 =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:Ety0049.interPicURL]]];
            if (img1==nil) {
                img1 =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:Ety0049.etPicURL]]];
            }
        }
    }
    else
    {
        flag =@"0";//定制
        selMerchID = SaleRuleInfo.strDefMerchID;

        img1 =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:Ety0049.interPicURL]]];
        if (img1==nil) {
            img1 =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:Ety0049.etPicURL]]];
           
        }
        
    }
    
    
    bjimg=img1;
    self.imgView.image =bjimg;
    
    */
    
    AsynImageView* asynImgView = [[AsynImageView alloc] init];
    
    
    if (Ety0052.selAffMerchNum>0) {
        flag =@"1";//修改
        selMerchID = [Ety0052.affMerchID copy];
        if ([Ety0052.isEt isEqualToString:@"0"]) {
            asynImgView.imageURL1= Ety0052.interPicURL;
            asynImgView.imageURL2= Ety0052.etPicURL;
            
        }
        else if([Ety0052.isEt isEqualToString:@"1"]) {
            asynImgView.imageURL1= Ety0049.interPicURL;
            asynImgView.imageURL2= Ety0049.etPicURL;
            
        }
    }
    else
    {
        flag =@"0";//定制
        selMerchID = SaleRuleInfo.strDefMerchID;
        
        asynImgView.imageURL1= Ety0049.interPicURL;
        asynImgView.imageURL2= Ety0049.etPicURL;        
    }
    
    asynImgView.setImg=^(UIImage*img)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (img==nil) {
                bjimg = [UIImage imageNamed:@"ic_gxh_fail_modelbg.9.png"];
                [self setbtnEnabledNO];
            }
            else
            {
                bjimg =img;
                [self setbtnEnabledYES];
            }
            self.imgView.image =bjimg;
        });
    };
    [asynImgView setImageURL:asynImgView.imageURL1 andImageURL2:asynImgView.imageURL2];
    
    bjimg = [UIImage imageNamed:@"defaultimg.png"];
    self.imgView.image =bjimg;
    
    [self initBianShiData];
    [self initImg];
    [self reloadImg];
    [self initFrame];
    [self gomakepic];
    [self.basicView setHidden:NO];
    [SVProgressHUD dismiss];
}
-(void)initFrame
{
    self.basicView.frame =CGRectMake(0, 0, self.view.frame.size.width, 130);
    
    NSLog(@"imgtwidth:%.2f,imgheight:%.2f",imgtwidth,imgheight);
    
   
    UIImageView *imgview1 =[[UIImageView alloc] init];
    CGFloat imgview1width =self.view.bounds.size.width-16;
    CGFloat imgview1height =200;
    if (imgtwidth!=0) {
        imgview1height = imgview1width * imgheight/imgtwidth;
    }
    
    imgview1.frame =CGRectMake(8, self.basicView.frame.size.height+3, imgview1width, imgview1height);
    imgview1.image =bjimg;
    
    [self.bigScrollView addSubview:imgview1];
    self.imgView =imgview1;
    
    self.dingZhiView.frame =CGRectMake(0, self.basicView.frame.size.height+self.imgView.frame.size.height+10, self.view.frame.size.width, 50+ self.imglistlView.frame.size.height);
    [self.bigScrollView addSubview:self.dingZhiView];
    
    self.AddView.frame =CGRectMake(0, self.basicView.frame.size.height+self.imgView.frame.size.height+self.dingZhiView.frame.size.height+15, self.view.frame.size.width, 550);
    [self.bigScrollView addSubview:self.AddView];
        
    [self initaa];
}
-(void)initaa
{
    self.imglistlView.frame =CGRectMake(0, 50, self.view.bounds.size.width, (rowindex+1)*(width+35));
    
    self.bigScrollView.frame=CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60);
    self.bigScrollView.contentSize =CGSizeMake(self.view.frame.size.width, self.AddView.frame.origin.y+self.AddView.frame.size.height);
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self initaa];
}
#pragma mark - 点击授权，阅读协议
-(void)doShouQuanImg
{
    isauth=!isauth;
    self.shouQuanImg.image= isauth?authImg[0]:authImg[1];
    if (isread&&isauth) {
        [self setbtnEnabledYES];
    }
    else
    {
        [self setbtnEnabledNO];
    }
}

-(void)doReadXieYiImg
{
    isread=!isread;
    self.xieYiImg.image =isread?readImg[0]:readImg[1];
    if (isread&&isauth) {
        [self setbtnEnabledYES];
    }
    else
    {
        [self setbtnEnabledNO];
    }

}
#pragma mark - 初始化 边饰 数据
-(void)initBianShiData
{
    if ([flag isEqualToString:@"0"]) {//操作标志，0定制，1修改
        
        [self.btnAddShopCart setHidden:NO];
        [self.btnModify setHidden:YES];
        [self.rightImg setHidden:NO];
        UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoDingZhi)];
        [self.bianShiView addGestureRecognizer:tap];

        isEt=@"1";//边饰
        xzNo=@"0";//星座
        sxNo=@"0";//生肖
        
        [self setBianshiDatawithetNo:isEt withszNo:xzNo withsxNo:sxNo];
        
    }
    else
    {
        if ([isModify isEqualToString:@"1"]) {//1,不允许修改，其他：允许修改
            [self.btnAddShopCart setHidden:YES];
            [self.btnModify setHidden:YES];
        }
        else
        {
            [self.btnAddShopCart setHidden:YES];
            [self.btnModify setHidden:NO];
        }

        [self.rightImg setHidden:YES];
        

        isEt=Ety0052.isEt;//边饰
        xzNo=Ety0052.etXzNo;//星座
        sxNo=Ety0052.etSxNo;//生肖
        
        [self setBianshiDatawithetNo:isEt withszNo:xzNo withsxNo:sxNo];
    }
    
    float price=0.00;
    if (orderNo ==nil || [orderNo isEqual:@""])
    {
        for (int i =0; i<selMerchID.count; i++) {
            for (int j =0; j<Ety0049.affMerchID.count; j++) {
                if ([selMerchID[i] isEqual:Ety0049.affMerchID[j]]) {
                    price=price+[Ety0049.affMerchPrice[j] floatValue];
                    NSLog(@"affMerchPrice[%d]:%@",j,Ety0049.affMerchPrice[j]);
                }
            }
        }
        NSLog(@"merchPrice:%.2f",merchPrice);
        price =(merchPrice+ price)*[merchNum intValue] ;
        NSLog(@"price:%.2f",price);
    }
    else
    {
        price =merchPrice *[merchNum intValue] ;
        NSLog(@"price:%.2f",price);

    }
    self.lbtotalMoney.text=[NSString stringWithFormat:@"￥%.2f",price];
}

-(void)setBianshiDatawithetNo:(NSString*)etno withszNo:(NSString*)xzno withsxNo:(NSString*)sxno
{

    isEt=etno;//边饰
    xzNo=xzno;//星座
    sxNo=sxno;//生肖
    
    ServiceEntity* servEty=[[ServiceEntity alloc]init];
    SqlQueryService* service =[[SqlQueryService alloc]init];
    
    NSMutableString* mutMerchName =[[NSMutableString alloc]init];
    for (int i =0; i<selMerchID.count; i++) {
        for (int j =0; j<Ety0049.affMerchID.count; j++) {
            if ([selMerchID[i] isEqual:Ety0049.affMerchID[j]] ) {
                [mutMerchName appendString:[NSString stringWithFormat:@"%@,",Ety0049.affMerchName[j]]];
            }
        }
    }
    if (mutMerchName.length>0) {
        mutMerchName = [mutMerchName substringWithRange:NSMakeRange(0, [mutMerchName length] - 1)];
    }
    
    
    self.lbproductType.text=mutMerchName;

    servEty =[service queryServiceWithKey:@"ISET" withcode:etno];
    etname = servEty.serviceName;
    
    servEty =[service queryServiceWithKey:@"XZINFO" withcode:xzno];
    xzname = (servEty.serviceName ==nil)?@"无":servEty.serviceName;
    
    servEty =[service queryServiceWithKey:@"SXINFO" withcode:sxno];
    sxname =(servEty.serviceName ==nil)?@"无":servEty.serviceName;
    
    self.lbbianShi.text =[NSString stringWithFormat:@"%@ 【星座: %@ 生肖: %@】",etname,xzname,sxname];
    [self.lbbianShi setHidden:NO];
}


#pragma mark -设置边饰
-(void)gotoDingZhi
{
    GxhPostageAttrViewController* attrview =[[GxhPostageAttrViewController alloc]init];
    attrview.Ety0049=Ety0049;
    attrview.RuleInfo=SaleRuleInfo;
    attrview.gxhSaleRule =Ety0049.gxhSaleRule;
    attrview.selectedMercherID=selMerchID;
    attrview.isEt =isEt;
    attrview.xzNo =xzNo;
    attrview.sxNo=sxNo;
    attrview.modifuBianshi=^(NSMutableArray*selectecdMerchid,NSString*iset,NSString*xzno,NSString*sxno)
    {
        selMerchID = selectecdMerchid ;
        
        float price=0.00;
        if (orderNo ==nil || [orderNo isEqual:@""])
        {
            for (int i =0; i<selMerchID.count; i++) {
                for (int j =0; j<Ety0049.affMerchID.count; j++) {
                    if ([selMerchID[i] isEqual:Ety0049.affMerchID[j]]) {
                        price=price+[Ety0049.affMerchPrice[j] floatValue];
                        NSLog(@"affMerchPrice[%d]:%@",j,Ety0049.affMerchPrice[j]);
                    }
                }
            }
            NSLog(@"merchPrice:%.2f",merchPrice);
            price =(merchPrice+ price)*[merchNum intValue] ;
            NSLog(@"price:%.2f",price);
        }
        else
        {
            price =merchPrice *[merchNum intValue] ;
            NSLog(@"price:%.2f",price);
            
        }
        self.lbtotalMoney.text=[NSString stringWithFormat:@"￥%.2f",price];
        
        /***************设置产品形式 开始*****************/
        NSMutableString* mutMerchName =[[NSMutableString alloc]init];
        for (int i =0; i<selMerchID.count; i++) {
            for (int j =0; j<Ety0049.affMerchID.count; j++) {
                if ([selMerchID[i] isEqual:Ety0049.affMerchID[j]] ) {
                    [mutMerchName appendString:[NSString stringWithFormat:@"%@,",Ety0049.affMerchName[j]]];
                }
            }
        }
        if (mutMerchName.length>0) {
            mutMerchName = [mutMerchName substringWithRange:NSMakeRange(0, [mutMerchName length] - 1)];
        }
        self.lbproductType.text=mutMerchName;
        /***************设置产品形式 结束*****************/
        

        if ([iset isEqual:@"1"]) {//无边饰
            isEt=iset;//边饰
            xzNo=xzno;//星座
            sxNo=sxno;//生肖
            [self setBianshiDatawithetNo:isEt withszNo:xzNo withsxNo:sxNo];
        }
        else
        {
            tmpiset =iset;
            tmpxzno =xzno;
            tmpsxno =sxno;
        }
        
        
        if ([xzno intValue]>0&&[sxno intValue]>0) {
            [self queryOrder0063];
        }
        
        if ([iset isEqual:@"1"]) {//无边饰
            AsynImageView* asynImgView =[[AsynImageView alloc]init];
            asynImgView.imageURL1 = Ety0049.interPicURL;
            asynImgView.imageURL2 = Ety0049.etPicURL;
            asynImgView.setImg=^(UIImage*img)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (img==nil) {
                        bjimg = [UIImage imageNamed:@"ic_gxh_fail_modelbg.9.png"];
                        [self setbtnEnabledNO];
                    }
                    else
                    {
                        bjimg =img;
                        [self setbtnEnabledYES];
                    }
                    self.imgView.image =bjimg;
                });
            };
            [asynImgView setImageURL:asynImgView.imageURL1 andImageURL2:asynImgView.imageURL2];
        }
    };
    [self.navigationController pushViewController:attrview animated:YES];
}

#pragma mark -按钮点击事件
- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)DoRead:(id)sender {
    GxhPostageXieYiViewController * xieYiView =[[GxhPostageXieYiViewController alloc]init];
    [self presentViewController:xieYiView animated:YES completion:^{}];
}
#pragma mark - 加入购物车事件
- (IBAction)DoAddShopCart:(id)sender {
    if([self isExistPic])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showWithStatus:@"努力加载中..." maskType:SVProgressHUDMaskTypeClear ];
        });
    
        
        [self upImgFile:0];
        [self setbtnEnabledNO];
    }
}
-(void) gotoShoppingView
{
    
    
    if ([fromflag isEqual:@"1"]||[fromflag isEqual:@"2"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if (![controller isKindOfClass:[FirstPageViewController class]]
                && ![controller isKindOfClass:[ShoppingCarViewController class]]
                && ![controller isKindOfClass:[MenberMainViewController class]]
                ) {
                
                [controller removeFromParentViewController];
            }
        }
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.tabbar setSelectedIndex:1];
    }
    

        

}
#pragma mark - 修改事件
- (IBAction)DoModify:(id)sender {
    if([self isExistPic])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showWithStatus:@"努力加载中..." maskType:SVProgressHUDMaskTypeClear ];
        });
        [self upImgFile:picnum];
        
        [self setbtnEnabledNO];
    }
//    [self modifyOrder0051];
}
-(BOOL)isExistPic
{
    if ([flag isEqual:@"0"]) {
        for (ContentClass* ety in contentList) {//定制
            if (ety.img==nil)
            {
                UIAlertView* alter =[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请上传图片" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alter show];
                return false;
            }
        }
    }
    else if ([flag isEqual:@"1"])
    {//修改
        modpicnum =0;
        recordnum = 0;
        BOOL picmodify =false;//是否有图片修改
        for (int i =0; i<contentList.count; i++)
        {//获取修改过，并且需要上传的图片数量 modpicnum
            ContentClass* ety = contentList[i];
            ContentClass* ety1 = oldcontentList[i];
            if (ety.img != ety1.img)
            {
                modpicnum++;
            }
        }
        for (int i =0; i<contentList.count; i++)
        {//获取第一张需要上传的图片的位置
            ContentClass* ety = contentList[i];
            ContentClass* ety1 = oldcontentList[i];
            if (ety.img != ety1.img)
            {
                picnum = i ;
                picmodify =true;
                break;
            }
        }
        if (!picmodify)
        {
            [self gotoShoppingView];
            [self cleararr];
            return false;
        }
    }
    return true;
}
#pragma mark - 个性化定制模板查询 JY0049
-(void)queryOrder0049
{
    NSString * n0049 =@"JY0049";
    CstmMsg *_cstmmsg = [CstmMsg sharedInstance];
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];

    [para setValue:merchId forKey:@"merchID"];
    
    SysBaseInfo *_sysBaseInfo = [SysBaseInfo sharedInstance];
    StampTranCall * stampTranCall = [StampTranCall sharedInstance];
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmmsg formName:n0049 business:para delegate:self viewController:self];
    
}
#pragma mark - 个性化定制信息查询 JY0052
-(void)queryOrder0052
{
    NSString * n0052 =@"JY0052";
    CstmMsg *_cstmmsg = [CstmMsg sharedInstance];
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    
    [para setValue:_cstmmsg.cstmNo forKey:@"cstmNo"];
    [para setValue:merchId forKey:@"merchID"];
    [para setValue:orderNo forKey:@"prepNumber"];
    
    SysBaseInfo *_sysBaseInfo = [SysBaseInfo sharedInstance];
    StampTranCall * stampTranCall = [StampTranCall sharedInstance];
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmmsg formName:n0052 business:para delegate:self viewController:self];
    
}
#pragma mark - 个性化边饰信息查询 JY0063
-(void)queryOrder0063
{
    NSString * n0063 =@"JY0063";
    CstmMsg *_cstmmsg = [CstmMsg sharedInstance];
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    
    [para setValue:Ety0049.templateId forKey:@"templateId"];
    [para setValue:tmpsxno forKey:@"sxNo"];
    [para setValue:tmpxzno forKey:@"xzNo"];
    [para setValue:@"" forKey:@"etId"];

    
    SysBaseInfo *_sysBaseInfo = [SysBaseInfo sharedInstance];
    StampTranCall * stampTranCall = [StampTranCall sharedInstance];
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmmsg formName:n0063 business:para delegate:self viewController:self];
    
}
#pragma mark - 加入购物车方法
-(void)addShopingCart
{
    CstmMsg *_cstmmsg = [CstmMsg sharedInstance];
    SendParam0050* send0050 =[[SendParam0050 alloc]init];
    
    send0050.cstmNo =_cstmmsg.cstmNo;
    send0050.cstmName =_cstmmsg.cstmName;
    send0050.merchID =merchId;
    send0050.templateId=Ety0049.templateId;
    send0050.picNum =[NSString stringWithFormat:@"%lu",(unsigned long)contentList.count];
    
    NSMutableArray* contentIdList =[NSMutableArray array];
    NSMutableArray* originalList =[NSMutableArray array];
    NSMutableArray* typeList =[NSMutableArray array];
    for (ContentClass* ety in contentList) {
        [contentIdList addObject:ety.contentid];
        [originalList addObject:ety.original];
        [typeList addObject:ety.type];
    }
    send0050.contentId =contentIdList;
    send0050.original =originalList;
    send0050.type =typeList;
    
    NSMutableArray* normsTypeList =[NSMutableArray array];
    NSMutableArray* merchNumList =[NSMutableArray array];
    [normsTypeList addObject:@"0"];
    [merchNumList addObject:merchNum];
    send0050.recordNum=@"1";
    send0050.normsType=normsTypeList;
    send0050.merchNum=merchNumList;
    
    send0050.isEt=isEt;
    send0050.xzNo=xzNo;
    send0050.sxNo=sxNo;
    send0050.gxhMerchNum=merchNum;
    
    
    
    NSMutableArray* gxhMerchIDList =[NSMutableArray array];
    NSMutableArray* gxhBiaozhiList =[NSMutableArray array];
    
    if (selMerchID.count>0)
    {
        gxhMerchIDList =selMerchID;
        
        send0050.addMerchNum= [NSString stringWithFormat:@"%lu",selMerchID.count+1];
        for (int i =0; i<selMerchID.count; i++)
        {
            for (int j =0; j<Ety0049.affMerchID.count; j++) {
                if ([selMerchID[i] isEqual:Ety0049.affMerchID[j]]) {
                    [gxhBiaozhiList addObject:Ety0049.gxhBiaozhi[j]];
                }
            }
        }
        
        [gxhMerchIDList addObject:merchId];
        [gxhBiaozhiList addObject:@"0"];
    }
    else
    {
        send0050.addMerchNum=@"1";
        [gxhMerchIDList addObject:merchId];
        [gxhBiaozhiList addObject:@"0"];
    }
    
    
    
    
    send0050.gxhMerchID=gxhMerchIDList;
    send0050.gxhBiaozhi=gxhBiaozhiList;
    
    
    NSMutableArray* paralist =[NSMutableArray array];
    [paralist addObject:send0050];
    
    AddShopping *addShopping=[[AddShopping alloc ] init ];
    [addShopping shoppingUnionCheck:@"" businNo:@"71" typeProduct:paralist delegate:self];

    
}
#pragma mark - 个性化定制信息修改 JY0051
int recordnum =0; //修改的图片数量
-(void)modifyOrder0051
{
    NSString * n0051 =@"JY0051";
    CstmMsg *_cstmmsg = [CstmMsg sharedInstance];
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    
    [para setValue:_cstmmsg.cstmNo forKey:@"cstmNo"];
    [para setValue:merchId forKey:@"merchID"];
    [para setValue:Ety0049.templateId forKey:@"templateId"];
    
    NSMutableArray* imageIdList =[NSMutableArray array];
    NSMutableArray* contentIdList =[NSMutableArray array];
    NSMutableArray* originalList =[NSMutableArray array];
    NSMutableArray* typeList =[NSMutableArray array];
    
    
    for (int i =0; i<contentList.count; i++) {
        ContentClass* ety = contentList[i];
        ContentClass* ety1 = oldcontentList[i];
        if (ety.img != ety1.img)
        {
            [imageIdList addObject:ety.imageid];
            [contentIdList addObject:ety.contentid];
            [originalList addObject:ety.original];
            [typeList addObject:ety.type];
        }
    }
    
    [para setValue:[NSString stringWithFormat:@"%d",recordnum] forKey:@"recordNum"];
    [para setValue:imageIdList forKey:@"imageID"];
    [para setValue:contentIdList forKey:@"contentId"];
    [para setValue:originalList forKey:@"original"];
    [para setValue:typeList forKey:@"type"];
    
    
    SysBaseInfo *_sysBaseInfo = [SysBaseInfo sharedInstance];
    StampTranCall * stampTranCall = [StampTranCall sharedInstance];
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmmsg formName:n0051 business:para delegate:self viewController:self];
    
}
-(void) ReturnData:(MsgReturn*)msgReturn
{
    
    if ([msgReturn.formName isEqual:@"JY0049"]) {
        if(msgReturn.map==nil)
            return;
        
        NSLog(@"0049 %lu",(unsigned long)[msgReturn.map count]);
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];        
        
        Ety0049 =[[RespondParam0049 alloc]init];
        Ety0049.templateId=[returnDataBody objectForKey:@"templateId"];//模板Id
        Ety0049.templateName=[returnDataBody objectForKey:@"templateName"];//模板名称
        Ety0049.ypzt=[returnDataBody objectForKey:@"ypzt"];//邮票主图
        Ety0049.ztmz=[returnDataBody objectForKey:@"ztmz"];//邮票面值
        Ety0049.templateWidth=[returnDataBody objectForKey:@"templateWidth"];//模板宽度
        Ety0049.templateHeight=[returnDataBody objectForKey:@"templateHeight"];//模板高度
        Ety0049.templateSubType=[returnDataBody objectForKey:@"templateSubType"];//附图模式
        Ety0049.templateSubCount=[returnDataBody objectForKey:@"templateSubCount"];//附图数量
        Ety0049.interPicURL=[returnDataBody objectForKey:@"interPicURL"];//模板背景图内部URL
        Ety0049.etPicURL=[returnDataBody objectForKey:@"etPicURL"];//模板背景图外部URL
        Ety0049.zoomRate=[returnDataBody objectForKey:@"zoomRate"];//缩放比例
        
        Ety0049.contentIdNum=[[returnDataBody objectForKey:@"contentIdNum"] intValue];//附图类型数量
        if (Ety0049.contentIdNum>0) {
            Ety0049.contentId=[returnDataBody objectForKey:@"contentId"];//内容ID
            Ety0049.contentType=[returnDataBody objectForKey:@"contentType"];//内容类型
            Ety0049.contentWidth=[returnDataBody objectForKey:@"contentWidth"];//图片宽度
            Ety0049.contentHeight=[returnDataBody objectForKey:@"contentHeight"];//图片高度
            Ety0049.contentNotice=[returnDataBody objectForKey:@"contentNotice"];//图片提示
            Ety0049.contentDirName=[returnDataBody objectForKey:@"contentDirName"];//图片打包目录
        }
        
        
        Ety0049.itemNum=[[returnDataBody objectForKey:@"itemNum"] intValue];//内容位置明细数量
        if (Ety0049.itemNum>0) {
            Ety0049.itemId=[returnDataBody objectForKey:@"itemId"];//明细记录ID
            Ety0049.itemType=[returnDataBody objectForKey:@"itemType"];//明细类型
            Ety0049.itemX=[returnDataBody objectForKey:@"itemX"];//左上角X位置
            Ety0049.itemY=[returnDataBody objectForKey:@"itemY"];//左上角Y位置
            Ety0049.linkcontenteId=[returnDataBody objectForKey:@"linkcontenteId"];//内容ID
        }
        
        
        Ety0049.ztdm=[[returnDataBody objectForKey:@"ztdm"] intValue];//主题代码
        Ety0049.cpgg=[returnDataBody objectForKey:@"cpgg"];//成品规格
        Ety0049.is_et=[[returnDataBody objectForKey:@"is_et"] intValue];//是否有边饰
        Ety0049.xmbb=[returnDataBody objectForKey:@"xmbb"];//版别名称
        Ety0049.xmbbDm=[[returnDataBody objectForKey:@"xmbbDm"] intValue];//版别代码
        Ety0049.xmbt=[returnDataBody objectForKey:@"xmbt"];//版图名称
        Ety0049.xmbtDm=[[returnDataBody objectForKey:@"xmbtDm"] intValue];//版图代码
        Ety0049.zhuanti=[returnDataBody objectForKey:@"zhuanti"];//专题名称
        Ety0049.zhuantiDm=[[returnDataBody objectForKey:@"zhuantiDm"] intValue];//专题代码
        Ety0049.xmtc=[returnDataBody objectForKey:@"xmtc"];//项目题材
        Ety0049.xmtcDm=[[returnDataBody objectForKey:@"xmtcDm"] intValue];//题材代码
        Ety0049.ysgy=[returnDataBody objectForKey:@"ysgy"];//印刷工艺
        Ety0049.ysgyDm=[[returnDataBody objectForKey:@"ysgyDm"] intValue];//工艺代码
        Ety0049.mainMerchPrice=[[returnDataBody objectForKey:@"mainMerchPrice"] floatValue];//主商品价格
        Ety0049.gxhSaleRule=[returnDataBody objectForKey:@"gxhSaleRule"];//配套商品销售规则
        
        
        Ety0049.affMerchNum=[[returnDataBody objectForKey:@"affMerchNum"] intValue];//配套商品数量
        if (Ety0049.affMerchNum>0) {
            Ety0049.affMerchID=[returnDataBody objectForKey:@"affMerchID"];//配套商品编号
            Ety0049.affMerchPrice=[returnDataBody objectForKey:@"affMerchPrice"];//配套商品价格
            Ety0049.affMerchName=[returnDataBody objectForKey:@"affMerchName"];//配套商品名称
            Ety0049.gxhBiaozhi=[returnDataBody objectForKey:@"gxhBiaozhi"];//框/折类型
            Ety0049.affInterPicURL=[returnDataBody objectForKey:@"affInterPicURL"];//配套商品图片内部URL
            Ety0049.affMerchPic=[returnDataBody objectForKey:@"affMerchPic"];//配套商品图片外部URL
            
            [SaleRuleInfo getSaleRuleInfo:Ety0049.affMerchID withGxhBiaozhi:Ety0049.gxhBiaozhi withSaleRule:Ety0049.gxhSaleRule];
        }

        [self queryOrder0052];
    }
    if ([msgReturn.formName isEqual:@"JY0052"]) {
        
        if(msgReturn.map==nil)
            return;
        
        NSLog(@"0052 %lu",(unsigned long)[msgReturn.map count]);
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        
        Ety0052 =[[RespondParam0052 alloc]init];
        Ety0052.cstmNo=[returnDataBody objectForKey:@"cstmNo"];//
        Ety0052.merchID=[returnDataBody objectForKey:@"merchID"];//
        Ety0052.templateId=[returnDataBody objectForKey:@"templateId"];//
        
        Ety0052.recordNum=[[returnDataBody objectForKey:@"recordNum"]intValue];//
        if (Ety0052.recordNum>0) {
            Ety0052.imageID=[returnDataBody objectForKey:@"imageID"];//
            Ety0052.contentId=[returnDataBody objectForKey:@"contentId"];//
            Ety0052.interPicURL1=[returnDataBody objectForKey:@"interPicURL1"];//
            Ety0052.original=[returnDataBody objectForKey:@"original"];//
            Ety0052.type=[returnDataBody objectForKey:@"type"];//
        }
        
        Ety0052.selAffMerchNum=[[returnDataBody objectForKey:@"selAffMerchNum"]intValue];//
        if (Ety0052.selAffMerchNum>0) {
            Ety0052.affMerchID=[returnDataBody objectForKey:@"affMerchID"];//
            Ety0052.affMerchName=[returnDataBody objectForKey:@"affMerchName"];//
            Ety0052.gxhBiaozhi=[returnDataBody objectForKey:@"gxhBiaozhi"];//
        }
        
        
        
        
        Ety0052.isEt=[NSString stringWithFormat:@"%@",[returnDataBody objectForKey:@"isEt"]];//
        Ety0052.etId=[returnDataBody objectForKey:@"etId"];//
        Ety0052.etNo=[returnDataBody objectForKey:@"etNo"];//
        Ety0052.etSxNo=[returnDataBody objectForKey:@"etSxNo"];//
        Ety0052.etSxMc=[returnDataBody objectForKey:@"etSxMc"];//
        Ety0052.etXzNo=[returnDataBody objectForKey:@"etXzNo"];//
        Ety0052.etXzMc=[returnDataBody objectForKey:@"etXzMc"];//
        Ety0052.interPicURL=[returnDataBody objectForKey:@"interPicURL"];
        Ety0052.etPicURL=[returnDataBody objectForKey:@"etPicURL"];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self initData];
        });
        
        
        
    }
    if ([msgReturn.formName isEqual:@"JY0051"]) {
        if(msgReturn.map==nil)
            return;
        
        NSLog(@"0051 %lu",(unsigned long)[msgReturn.map count]);
        for (int i =0; i<contentList.count; i++)
        {
            ContentClass* ety = contentList[i];
            ContentClass* ety1 = oldcontentList[i];
            if (ety.img != ety1.img)
            {
                ety1.img=ety.img;
            }
        }
        
        
        [self gotoShoppingView];
        [self cleararr];

    }
    if ([msgReturn.formName isEqual:@"JY0063"]) {
        
        if(msgReturn.map==nil)
            return;
        
        NSLog(@"0063 %lu",(unsigned long)[msgReturn.map count]);
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        Ety0063 =[[RespondParam0063 alloc]init];
        Ety0063.interPicURL=[returnDataBody objectForKey:@"interPicURL"];//
        Ety0063.etPicURL=[returnDataBody objectForKey:@"etPicURL"];//
        Ety0063.templateId=[returnDataBody objectForKey:@"templateId"];//
        
        [self setBianshiDatawithetNo:tmpiset withszNo:tmpxzno withsxNo:tmpsxno];

        
        AsynImageView* asynImgView =[[AsynImageView alloc]init];
        asynImgView.imageURL1 = Ety0063.interPicURL;
        asynImgView.imageURL2 = Ety0063.etPicURL;
        asynImgView.setImg=^(UIImage*img)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (img==nil) {
                    bjimg = [UIImage imageNamed:@"ic_gxh_fail_modelbg.9.png"];
                    [self setbtnEnabledNO];
                }
                else
                {
                    bjimg =img;
                    [self setbtnEnabledYES];
                }
                self.imgView.image =bjimg;
                [SVProgressHUD dismiss];
            });
        };
        [asynImgView setImageURL:asynImgView.imageURL1 andImageURL2:asynImgView.imageURL2];
        
    }
    
}
-(void) ReturnError:(MsgReturn*)msgReturn
{
    [self setbtnEnabledYES];
}

#pragma mark -加入购物车委托返回事件
-(void)addShoppingDelegateCallBack:(MsgReturn*)msgReturn
{
    if ([msgReturn.errorCode isEqualToString:@"0000"]) {
        
        [self gotoShoppingView];
        [self cleararr];
        msgReturn.errorCode=@"0023";//图片上传失败，是否要重试
        [PromptError changeShowErrorMsg:msgReturn title:@"个性化定制"  viewController:self block:^(BOOL OKCancel)
         {
             if (OKCancel) {
                 
             }else
             {
             }
             return ;
         }
         ];
    }
}

-(void)addShoppingDelegateCallBackError:(MsgReturn*)msgReturn
{
    [self setbtnEnabledYES];
}

#pragma mark - 初始化图片
-(void)initImg
{
    
    for(int i=0;i<Ety0049.contentIdNum;i++)
    {
        if ([Ety0049.contentType[i] intValue] == 1) {//附图
            ContentClass *contentEty =[[ContentClass alloc]init];
            contentEty.contentid =Ety0049.contentId[i];
            contentEty.type=@"1";
            contentEty.contentnotice =[Ety0049.contentDirName[i] uppercaseString];
            contentEty.contentwidth =[Ety0049.contentWidth[i] floatValue];
            contentEty.contentheight =[Ety0049.contentHeight[i] floatValue];
            
            if ([contentList count]>=Ety0049.contentIdNum) {
                break;
            }
            [contentList addObject:contentEty];
        }        
    }
    for(int i=0;i<Ety0049.itemNum;i++)
    {
        PicClass *picEty =[[PicClass alloc]init];
        picEty.contentid = Ety0049.linkcontenteId[i];
        
        picEty.px=[Ety0049.itemX[i] floatValue];
        picEty.py=[Ety0049.itemY[i] floatValue];
        [picList addObject:picEty];
    }
    
    
    for (ContentClass* contentEty in contentList) {
        for (PicClass* picEty in picList) {
            NSString* tmpcontentid =[NSString stringWithFormat:@"%@",contentEty.contentid];
            if ( [tmpcontentid isEqual:picEty.contentid]) {
                picEty.pwidth =contentEty.contentwidth;
                picEty.pheight=contentEty.contentheight;
                
            }
        }
    }
    
    

    UIImage* defualtImg = [UIImage imageNamed:@"ic_gxh_fail_modelbg.9.png"];

    for (ContentClass* ety in contentList) {
        for (int j=0; j<Ety0052.recordNum; j++) {
            UIImage*img = [[UIImage alloc]init];
            if ([Ety0052.contentId[j] isEqual:[NSString stringWithFormat:@"%@",ety.contentid ]]) {
               
                ety.type=Ety0052.type[j];
                img =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:Ety0052.interPicURL1[j]]]];
                if (img==nil) {
                    img =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:Ety0052.original[j]]]];
                }
                if (img==nil) {
                    img =defualtImg;
                }
               ety.img =img;
               ety.imageid =Ety0052.imageID[j];
                
            }
            
        }
    }
    
    
    for(PicClass *picEty in picList)
    {
        for (ContentClass* contentEty in contentList) {
            if ([[NSString stringWithFormat:@"%@",contentEty.contentid] isEqual:picEty.contentid] ) {
                picEty.img =contentEty.img;
            }
        }
    }

    for (ContentClass* contentEty in contentList) {
        ContentClass* ety =[[ContentClass alloc]init];
        ety.img = contentEty.img;
        ety.contentid = contentEty.contentid;
        ety.imageid = contentEty.imageid;
        
      
        [oldcontentList addObject: ety];
    }
    
}
-(void)reloadImg
{
    
    for (UIView* view in self.imglistlView.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat x = 0.0;
    CGFloat y = 0.0;

//    rect = (CGRect){10, 0, width, width};

    mtarr=[NSMutableArray array];
    for(int i=0;i<contentList.count;i++)
    {
        rowindex = i/3; //第几行，每行3列排版
        columnindex = i%3; //第几列
        
        ContentClass* picety =contentList[i];
        
        GxhPostageFuTuViewController* futuView =[[GxhPostageFuTuViewController alloc]init];
        
        x = columnindex*(width+8) +5;
        y = rowindex*(width+35);
        rect = (CGRect){x, y, width, width};
        futuView.view.frame =rect;
        [futuView initDatawith:picety withRect:&rect ];
        futuView.selectImg=^(ContentClass*ety){
            contentID =ety.contentid;
            currntContent =ety;
            [self click];
            
        };
        [mtarr addObject:futuView];
        [self.imglistlView addSubview:futuView.view];
    }
    

    self.imglistlView.frame =CGRectMake(0, 50, self.view.bounds.size.width, (rowindex+1)*(width+35));
    [self.dingZhiView addSubview:self.imglistlView];

    
}
#pragma mark-合成图片
-(void)gomakepic
{
    CGFloat px;
    CGFloat py;
    CGFloat picwidth;
    CGFloat picheight;
    
    CGFloat imgviewwidth =self.imgView.frame.size.width;
    CGFloat imgviewheight =self.imgView.frame.size.height;
    for (PicClass* picEty in picList) {
        NSLog(@"x:[%.2f] y:[%.2f] width:[%.2f] height:[%.2f]",picEty.px,picEty.py,picEty.pwidth, picEty.pheight);
        picwidth  = picEty.pwidth  / imgtwidth * imgviewwidth;
        picheight = picEty.pheight / imgheight * imgviewheight;
        px = picEty.px / imgtwidth * imgviewwidth;
        py = picEty.py / imgheight * imgviewheight;
        picEty.pimgView =[[UIImageView alloc]init];
        picEty.pimgView.frame =CGRectMake(px, py, picwidth, picheight);
        picEty.pimgView.image =picEty.img;

        [self.imgView addSubview:picEty.pimgView];
       
    }
}
#pragma mark -照相功能
-(void)click
{
    UIActionSheet* actionSheet =[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: @"从手机相册获取",@"拍照",@"复制", nil];
    
    [actionSheet showInView:self.view];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
 
    //打印出字典中的内容
    NSLog(@"get the media info: %@", info);
    
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // 裁剪
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake((self.view.bounds.size.width-currntContent.contentwidth)/2, (self.view.bounds.size.height-currntContent.contentheight-60)/2, currntContent.contentwidth, currntContent.contentheight) limitScaleRatio:3.0];
        
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO
        }];
    }];

}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSLog(@"图片保存成功");
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
}
#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}
#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    
    UIImage* tmpimg = [BasicClass scaleImage:editedImage toSize:CGSizeMake(currntContent.contentwidth, currntContent.contentheight)];
    
    NSData * tmpimgdata =UIImageJPEGRepresentation(tmpimg, scalevale);
    
    CGFloat tmpimgwidthaaa = tmpimg.size.width;
    CGFloat tmpimgheightaaa =tmpimg.size.height;
    int tmpsize =[tmpimgdata length];
    NSLog(@"原图b3[%d]",tmpsize);
    
    UIImage* tmpscrImg =[UIImage imageWithData:tmpimgdata];
    int tmpsize2 =[UIImageJPEGRepresentation(tmpscrImg, scalevale) length];
    CGFloat tmpimgwidthbbb = tmpscrImg.size.width;
    CGFloat tmpimgheightbbb =tmpscrImg.size.height;
    NSLog(@"原图b4[%d]",tmpsize2);
    
    
    if ([picflag isEqual:@"1"]) {
        //将该图像保存到媒体库中
        UIImageWriteToSavedPhotosAlbum(tmpimg, self,@selector(image:didFinishSavingWithError:contextInfo:), NULL);
    }
    
    for (ContentClass *ety in contentList) {
        if (ety.contentid ==contentID) {
            
            if ([self checkImg:tmpscrImg withContentEty:ety]) {
                ety.img=tmpscrImg;
            }
            else
            {
                return ;
            }
            
        }
    }
    for (PicClass *ety in picList) {
        if ([ety.contentid isEqual:[NSString stringWithFormat:@"%@", contentID]]) {
            ety.img=tmpscrImg;
        }
    }
    
    [self reloadImg];
    [self gomakepic];
    
    
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}
#pragma mark -图片类型检查
-(bool)imageTypeCheck:(NSData*)imgdata
{
    //图片类型检查开始
    NSString* imgtype =[[BasicClass typeForImageData:imgdata] uppercaseString];
    
    SqlQuerySignService* signservice =[[SqlQuerySignService alloc]init];
    NSString* querystr = [((SignServiceEntity*)[signservice querySignServiceWithKey:@"GXH_PIC_TYPECOMP"]).serviceValue uppercaseString];
    NSArray* typelist =[querystr componentsSeparatedByString:@";"];
    bool typeflag=false;//是否是符合格式的图片
    for (int i=0; i<typelist.count; i++) {
        if ([imgtype isEqual:typelist[i]]) {
            typeflag =true;
            break;
        }
    }
    
    if (!typeflag) {
        MsgReturn* msgreturn =[[MsgReturn alloc]init];
        msgreturn.errorCode =@"9999";
        msgreturn.errorDesc = [NSString stringWithFormat:@"您当前选择的图片类型不符合系统要求，要求的图片格式为:%@",querystr];
        msgreturn.errorType=@"01";
        
        [PromptError changeShowErrorMsg:msgreturn title:@"温馨提示"  viewController:self block:^(BOOL OKCancel)
         {
             if (OKCancel) {
             }else
             {
             }
             return ;
         }
         ];
        return false;
    }
    return true;
    //图片类型检查结束
}


#pragma mark -UIActionSheetDelegate,拍照,打开相册
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //呼出的菜单按钮点击后的响应
    if (buttonIndex == actionSheet.cancelButtonIndex)
    {
        NSLog(@"取消");
    }
    
    switch (buttonIndex)
    {
        case 0:  //打开本地相册
            [self LocalPhoto];
            break;
        case 1:  //打开照相机拍照
            [self takePhoto];
            break;
        case 2:  //复制
            [self copyImg];
            break;
    }
}

//开始拍照
-(void)takePhoto
{
    picflag=@"1";//拍照
    
    //检查相机模式是否可用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        NSLog(@"sorry, no camera or camera is unavailable.");
        return;
        
    }
    
    //获得相机模式下支持的媒体类型
    NSArray* availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    
    BOOL canTakePicture = NO;
    
    for (NSString* mediaType in availableMediaTypes) {
        if ([mediaType isEqualToString:(NSString*)kUTTypeImage]) {
            //支持拍照
            canTakePicture = YES;
            break;
        }
    }
    
    //检查是否支持拍照
    if (!canTakePicture) {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
        return;
    }
    
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == ALAuthorizationStatusRestricted || authStatus == ALAuthorizationStatusDenied){
        
        UIAlertView* alter =[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"此应用没有权限访问你的拍照功能，您可以在设置中启用访问。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alter show];
        return;
    }
    
    
    //创建图像选取控制器
    UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
    //设置图像选取控制器的来源模式为相机模式
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //设置图像选取控制器的类型为静态图像
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*)kUTTypeImage, nil];
    //允许用户进行编辑
    imagePickerController.allowsEditing = NO;
    //设置委托对象
    imagePickerController.delegate = self;
    
    //以模视图控制器的形式显示
    [self presentViewController:imagePickerController animated:YES completion:^{}];
    
}

//打开本地相册
-(void)LocalPhoto
{
    picflag=@"2";//选择照片

    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //以模视图控制器的形式显示
    [self presentViewController:picker animated:YES completion:^{}];

 }

-(bool)checkImg:(UIImage*)srcimg withContentEty:(ContentClass*)ety
{
    
    NSData* imgdata =UIImageJPEGRepresentation(srcimg, scalevale);
    if (imgdata ==nil) {
        imgdata =UIImagePNGRepresentation(srcimg);
    }
    
    int imgsize = imgdata.length;
    
    
    NSLog(@"editimgsize[%d]",imgsize);
    //检查图片类型
    bool imgtypeflag = [self imageTypeCheck:imgdata];
    if (!imgtypeflag) {
        return false;
    }
    
    CGFloat tmpimgwidth = srcimg.size.width;
    CGFloat tmpimgheight =srcimg.size.height;
    MsgReturn* msgreturn =[[MsgReturn alloc]init];
    if (tmpimgwidth<ety.contentwidth || tmpimgheight<ety.contentheight)
    {
        msgreturn.errorCode =@"9999";
        msgreturn.errorDesc = [NSString stringWithFormat:@"选择的原始图片不能比当前区域要求的图片小,要求的最小宽度和高度分别为:%.0f,%.0f",ety.contentwidth,ety.contentheight];
        msgreturn.errorType=@"01";
        [PromptError changeShowErrorMsg:msgreturn title:@"温馨提示"  viewController:self block:^(BOOL OKCancel)
         {
             if (OKCancel) {
             }else
             {
             }
         }
         ];
        return false;
    }
    
    SqlQuerySignService* signservice =[[SqlQuerySignService alloc]init];
    NSString* imgmaxsize = ((SignServiceEntity*)[signservice querySignServiceWithKey:@"GXH_PIC_MAXSIZE"]).serviceValue;
    if (imgsize>[imgmaxsize intValue]*1024*1024)
    {
        msgreturn.errorCode =@"9999";
        msgreturn.errorDesc = [NSString stringWithFormat:@"选择的图片不能大于 %@M",imgmaxsize];
        msgreturn.errorType=@"01";
        [PromptError changeShowErrorMsg:msgreturn title:@"温馨提示"  viewController:self block:^(BOOL OKCancel)
         {
             if (OKCancel) {
             }else
             {
             }
         }
         ];
        return false;
    }
    return  true;
}

-(void)copyImg
{
    NSMutableArray* datalist =[NSMutableArray array];
    for (ContentClass* ety in contentList) {
        if (ety.img!=nil) {
            [datalist addObject:ety];
        }
    }
    
    GxhPostageCopyImgViewController* gxhview =[[GxhPostageCopyImgViewController alloc]init];
    gxhview.contentList =datalist;
    gxhview.copyImgWithContentId=^(NSString* selectedcontentid)
    {
        UIImage* tmpimg;
        for (ContentClass* ety in contentList) {
            if (ety.contentid == selectedcontentid) {
                tmpimg =ety.img;
                break;
            }
        }
        for (ContentClass* ety in contentList) {
            if (ety.contentid ==currntContent.contentid) {
                ety.img =tmpimg;
                break;
            }
        }
        for (PicClass *ety in picList) {
            if ([ety.contentid isEqual:[NSString stringWithFormat:@"%@", contentID]]) {
                ety.img=tmpimg;
            }
        }
        [self reloadImg];
        [self gomakepic];
        
    };
    [self presentViewController:gxhview animated:YES completion:nil];
}

#pragma mark- 上传图片
-(void)upImgFile:(int)picindex
{
  
    ServiceInvoker *serviceInvoker=[ServiceInvoker sharedInstance];
    [serviceInvoker  setDelegate:self];
    
    SysBaseInfo *sysBaseInfo =[SysBaseInfo sharedInstance];
    NSString* appid=sysBaseInfo.appID;
    
    ContentClass* ety =  contentList[picindex];
    NSMutableDictionary* dic =[[NSMutableDictionary alloc]init];
    if (ety.img!=nil) {
        NSData * imgdata =UIImageJPEGRepresentation(ety.img, scalevale);
        if (imgdata==nil) {
            imgdata =UIImagePNGRepresentation(ety.img);
        }
        
        
        NSString* imgbyteStr =[imgdata base64Encoding];
        NSString* md5value =[BasicClass md5Digest:imgbyteStr];
        NSString* imgsizevalue =[NSString stringWithFormat:@"%lu",(unsigned long)imgdata.length] ;
        NSLog(@"imgsizevalue[%@]",imgsizevalue);
        [dic setValue:[NSString stringWithFormat:@"%@.jpg", ety.contentid] forKey:@"fileName"];
        [dic setValue:imgsizevalue forKey:@"fileSize"];
        [dic setValue:@"01" forKey:@"fileType"];
        [dic setValue:md5value forKey:@"md5"];
        [dic setValue:@"" forKey:@"uploadPath"];
        [dic setValue:[NSString stringWithFormat:@"%@%@",imgbyteStr,@"f4e69f0c0219f2f3d545cc7ad7d26ae8"]  forKey:@"requestFileData"];
        [serviceInvoker fileUp:appid map:dic ];
    }
}

//业务请求返回错误
-(void)serviceInvokerError:(MsgReturn*)msgReturn
{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [SVProgressHUD dismiss];
//    });
    

    [self setbtnEnabledYES];
    
    [SVProgressHUD dismiss];
    if(msgReturn.formName!=nil && [msgReturn.errorCode isEqualToString:ERROR_FAILED])
    {//交易失败
        
        dispatch_async(dispatch_get_main_queue(), ^{
            MsgReturn *msgReturn=[[MsgReturn alloc]init];
            msgReturn.errorCode=@"0062";//图片上传失败，是否要重试
            [PromptError changeShowErrorMsg:msgReturn title:@"个性化定制"  viewController:self block:^(BOOL OKCancel)
             {
                 if (OKCancel) {
                     [self upImgFile:picnum];
                     [self setbtnEnabledNO];
                 }else
                 {
                 }
                 return ;
             }
             ];
        });
    }
    else
    {
        //网络错误 服务器错误  传输格式错误
        if([msgReturn.errorCode isEqualToString:ERROR_DATA_FORMAT_ERROR] || [msgReturn.errorCode isEqualToString:ERROR_SERVICE_IN_ERROR] || [msgReturn.errorCode isEqualToString:ERROR_NOT_NET])
            
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel)
                 {
                     if (OKCancel) {
                         
                     }else
                     {
                     }
                     return ;
                 }
                 ];
            });
        }
    }
    
    NSLog(@"%@ %@",msgReturn.formName,msgReturn.errorDesc);
    
}

//业务请求返回数据
-(void)serviceInvokerReturnData:(MsgReturn*)msgReturn
{

    
    if([msgReturn.errorCode isEqualToString:ERROR_SUCCESS])
    {//callWebservice成功
        
        picnum =picnum+1;
        NSString *imageId = [msgReturn.map objectForKey:@"imageId"];
        NSString *filename = [msgReturn.map objectForKey:@"originalFileName"];
        NSString* tmpcontentid = [filename substringToIndex:([filename length]-4)];
        for (ContentClass* ety in contentList)
        {
            NSString* tmpcontentid1 =[NSString stringWithFormat:@"%@",ety.contentid];
            if ( [tmpcontentid isEqual:tmpcontentid1])
            {
                ety.original =imageId;
            }
        }
    
        
        
        if ([flag  isEqual: @"0"])//定制
        {
            if (picnum == contentList.count)
            {//全部图片上传成功
                picnum =0;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    [self addShopingCart];
                });
                
            }
            else
            {
                if ( picnum<=Ety0049.contentIdNum) {
                     [self upImgFile:picnum];
                }
                
               
            }
        }
        
        
        if ([flag  isEqual: @"1"])//修改
        {
            recordnum++;
            if(recordnum == modpicnum)
            {//全部图片上传成功
                picnum =0;
                modpicnum =0;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    [self modifyOrder0051];
                });
                
            }
            else
            {
                
                    
                for (int i =picnum; i<contentList.count; i++)
                {
                    ContentClass* ety = contentList[i];
                    ContentClass* ety1 = oldcontentList[i];
                    if (ety.img != ety1.img)
                    {
                        picnum = i ;
                        [self upImgFile:picnum];
                        
                    }
                }
                
            }
        }
        
        
        
    }else{//错误码 非0000
        
        [self setbtnEnabledYES];
        
        NSLog(@"%@ %@",msgReturn.errorCode,msgReturn.errorDesc);
        [PromptError changeShowErrorMsg:msgReturn title:nil viewController:self block:nil];
    }
    
}


-(void)cleararr
{
    readImg = nil;
    authImg = nil;
    mtarr = nil;
    contentList= nil;//附图数组
    oldcontentList= nil;//附图数组
    picList= nil;//上传图片数组
    
    currntContent= nil;//当前选择相片的附图
    
    SaleRuleInfo= nil;
    selMerchID= nil;
}

-(void)setbtnEnabledNO
{
    [self.btnAddShopCart setEnabled:NO];
    [self.btnModify setEnabled:NO];
}
-(void)setbtnEnabledYES
{
    [self.btnAddShopCart setEnabled:YES];
    [self.btnModify setEnabled:YES];
}

@end
