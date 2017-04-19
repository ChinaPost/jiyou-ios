//
//  ReplaceOrderDetailViewController.m
//  Philately
//
//  Created by Mirror on 15/7/1.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "ReplaceOrderDetailViewController.h"
#import "ServiceEntity.h"
#import "SqlQueryService.h"
#import "UIImageView+WebCache.h"
#import "ReplaceOrderViewController.h"
#import "ShipCompanyViewController.h"
#import "AsynImageView.h"

#import "SqlQueryService.h"
#import "ServiceEntity.h"
#import "DateConvert.h"

@interface ReplaceOrderDetailViewController ()

@end

@implementation ReplaceOrderDetailViewController
@synthesize replaceOrderEty;
static int picheight;
static float imgviewHeight;
static NSString * exchangMerchNo;


- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    
    self.tfshipNo.delegate =self;
    
    picheight = [[NSString stringWithFormat:@"%.0f",([UIScreen mainScreen].bounds.size.width -30)/3] intValue];;
    
    [self.tfrefuseReason setEditable:NO];
    [self.tfuserDesc setEditable:NO];
    if ([replaceOrderEty.dealStatus isEqual:@"03"]) {//审核不通过
        unDoFlag =@"1";//不显示
    }
    else
    {
        unDoFlag =@"0";//显示撤销按钮
    }
    if ([replaceOrderEty.dealStatus isEqual:@"01"]||[replaceOrderEty.dealStatus isEqual:@"03"]) {//待审核，审核不通过
        emailFlag =@"1";//不显示
    }
    else
    {
        emailFlag =@"0";//显示回邮信息
        
    }
//    [self.lbshipCompany.layer setBorderColor:(__bridge CGColorRef)([UIColor colorWithRed:53.0f/255.0f green:95.0f/255.0f blue:40.0f/255.0f alpha:1.0f])];
    self.lbshipCompany.layer.borderWidth=1.0f;
    self.lbshipCompany.userInteractionEnabled=YES;
    UITapGestureRecognizer* tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getShipCompany)];
    [self.lbshipCompany addGestureRecognizer:tap];
       
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickview)]];
    
    
    dataList =[NSMutableArray array];
    picList =[NSMutableArray array];
    [SVProgressHUD showWithStatus:@"努力加载中..." maskType:SVProgressHUDMaskTypeClear ];
    [self initData];
    [SVProgressHUD dismiss];
    
}
-(void)clickview
{
    [self.tfshipNo resignFirstResponder];
}
-(void)initData
{
    self.lborderNo.text =replaceOrderEty.linkOrderNo;
    exchangMerchNo = replaceOrderEty.exchangMerchNo;
    self.lbreplaceOrderNo.text = exchangMerchNo;
    ServiceEntity* serviceEty = [[ServiceEntity alloc]init];
    SqlQueryService* sqlservice =[[SqlQueryService alloc]init];
    serviceEty = [sqlservice queryServiceWithKey:@"EXCHAGESTATUS" withcode:replaceOrderEty.dealStatus];
    self.lbstatus.text= serviceEty.serviceName;
    self.tfuserDesc.text =replaceOrderEty.userDesc;
    self.tfrefuseReason.text = replaceOrderEty.refuseReason;
    self.lbshipCompany.text =replaceOrderEty.logistCompany;
    self.tfshipNo.text =replaceOrderEty.logistNum;
    
    for (ApplyMerchItems* applyItems in replaceOrderEty.applyMerchList) {
        if ([applyItems.linkExchangMerchNo1 isEqual:exchangMerchNo]) {
            [dataList addObject:applyItems];
        }
    }
    
    for (ApplyPicItems* applyPicItems in replaceOrderEty.applyPicList) {
        if ([applyPicItems.linkExchangMerchNo2 isEqual:exchangMerchNo]) {
            [picList addObject:applyPicItems];
        }
    }
    
//    dataList =replaceOrderEty.applyMerchList;
    
    
    
    mtarr =[NSMutableArray array];
    for (int i=0; i<dataList.count;i++) {
        ReplaceOrderDetailCellViewController *detailcell =[[ReplaceOrderDetailCellViewController alloc] init];
        if (i==0) {
            detailcell.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 30);
        }
        else
        {
            detailcell.view.frame = CGRectMake(0, i*(30+1), self.view.frame.size.width, 30);
        }
        [detailcell initData:dataList[i]];
        [mtarr addObject:detailcell];
        [self.merchView addSubview:detailcell.view];
    }
    
    
    UIImage* img1=[UIImage imageNamed:@"defaultimg.png"];
    for (int i=0; i<picList.count; i++) {
        UIImageView* img;
        if (i<3) {
            img=[[UIImageView alloc]initWithFrame:CGRectMake(i*(picheight+5)+8, 25, picheight, picheight)];
            imgviewHeight = 25+ picheight+10;
        }
        else
        {
            img=[[UIImageView alloc]initWithFrame:CGRectMake((i-3)*(picheight+5)+8, 25+picheight+5, picheight, picheight)];
            imgviewHeight = 25+ picheight*2+10;
        }
        
        img.image = img1;
        
        NSString*interPicUlr =((ApplyPicItems*)picList[i]).interPicURL;
        NSString*merchPicID =((ApplyPicItems*)picList[i]).merchPicID;
        
        AsynImageView* asynView =[[AsynImageView alloc]init];
        asynView.imageURL1 = interPicUlr;
        asynView.imageURL2 = merchPicID;
        asynView.setImg=^(UIImage* returnimg)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (returnimg==nil) {
                    asynView.placeholderImage = [UIImage imageNamed:@"defaultimg.png"];
                }
                img.image = asynView.image;;
                
            });
        };
        [asynView setImageURL:asynView.imageURL1 andImageURL2:asynView.imageURL2];
        [self.imgView addSubview:img];
    }
    
    

    
    self.merchView.frame= CGRectMake(0, self.orderView.frame.size.height+2, self.view.frame.size.width, dataList.count*(30+1)+10);
    [self.basicView addSubview:self.merchView];
    
    self.imgView.frame=CGRectMake(0, 110, self.view.frame.size.width, imgviewHeight);
    [self.reasonView addSubview:self.imgView];
    
    self.reasonView.frame = CGRectMake(0, self.orderView.frame.size.height+2+self.merchView.frame.size.height+2, self.view.frame.size.width, 110+imgviewHeight);
    [self.basicView addSubview:self.reasonView];
    
    [self initFrame];
}

-(void)initFrame
{
    self.merchView.frame= CGRectMake(0, self.orderView.frame.size.height+2, self.view.frame.size.width, dataList.count*(30+1)+10);
    [self.basicView addSubview:self.merchView];
    
    self.imgView.frame=CGRectMake(0, 110, self.view.frame.size.width, imgviewHeight);
    [self.reasonView addSubview:self.imgView];
    
    self.reasonView.frame = CGRectMake(0, self.orderView.frame.size.height+2+self.merchView.frame.size.height+2, self.view.frame.size.width, 110+imgviewHeight);
    [self.basicView addSubview:self.reasonView];
    
    if ([emailFlag isEqual:@"1"]) {
        //隐藏 回邮信息
        if ([replaceOrderEty.dealStatus isEqual:@"03"]) {
            //审核不通过，显示拒绝 原因
            self.basicView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.orderView.frame.size.height+self.merchView.frame.size.height+self.reasonView.frame.size.height);
            
            self.refuseView.frame=CGRectMake(0, self.basicView.frame.size.height+2, self.view.frame.size.width, 130);
            [self.bigScrollView addSubview:self.basicView];
            [self.bigScrollView addSubview:self.refuseView];
            
            self.bigScrollView.contentSize =CGSizeMake(self.view.frame.size.width, self.basicView.frame.size.height+self.refuseView.frame.size.height+10);
        }
        else
        {
            //待审核
            
            self.basicView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.orderView.frame.size.height+self.merchView.frame.size.height+self.reasonView.frame.size.height);

            [self.bigScrollView addSubview:self.basicView];
            
            self.bigScrollView.contentSize =CGSizeMake(self.view.frame.size.width, self.basicView.frame.size.height+10);
        }
    }
    else
    {
        
        if ([replaceOrderEty.dealStatus isEqual:@"02"]) {//等待买家发货，显示回邮信息，允许保存修改
            
            self.lbshipCompany.userInteractionEnabled =true;
            [self.imgdown setHidden:NO];
            [self.btnsure setHidden:NO];
            [self.tfshipNo setEnabled:YES];
        }
        else //显示回邮信息，不允许修改
        {
            self.lbshipCompany.userInteractionEnabled =false;
            [self.imgdown setHidden:YES];
            [self.btnsure setHidden:YES];
            [self.tfshipNo setEnabled:NO];
            
        }
        
        self.basicView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.orderView.frame.size.height+self.merchView.frame.size.height+self.reasonView.frame.size.height);

        self.saveView.frame=CGRectMake(0, self.basicView.frame.size.height+2, self.view.frame.size.width, 200);
        [self.bigScrollView addSubview:self.basicView];
        [self.bigScrollView addSubview:self.saveView];
        
        self.bigScrollView.contentSize =CGSizeMake(self.view.frame.size.width, self.basicView.frame.size.height+self.saveView.frame.size.height+180);
    }
    

    
    self.bigScrollView.frame=CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60);
}



-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self initFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getShipCompany
{
    ShipCompanyViewController* shipCompanyView =[[ShipCompanyViewController alloc]init];
    shipCompanyView.refreshCompany=^(NSString*name){
        self.lbshipCompany.text = name;
    };

    
    [self presentViewController:shipCompanyView animated:YES completion:^{
        
    }];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.tfshipNo resignFirstResponder];
    return NO;
}

#pragma mark - 撤销换货单功能，提交回邮功能 交易
//编辑换货单
-(void)editReplaceOrder0047
{
    
    
    if(![DateConvert isCommonChar:self.tfuserDesc.text])
    {
        //[self.view makeToast:@"请输入用户名"];
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        
        msgReturn.errorDesc=@"理由含有非法字符，请修改";//不能为空
        msgReturn.errorType=@"01";
        msgReturn.errorCode=@"-0078";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        return ;
    }
    
    
    NSString * n0047 =@"JY0047";
    CstmMsg *_cstmmsg = [CstmMsg sharedInstance];
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    [para setValue:_cstmmsg.cstmNo forKey:@"cstmNo"];
    
    [para setValue:self.lborderNo.text forKey:@"orderNo"];
    [para setValue:self.lbreplaceOrderNo.text forKey:@"exchangMerchNo"];
    [para setValue:@"1" forKey:@"modifyType"];
    [para setValue:self.tfuserDesc.text forKey:@"applyReason"];
    [para setValue:0 forKey:@"applyMerchNum"];
    [para setValue:0 forKey:@"applyPicNum"];
    [para setValue:self.lbshipCompany.text forKey:@"logistCompany"];
    [para setValue:self.tfshipNo.text forKey:@"logistNum"];
    
    SysBaseInfo *_sysBaseInfo = [SysBaseInfo sharedInstance];
    StampTranCall * stampTranCall = [StampTranCall sharedInstance];
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmmsg formName:n0047 business:para delegate:self viewController:self];
}

//撤销换货单
-(void)unDoReplaceOrder0048
{
    NSString * n0048 =@"JY0048";
    CstmMsg *_cstmmsg = [CstmMsg sharedInstance];
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    [para setValue:_cstmmsg.cstmNo forKey:@"cstmNo"];
    
    [para setValue:self.lborderNo.text forKey:@"orderNo"];
    [para setValue:self.lbreplaceOrderNo.text forKey:@"exchangMerchNo"];
    
    SysBaseInfo *_sysBaseInfo = [SysBaseInfo sharedInstance];
    StampTranCall * stampTranCall = [StampTranCall sharedInstance];
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmmsg formName:n0048 business:para delegate:self viewController:self];
    
}

-(void) ReturnData:(MsgReturn*)msgReturn
{
    [SVProgressHUD dismiss];
    if ([msgReturn.formName isEqual:@"JY0047"]) {//编辑换货单
        if(msgReturn.map==nil)
            return;
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        msgReturn.errorCode=@"0061";//确认撤销本次换货申请
        [PromptError changeShowErrorMsg:msgReturn title:@"换货详情"  viewController:self block:^(BOOL OKCancel)
         {
             if (OKCancel)
             {
             }else
             {
             }
             return ;
         }
         ];       
        NSLog(@"0047 %lu",(unsigned long)[msgReturn.map count]);
        for (UIViewController* view in self.navigationController.viewControllers) {
            if ([view isKindOfClass:[ReplaceOrderViewController class]]) {
                [((ReplaceOrderViewController*)view) viewDidLoad];
                [self.navigationController popToViewController:view animated:YES];
            }
        }
    }
    else if ([msgReturn.formName isEqual:@"JY0048"]) {//撤销换货单
        if(msgReturn.map==nil)
            return;
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        msgReturn.errorCode=@"0060";//确认撤销本次换货申请
        [PromptError changeShowErrorMsg:msgReturn title:@"换货详情"  viewController:self block:^(BOOL OKCancel)
         {
             if (OKCancel) {
             }else
             {
             }
             return ;
         }
         ];
        NSLog(@"0048 %lu",(unsigned long)[msgReturn.map count]);
        for (UIViewController* view in self.navigationController.viewControllers) {
            if ([view isKindOfClass:[ReplaceOrderViewController class]]) {
                [((ReplaceOrderViewController*)view) viewDidLoad];
                [self.navigationController popToViewController:view animated:YES];
            }
        }
    }
}
-(void) ReturnError:(MsgReturn*)msgReturn
{
    [SVProgressHUD dismiss];
}

#pragma mark - 按钮响应事件
- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)goUnDo:(id)sender {    
    MsgReturn *msgReturn=[[MsgReturn alloc]init];
    msgReturn.errorCode=@"0056";//确认撤销本次换货申请
    [PromptError changeShowErrorMsg:msgReturn title:@"换货详情"  viewController:self block:^(BOOL OKCancel)
     {
         if (OKCancel) {
             [self unDoReplaceOrder0048];
         }else
         {
             
         }
         return ;
     }
     ];
}

- (IBAction)goapplication:(id)sender {
    
     MsgReturn *msgReturn=[[MsgReturn alloc]init];
    if(self.lbshipCompany.text==nil ||[self.lbshipCompany.text isEqualToString:@""])
    {
        msgReturn.errorCode=@"0001";//不能为空
        [PromptError changeShowErrorMsg:msgReturn title:@"物流公司"  viewController:self block:^(BOOL OKCancel){} ];
        
        return;
    }
    if(self.tfshipNo.text==nil ||[self.tfshipNo.text isEqualToString:@""])
    {
        msgReturn.errorCode=@"0001";//不能为空
        [PromptError changeShowErrorMsg:msgReturn title:@"物流单号"  viewController:self block:^(BOOL OKCancel){} ];
        
        return;
    }
    else
    {
        if (self.tfshipNo.text.length>30) {
            msgReturn.errorCode=@"0003";//长度过长
            msgReturn.errorPic=true;
            [PromptError changeShowErrorMsg:msgReturn title:@"物流单号"  viewController:self block:^(BOOL OKCancel){}];
            return;
        }
    }
    
    
    [self editReplaceOrder0047];
}
@end
