//
//  ReplaceOrderViewController.m
//  Philately
//
//  Created by Mirror on 15/6/30.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "ReplaceOrderViewController.h"
#import "ReplaceOrderDetailViewController.h"
#import "ReplaceOrderApplicationViewController.h"
#import "MyReplaceOrdersViewController.h"

@interface ReplaceOrderViewController ()

@end

@implementation ReplaceOrderViewController
@synthesize orderNo;
@synthesize status;
@synthesize myreplaceorderflag;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbtitle.text=@"换货";
    dataList =[NSMutableArray array];
    [self queryOrder];
    
    if ([status isEqualToString:@"1"]) {
        [self.btnApplicationOrder setHidden:NO];
    }
    else
    {
        [self.btnApplicationOrder setHidden:YES];
        
    }
}

-(void)bindData
{
    mtarr =[NSMutableArray array];
    if (dataList.count==0) {
        self.nonView.frame=self.ScrollView.frame;
        [self.ScrollView addSubview: self.nonView];
    }
    else
    {
        for (int i =0; i<dataList.count; i++) {
            ReplaceOrderCellViewController * replaceordercell =[[ReplaceOrderCellViewController alloc]init];
            if (i==0) {
                replaceordercell.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 80);
            }else
            {
                replaceordercell.view.frame = CGRectMake(0, i*(80+2), self.view.frame.size.width, 80);
                
            }
            replaceordercell.delegate= self;
            [replaceordercell initData:dataList[i]];
            [mtarr addObject:replaceordercell];
            [self.ScrollView addSubview:replaceordercell.view];
        }
    }
    [self initframe];
}
-(void)initframe
{
    self.ScrollView.frame =CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60);
    if (dataList.count>0) {
        self.ScrollView.contentSize =CGSizeMake(self.view.frame.size.width, dataList.count*(80+2));
    }    
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self initframe];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -换货单详情
-(void)gotoReplaceDetail:(RespondParam0057*)Ety
{
    ReplaceOrderDetailViewController * replaceOrderDetail =[[ReplaceOrderDetailViewController alloc]init];
    replaceOrderDetail.replaceOrderEty =Ety;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:replaceOrderDetail animated:YES];
}
#pragma mark - 我要换货
- (IBAction)goApplicationOrder:(id)sender {
    Request0041 *request0041 =[[Request0041 alloc]init];
    request0041.delegate =self;
    [request0041 request0041:orderNo];
}

#pragma mark - 订单详情 获取 已购买商品信息
-(void)jy0041Result:(NSDictionary *)result
{
        ReplaceOrderApplicationViewController *orderApplication =[[ReplaceOrderApplicationViewController alloc]init];
        orderApplication.orderNo=orderNo;
        orderApplication.resultData=result;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:orderApplication animated:YES];
}


- (IBAction)goback:(id)sender {
    for (UIViewController* view in self.navigationController.viewControllers) {
        if ([view isKindOfClass:[MyReplaceOrdersViewController class]]) {
            [self.navigationController popToViewController:view animated:YES];
            return;
        }
    }
    
    MyReplaceOrdersViewController * myreplaceView =[[MyReplaceOrdersViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myreplaceView animated:YES];
}
#pragma mark - 按订单号查询换货单 与 返回处理方法
-(void)queryOrder
{
    NSString * n0057 =@"JY0057";
    CstmMsg *_cstmmsg = [CstmMsg sharedInstance];
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    [para setValue:_cstmmsg.cstmNo forKey:@"cstmNo"];
    [para setValue:orderNo forKey:@"orderNo"];
    
    SysBaseInfo *_sysBaseInfo = [SysBaseInfo sharedInstance];
    StampTranCall * stampTranCall = [StampTranCall sharedInstance];
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmmsg formName:n0057 business:para delegate:self viewController:self];
    
}

-(void) ReturnData:(MsgReturn*)msgReturn
{
    
    [SVProgressHUD dismiss];
    if ([msgReturn.formName isEqual:@"JY0057"]) {
        if(msgReturn.map==nil)
            return;
        
        NSLog(@"0057 %lu",(unsigned long)[msgReturn.map count]);
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        
        int recordNum =[[returnDataBody objectForKey:@"recordNum"] intValue];
        int applyMerchNum =[[returnDataBody objectForKey:@"applyMerchNum"] intValue];
        int applyPicNum =[[returnDataBody objectForKey:@"applyPicNum"] intValue];
        int exchangMerchNum =[[returnDataBody objectForKey:@"exchangMerchNum"] intValue];
        
        for (int i=0; i<recordNum; i++) {
            repalceOrderEty = [[RespondParam0057 alloc]init];
            repalceOrderEty.applyMerchList =[NSMutableArray array];
            repalceOrderEty.applyPicList =[NSMutableArray array];
            repalceOrderEty.exchangeMerchList =[NSMutableArray array];
            repalceOrderEty.exchangMerchNo =[returnDataBody objectForKey:@"exchangMerchNo"][i];
            repalceOrderEty.linkOrderNo =[returnDataBody objectForKey:@"linkOrderNo"][i];
            repalceOrderEty.applyDate =[returnDataBody objectForKey:@"applyDate"][i];
            repalceOrderEty.dealStatus =[returnDataBody objectForKey:@"dealStatus"][i];
            repalceOrderEty.userDesc =[returnDataBody objectForKey:@"userDesc"][i];
            repalceOrderEty.refuseReason =[returnDataBody objectForKey:@"refuseReason"][i];
            repalceOrderEty.mailAddress =[returnDataBody objectForKey:@"mailAddress"][i];
            repalceOrderEty.logistCompany =[returnDataBody objectForKey:@"logistCompany"][i];
            repalceOrderEty.logistNum =[returnDataBody objectForKey:@"logistNum"][i];
            
            for (int j=0; j<applyMerchNum; j++) {
                ApplyMerchItems* applyMerchItems =[[ApplyMerchItems alloc]init];
                NSString* exchangeMerchNo =[returnDataBody objectForKey:@"linkExchangMerchNo1"][j];
                if ([repalceOrderEty.exchangMerchNo isEqualToString:exchangeMerchNo]) {
                    applyMerchItems.linkExchangMerchNo1 =[returnDataBody objectForKey:@"linkExchangMerchNo1"][j];
                    applyMerchItems.linkMerchID =[returnDataBody objectForKey:@"linkMerchID"][j];
                    applyMerchItems.merchName =[returnDataBody objectForKey:@"merchName"][j];
                    applyMerchItems.merchNum =[returnDataBody objectForKey:@"merchNum"][j];
                }
                [repalceOrderEty.applyMerchList addObject:applyMerchItems];
            }
            
            for (int j=0; j<applyPicNum; j++) {
                ApplyPicItems* applyPicItems =[[ApplyPicItems alloc]init];
                NSString* exchangeMerchNo =[returnDataBody objectForKey:@"linkExchangMerchNo2"][j];
                if ([repalceOrderEty.exchangMerchNo isEqualToString:exchangeMerchNo]) {
                    applyPicItems.linkExchangMerchNo2 =[returnDataBody objectForKey:@"linkExchangMerchNo2"][j];
                    applyPicItems.interPicURL =[returnDataBody objectForKey:@"interPicURL"][j];
                    applyPicItems.merchPicID =[returnDataBody objectForKey:@"merchPicID"][j];
                }
                [repalceOrderEty.applyPicList addObject:applyPicItems];
            }
            
            for (int j=0; j<exchangMerchNum; j++) {
                ExchangMerchItems* exchangMerchItems =[[ExchangMerchItems alloc]init];
                NSString* exchangeMerchNo =[returnDataBody objectForKey:@"linkExchangMerchNo3"][j];
                if ([repalceOrderEty.exchangMerchNo isEqualToString:exchangeMerchNo]) {
                    exchangMerchItems.linkExchangMerchNo3 =[returnDataBody objectForKey:@"linkExchangMerchNo3"][j];
                    exchangMerchItems.dealTime =[returnDataBody objectForKey:@"dealTime"][j];
                    exchangMerchItems.dealContent =[returnDataBody objectForKey:@"dealContent"][j];
                    exchangMerchItems.dealPerson =[returnDataBody objectForKey:@"dealPerson"][j];
                }
                [repalceOrderEty.exchangeMerchList addObject:exchangMerchItems];
            }
            
            [dataList addObject:repalceOrderEty];
        }
        [self bindData];
    }
}
-(void) ReturnError:(MsgReturn*)msgReturn
{
    [SVProgressHUD dismiss];
}

@end
