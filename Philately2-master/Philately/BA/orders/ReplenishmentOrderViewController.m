//
//  ReplenishmentOrderViewController.m
//  Philately
//
//  Created by Mirror on 15/6/30.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "ReplenishmentOrderViewController.h"
#import "ReplenishmentOrderCellViewController.h"
#import "OrderTrackViewController.h"
#import "OrderFormDetailViewController.h"
#import "PayedSuccessViewController.h"

#import "Order.h"
#import "DataSigner.h"

#import <AlipaySDK/AlipaySDK.h>

@interface ReplenishmentOrderViewController ()

@end

@implementation ReplenishmentOrderViewController

static int pagenum = 10;
static int pagecode = 1;
static int totalnum =0;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbtitle.text=@"补退款";
    dataList =[NSMutableArray array];

    self.ScrollView.delegate =self;
    pagecode =1;
    [self queryOrder];

}
-(void)bindData
{
    mtarr =[NSMutableArray array];
    if (dataList.count==0) {
        self.nonView.frame=self.ScrollView.frame;
        [self.ScrollView addSubview: self.nonView];
    }
    else {
        for (int i=0; i<dataList.count; i++) {
            ReplenishmentOrderCellViewController * recell =[[ReplenishmentOrderCellViewController alloc]init];
            if (i==0) {
                recell.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 125);
            }
            else
            {
                recell.view.frame = CGRectMake(0, i*(125 +2), self.view.frame.size.width, 125);
                
            }
            
            recell.gotoDetail=^(NSString* orderNO){
                OrderFormDetailViewController* orderDetailView =[[OrderFormDetailViewController alloc]initWithNibName:@"OrderFormDetailViewController" bundle:nil];
                orderDetailView.orderNo= orderNO;
                self.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:orderDetailView animated:YES];
                
            };
            
            recell.goPay=^(RespondParam0040*Ety){
                [self makePay:Ety];
            };
            
            [recell initData:dataList[i]];
            [mtarr addObject:recell];
            [self.ScrollView addSubview: recell.view];
        }
        
        self.ScrollView.contentSize = CGSizeMake(self.view.frame.size.width, dataList.count*(125+2));
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 返回事件
- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 投诉申请 与 返回处理方法
-(void)queryOrder
{
    NSString * n0040 =@"JY0040";
    CstmMsg *_cstmmsg = [CstmMsg sharedInstance];
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    [para setValue:_cstmmsg.cstmNo forKey:@"cstmNo"];
    [para setValue:@"" forKey:@"orderNo"];
    [para setValue:@"" forKey:@"busiNo"];
    [para setValue:@"0" forKey:@"orderStatusNum"];
    [para setValue:@"" forKey:@"startDate"];
    [para setValue:@"" forKey:@"endDate"];
    [para setValue:@"" forKey:@"channelNo"];
    [para setValue:@"" forKey:@"payType"];
    [para setValue:@"2" forKey:@"sortType"];
    [para setValue:@"0" forKey:@"sortFieldID"];
    [para setValue:@"" forKey:@"queryTypeFlag"];
    [para setValue:@"0" forKey:@"fundFlag"];
    [para setValue:[NSString stringWithFormat:@"%d",pagecode] forKey:@"pageCode"];
    [para setValue:[NSString stringWithFormat:@"%d",pagenum] forKey:@"pageNum"];
    
    SysBaseInfo *_sysBaseInfo = [SysBaseInfo sharedInstance];
    StampTranCall * stampTranCall = [StampTranCall sharedInstance];
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmmsg formName:n0040 business:para delegate:self viewController:self];
    
}
#pragma mark - 支付宝支付
-(void)makePay:(RespondParam0040*)Ety
{

    CstmMsg *_cstmmsg = [CstmMsg sharedInstance];
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    [para setValue:_cstmmsg.cstmNo forKey:@"cstmNo"];
    
    NSString* payMode =@"02";
    [para setValue:payMode forKey:@"payMode"];
    
    NSString* paytype =@"61";
    [para setValue:paytype forKey:@"payType"];
    
    [para setValue:@"1" forKey:@"orderNoNum"];
    
    NSArray* orderArr=@[Ety.orderNo];
    [para setValue:orderArr forKey:@"orderNo"];
    
    
    OrderPay0039 *payclass =[[OrderPay0039 alloc]init];
    [payclass orderPay:para delegate:self];

}
-(void)payResult:(NSDictionary *)resultDic
{
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
    }
    else if ([status isEqual:@"6001"]) {
        NSLog(@"用户取消支付宝支付");
    }
    else
    {
        UIAlertView* alter =[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"支付宝支付失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        NSLog(@"支付宝支付失败");
    }
    
}
-(NSString*)makePaystring:(RespondParam0040*)Ety
{
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088002422807029";
    NSString *seller = @"yzgw183185@163.com";
    NSString *privateKey = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAN8rasLCTaNE5qDdWri9djnfiL+e6QIQNIHxpugbn7E6stEAL3NcR2t1M56G9mSbEFwwtUl7N28iBDbO02QU+g0D/unMET/XDFjBlC+iPEHwvFxOQv8cjgpRX0XXmyfgOZTSQqd7DRgCLtj51G4JFmuHvBTmrPBEFODFv0+2FlXnAgMBAAECgYEAuMdjGyT0UYYACxucPTAqDpsFx9sUhG/Uee8SykXtADpgymoD39l9DP06ozyOEBjP//UYdWH/MRYSNSsknk48BjTq9N6lyKUgOMAal/aaY2wcB0MmZM029/uyTVfHnX/oQM1WYU9R/Pxs0RSr/x3asUSqULth5520Hi8KIZouzAkCQQD0Ui29F7d1JQunqsoK/JfOfzLP7vCenP8eVM6f0umsdHf+//LVL+VewfioV3uHGMzdo6qXAOV3ynfwSJOPihIzAkEA6dZnI/+shCaAPEsLd2lcLNGYZww9As3nqEalMmPWlWG0us67BK9aliGuoObd5rrhuJXpHxSuo2rOkljwc0HBfQJBAN5EKLIe8lpTAmBdYoNOOji0xSAfaq2RfBI26ubBNK4cItJMPLkvYoarBjD3rTxBFpcH/vhy607oVea1z/BElrsCQQCsaCgjop7P0JM74RjTMhuD8AUt9RgGuUnUCEJEpNfRy/g0w7ef/KoNh0f52j5BoAhM0DrRb65TTqx/upOOZy0BAkBSCXVZyYODNXo5EXlk98PFH/DsQIO6YFw0SirKmVmINjcZTmqnxmOjG83w65jNQ1Y1VPO5KnS049r0vSWqZ06c";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return @"";
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = @"20150611092030100231"; //订单ID（由商家自行制定）
    order.productName = @"123"; //商品标题
    order.productDescription = @"test"; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",0.01]; //商品价格
    order.notifyURL =  @"http://www.xxx.com"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
//    NSString *appScheme = @"alisdkdemo";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
    }
    return orderString;
}
-(void) ReturnData:(MsgReturn*)msgReturn
{
    [SVProgressHUD dismiss];
    if ([msgReturn.formName isEqual:@"JY0040"]) {
        if(msgReturn.map==nil)
            return;
        [dataList removeAllObjects];
        NSLog(@"0040 %lu",(unsigned long)[msgReturn.map count]);
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        
        totalnum = [[returnDataBody objectForKey:@"totalNum"] intValue];
        int recordNum =[[returnDataBody objectForKey:@"recordNum"] intValue];
        for (int i=0; i<recordNum; i++) {
            orderEty = [[RespondParam0040 alloc]init];
            orderEty.orderNo =[returnDataBody objectForKey:@"orderNo"][i];
            orderEty.busiNo =[returnDataBody objectForKey:@"busiNo"][i];
            orderEty.orderAmt =[[returnDataBody objectForKey:@"orderAmt"][i] floatValue];
            orderEty.bookDate =[returnDataBody objectForKey:@"bookDate"][i];
            orderEty.payStatus =[returnDataBody objectForKey:@"payStatus"][i];
            orderEty.dealStatus =[returnDataBody objectForKey:@"dealStatus"][i];
            orderEty.channelNo =[returnDataBody objectForKey:@"channelNo"][i];
            orderEty.isReplacing =[returnDataBody objectForKey:@"isReplacing"][i];
            orderEty.changeType =[returnDataBody objectForKey:@"changeType"][i];
            orderEty.changeAmount =[returnDataBody objectForKey:@"changeAmount"][i];
            orderEty.changeStatus =[returnDataBody objectForKey:@"changeStatus"][i];
            [dataList addObject:orderEty];
        }
        [self bindData];
    }
}
-(void) ReturnError:(MsgReturn*)msgReturn
{
    [SVProgressHUD dismiss];
}

#pragma mark -scrollview 滑动到底部触发事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView

{
    
    CGPoint offset = scrollView.contentOffset;
    
    
    
    CGRect bounds = scrollView.bounds;
    
    
    
    CGSize size = scrollView.contentSize;
    
    
    
    UIEdgeInsets inset = scrollView.contentInset;
    
    
    
    CGFloat currentOffset = offset.y + bounds.size.height - inset.bottom;
    
    
    
    CGFloat maximumOffset = size.height;
    
    
    
    //当currentOffset与maximumOffset的值相等时，说明scrollview已经滑到底部了。也可以根据这两个值的差来让他做点其他的什么事情
    
    
    
    if(currentOffset==maximumOffset)
    {
        
        NSLog(@"-----我要刷新数据-----");
        if(totalnum % pagenum == 0)
        {
            if (pagecode<totalnum/pagenum) {
                pagecode =pagecode+1;
                [self queryOrder];
            }
        }
        else
        {
            if (pagecode<totalnum/pagenum+1) {
                pagecode =pagecode+1;
                [self queryOrder];
            }
        }
        
        
        
    }
    
}


@end
