//注入网络请求,响应,等待提示



#import "OrderFormDetailViewController.h"
#import "UIImageView+WebCache.h"
#import <Foundation/Foundation.h>
#import <PublicFramework/JSONKit.h>
#import "ProductOrderForm.h"
#import "RespondParam0041.h"
#import "SqlApp.h"
#import "OrderFormDetailTableViewCellHead.h"
#import "DateConvert.h"
#import "OrderTrackViewController.h"
#import "TouSuShengQingViewController.h"
#import "RespondParam0038.h"
#import "MainViewController.h"
#import "GxhPostageViewController.h"
#import "GxhPostageListViewController.h"
#import "PayedSuccessViewController.h"

#import "ReplaceOrderApplicationViewController.h"

#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "OrderFormListProductCell.h"
#import "OrderFormListBottomCell.h"
#import "UserMarkLinearLayoutScrollViewCell.h"
#import "CountMoneyLinearLayoutScrollViewCell.h"
#import "TruePayLinearLayoutScrollViewCell.h"

@implementation OrderFormDetailViewController
@synthesize orderNo;


//back
@synthesize backImageView;
//订单详情
@synthesize titleTextView;
//业务类型
@synthesize businessTypeTitleTextView;
//新邮预订
@synthesize businessTypeValueTextView;
//订单号:
@synthesize orderFormNoTitleTextView;
//13434
@synthesize orderFormNoValueTextView;
//订单状态
@synthesize orderFormStateTitleTextView;
//已支付
@synthesize orderFromStateValueTextView;
//下单时间
@synthesize orderFormTimeTitleTextView;
//20150303
@synthesize orderFormTimeValueTextView;
//处理状态
@synthesize dealStateTitleTextView;
//未处理
@synthesize dealStateValueTextView;

//订单金额
@synthesize totalMoneyTitleTextView;
//253.00
@synthesize totalMoneyValueTextView;
//补款
@synthesize needPayTitleTextView;
//¥20
@synthesize needPayValueTextView;
//配送方式
@synthesize deliverWayTitleTextView;
//自提
@synthesize deliverWayTextView;
//广州市区
@synthesize deliverWayAddressTextView;
//收货人信息
@synthesize receiverInfoTitleTextView;
//周小五
@synthesize receiverNameTextView;
//158444399
@synthesize receiverPhoneTextView;
//广州市
@synthesize receiverAddressTextView;
//商品信息
@synthesize productTitleTextView;
//发票信息
@synthesize invoiceInfoTextView;
//个人发票
@synthesize invoiceTypeTextView;
//李四
@synthesize invoiceUserNameTextView;
//营销员号
@synthesize salerNoTitleTextView;
//3443
@synthesize salerNoValueTextView;
//去补款20元
@synthesize gotoPayButton;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handTap)];
     [self.backImageView addGestureRecognizer:tap];
    
    self.scrollview.contentSize= CGSizeMake(320,610);
    
    
    
    
    
    //            如果 操作类型为“01 支付”，则显示支付按钮；
    //            如果 操作类型为“02 取消”，则显示取消按钮；
    //            如果 操作类型为“03 投诉”，则显示投诉按钮；
    //            如果 操作类型为“04 物流”，则显示物流按钮；
    //05 "审核结果"
    //06  "定制预览"
    
    //物流
    [self.wuliuBtn addTarget:self action:@selector(wuliuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //取消
    [self.cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //投诉
    [self.reportBtn addTarget:self action:@selector(reportBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //支付
    [self.gotoPayButton addTarget:self action:@selector(gotoPayButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //审核结果
     [self.checkResult addTarget:self action:@selector(checkResultClick:) forControlEvents:UIControlEventTouchUpInside];
    //定制预览
     [self.diymodel addTarget:self action:@selector(diymodelClick:) forControlEvents:UIControlEventTouchUpInside];
       [self.changeProduct addTarget:self action:@selector(changeProductClick:) forControlEvents:UIControlEventTouchUpInside];
   
        [self.gotoPayButton setHidden:YES];
        [self.cancelBtn setHidden:YES];
        [self.reportBtn setHidden:YES];
        [self.wuliuBtn setHidden:YES];
       [self.checkResult setHidden:YES];
       [self.diymodel setHidden:YES];
    [self.changeProduct setHidden:YES];

    
    
    [self request0041];
    
    chirldViewController=[[OrderFormCancelDetailViewController alloc ] initWithNibName:@"OrderFormCancelDetailViewController" bundle:nil];
    
    [chirldViewController setChirldViewValue:nil delegate:self];
    
   // chirldViewController.view.frame=CGRectMake(,,,);
    [ self.view addSubview:chirldViewController.view];
    [chirldViewController.view setHidden:YES];
}


-(void) chirldViewCallBack:(NSMutableArray*)mdata
{
    
     [self request0042:[mdata objectAtIndex:0]];

}





 //审核结果
-(void)checkResultClick:(UIButton*)btn
{
    GxhPostageListViewController * gxhPostageListView =[[GxhPostageListViewController alloc]init];
    gxhPostageListView.orderNo = prepNumber;
    [self.navigationController pushViewController:gxhPostageListView animated:YES];

}


 //定制预览
-(void)diymodelClick:(UIButton*)btn
{
    GxhPostageViewController* gxhPostageView =[[GxhPostageViewController alloc]init];
    
    gxhPostageView.merchNum=[NSString stringWithFormat:@"%d",((RespondParam0041*)productList[0]).merchNum];
    
    for (RespondParam0041* ety in productList) {
        if (ety.gxhBiaozhi ==0) {
            gxhPostageView.merchId =ety.merchID;
            break;
        }
    }
    
    float price =0.0;
    for (RespondParam0041* ety in productList)
    {
      price = price+ ety.normsPrice;
    }
    
    gxhPostageView.merchPrice =price;
    gxhPostageView.orderNo =prepNumber;
    
    NSString* ismodify= @"";
    if ([dealStatus isEqualToString:@"12"]
        ||[dealStatus isEqualToString:@"13"]
        ||[dealStatus isEqualToString:@"14"]
        ||[dealStatus isEqualToString:@"15"]
        ||[dealStatus isEqualToString:@"16"]) {
        ismodify=@"1";
    }
    else
    {
        ismodify=@"0";
    }
    gxhPostageView.isModify =ismodify;
    
    gxhPostageView.fromflag=@"2";
    
    self.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:gxhPostageView animated:YES];
    
}

// 换货
-(void)changeProductClick:(UIButton*)btn
{

    ReplaceOrderApplicationViewController *orderApplication =[[ReplaceOrderApplicationViewController alloc]init];
    orderApplication.orderNo=orderNo;
    orderApplication.resultData=result0041;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:orderApplication animated:YES];

}

//物流信息
-(void)wuliuBtnClick:(UIButton*)btn
{
    OrderTrackViewController* view =[[OrderTrackViewController alloc]init];
    view.resultData =result0041;
//    [self presentViewController:view animated:NO completion:^{
//        
//    }];
    self.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:view animated:YES];

}


//取消
-(void)cancelBtnClick:(UIButton*)btn
{
//    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"确定取消订单？"
//                                                    message:@"请输入取消理由"
//                                                   delegate:self
//                                          cancelButtonTitle:@"取消"
//                                          otherButtonTitles:@"确定", nil];
//    // 基本输入框，显示实际输入的内容
//    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
//    
//    [alert show];
    
    
      [chirldViewController.view setHidden:NO];
    

}



//
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    
////    if (buttonIndex==1) {
////        UITextField *tf=[alertView textFieldAtIndex:0];
////        
////        [self request0042:tf.text];
////    }
//    
//}


//投诉信息
-(void)reportBtnClick:(UIButton*)btn
{
    TouSuShengQingViewController * touSuShengQing =[[TouSuShengQingViewController alloc]init];
    touSuShengQing.orderNO =orderNo;
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:touSuShengQing animated:YES];
    
}


//支付
-(void)gotoPayButtonClick:(UIButton*)btn
{
  NSString* payMode;
    if (btn.tag==1) {//去支付
          payMode =@"01";
    }else if(btn.tag==8)
    {//补款
      payMode =@"02";
    }
    [self makePay:payMode];
 
}


-(void) viewDidLayoutSubviews
{


}

-(void)handTap{
    
   // [self presentViewController:updatePwdViewController animated:NO completion:^{}];

    
    [self.navigationController popViewControllerAnimated:NO];
}


-(void) viewWillAppear:(BOOL)animated{
}


-(void) setUiValue{
    
}


#pragma mark - 支付宝支付
-(void)makePay:(NSString*)payMode
{

    
    
    CstmMsg *_cstmmsg = [CstmMsg sharedInstance];
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    [para setValue:_cstmmsg.cstmNo forKey:@"cstmNo"];
    
   
    [para setValue:payMode forKey:@"payMode"];
    
    NSString* paytype =@"61";
    [para setValue:paytype forKey:@"payType"];
    
 
    [para setValue:@"1" forKey:@"orderNoNum"];

    NSMutableArray  *orderlist=[[NSMutableArray alloc] init ];
    [orderlist addObject:orderNo];
    [para setValue:orderlist forKey:@"orderNo"];
    
    
    OrderPay0039* PayClass =[[OrderPay0039 alloc]init];
    [PayClass orderPay:para delegate:self];
    
  /*
    NSString* paySeq =@"total_fee=\"0.01\"&it_b_pay=\"30m\"&notify_url=\"http://211.156.193.101:8080/AliPayPhoneNoticeAction.do\"&payment_type=\"1\"&seller_id=\"2088501806719007\"&service=\"mobile.securitypay.pay\"&partner=\"2088501806719007\"&_input_charset=\"utf-8\"&out_trade_no=\"20150819095638106518\"&subject=\"集邮网厅商品\"&return_url=\"http://211.156.193.101:8080/AliPaySynchroAction.do\"&body=\"PREM201500060739-PREM201500060739-JYW-MOBILE\"&sign_type=\"RSA\"&sign=\"SUjN2JBPs44%2Bff6wQERjxyJgVb%2FqGhMa6KqfNsQ9Hr15h8uYqflVEt%2FIi5ExhuSvq5TfSfBOe%2BzpqComVrtpmITAHFe6C48RMLcxJgziUY4A82PDSU2Xt%2F7TS0budu2JWSG889V9hS8wwPBM5Mkgpgry5JOjTL6%2Fb2oJ02PcPpk%3D\"";
    
    
//    NSString* paySeq = [self makePaystring];
    NSLog(@"paySeq[%@]",paySeq);
    NSString* appScheme=@"PhilatelyScheme";
    
    if (paySeq != nil) {
        [[AlipaySDK defaultService] payOrder:paySeq fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            NSString*status =[resultDic objectForKey:@"resultStatus"];
            if ([status isEqual:@"9000"]) {
                NSLog(@"支付宝支付成功");
                
                
            }
            else if ([status isEqual:@"6001"]) {
                NSLog(@"用户取消支付宝支付");
            }
            else
            {
                NSLog(@"支付宝支付失败");
            }
        }];
    }
   */
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

-(NSString*)makePaystring
{
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088501806719007";
    NSString *seller = @"2088501806719007";
    NSString *privateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAIWfsoRPFMYyi6ACh8qgxjHA4svG7luxSWPWzMSBGUFFlat801YH8zq22AcQebj6kHAkt6uR8BMmNgcsiPoGpDi8uudgt/geLEo/Oi2baYcOkR/ZcnNZ1X7ooLfcCfmiK8U0nVnS2twvNoYGC6lQnHqCkv1vs8f9J0cI4i67klGPAgMBAAECgYBivgEgDoQudfmBs3z++lGbQIsXxJgs/9RYx8knSLMN7crNH3/YKiXN9IGsrrsUO2xywl9LlJtQu0LfiERsZm4BQc7Df28FlH+hHH5Gk3IC4fAN/s6c7IL79Fi6kiWcdpxCxIXNu4gz52IaF9gbbJ4ozYb5GJ8nR6UEfuoz5XXfIQJBAL8iDCj+ouk1UFGkJtd+1UpCMC/os1GF4LBdqRFRFI5QZK7sdaMMAQy0nVtmqEX3wX2Ucg3pSdidILaRM+i3j78CQQCy+Sgbqv3Z/XQsa3Ovx2nOvPYQf0+//2+p1yynVhFz/xqNKZkMawKSOpovLn0QtBkFlmkWhr3QkucYUabww7IxAkADNUMW/Q8m8uoiNKsiOtLBqFK+ux0nZSPcUfYggEfkC51lAjsHPZBW8kEh45s3cW0h+nffm+bNZ/XAmrdQVKRpAkEAlRQRoqpV9YS3hmCi5qKWsgyYcrl5dpaRLsn7eg+pThQKy9cAk2V3qNKDqBVzO7yoswzM0GTAK8KSGKG7CwYXoQJAGUhfnOoYgiISH5x0O5ST2WdFwc1i3QW3x2ovBlz2xOQwpE3uGWg3c2nXUPh1zZSojioxeCZrQyrTJDy3bYj1Xg==";
    
//    NSString* aaa=@"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAN8rasLCTaNE5qDdWri9djnfiL+e6QIQNIHxpugbn7E6stEAL3NcR2t1M56G9mSbEFwwtUl7N28iBDbO02QU+g0D/unMET/XDFjBlC+iPEHwvFxOQv8cjgpRX0XXmyfgOZTSQqd7DRgCLtj51G4JFmuHvBTmrPBEFODFv0+2FlXnAgMBAAECgYEAuMdjGyT0UYYACxucPTAqDpsFx9sUhG/Uee8SykXtADpgymoD39l9DP06ozyOEBjP//UYdWH/MRYSNSsknk48BjTq9N6lyKUgOMAal/aaY2wcB0MmZM029/uyTVfHnX/oQM1WYU9R/Pxs0RSr/x3asUSqULth5520Hi8KIZouzAkCQQD0Ui29F7d1JQunqsoK/JfOfzLP7vCenP8eVM6f0umsdHf+//LVL+VewfioV3uHGMzdo6qXAOV3ynfwSJOPihIzAkEA6dZnI/+shCaAPEsLd2lcLNGYZww9As3nqEalMmPWlWG0us67BK9aliGuoObd5rrhuJXpHxSuo2rOkljwc0HBfQJBAN5EKLIe8lpTAmBdYoNOOji0xSAfaq2RfBI26ubBNK4cItJMPLkvYoarBjD3rTxBFpcH/vhy607oVea1z/BElrsCQQCsaCgjop7P0JM74RjTMhuD8AUt9RgGuUnUCEJEpNfRy/g0w7ef/KoNh0f52j5BoAhM0DrRb65TTqx/upOOZy0BAkBSCXVZyYODNXo5EXlk98PFH/DsQIO6YFw0SirKmVmINjcZTmqnxmOjG83w65jNQ1Y1VPO5KnS049r0vSWqZ06c";
    
    
//    NSString *partner = @"2088002422807029";
//    NSString *seller = @"yzgw183185@163.com";
//    NSString *privateKey = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAN8rasLCTaNE5qDdWri9djnfiL+e6QIQNIHxpugbn7E6stEAL3NcR2t1M56G9mSbEFwwtUl7N28iBDbO02QU+g0D/unMET/XDFjBlC+iPEHwvFxOQv8cjgpRX0XXmyfgOZTSQqd7DRgCLtj51G4JFmuHvBTmrPBEFODFv0+2FlXnAgMBAAECgYEAuMdjGyT0UYYACxucPTAqDpsFx9sUhG/Uee8SykXtADpgymoD39l9DP06ozyOEBjP//UYdWH/MRYSNSsknk48BjTq9N6lyKUgOMAal/aaY2wcB0MmZM029/uyTVfHnX/oQM1WYU9R/Pxs0RSr/x3asUSqULth5520Hi8KIZouzAkCQQD0Ui29F7d1JQunqsoK/JfOfzLP7vCenP8eVM6f0umsdHf+//LVL+VewfioV3uHGMzdo6qXAOV3ynfwSJOPihIzAkEA6dZnI/+shCaAPEsLd2lcLNGYZww9As3nqEalMmPWlWG0us67BK9aliGuoObd5rrhuJXpHxSuo2rOkljwc0HBfQJBAN5EKLIe8lpTAmBdYoNOOji0xSAfaq2RfBI26ubBNK4cItJMPLkvYoarBjD3rTxBFpcH/vhy607oVea1z/BElrsCQQCsaCgjop7P0JM74RjTMhuD8AUt9RgGuUnUCEJEpNfRy/g0w7ef/KoNh0f52j5BoAhM0DrRb65TTqx/upOOZy0BAkBSCXVZyYODNXo5EXlk98PFH/DsQIO6YFw0SirKmVmINjcZTmqnxmOjG83w65jNQ1Y1VPO5KnS049r0vSWqZ06c";
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
    order.tradeNO = @"20150817092030100232"; //订单ID（由商家自行制定）
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

/*订单详情0041*/
NSString  *n0041=@"JY0041";
/*订单详情0041*/
-(void) request0041{
    
   
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 会员编号 备注:必填*/
    [businessparam setValue:_cstmMsg.cstmNo forKey:@"cstmNo"];
    /* 订单号 备注:必填*/
//    [businessparam setValue:orderForm.orderNo forKey:@"orderNo"];
    [businessparam setValue:orderNo forKey:@"orderNo"];
    
    
    
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0041 business:businessparam delegate:self viewController:self];
    
    
}




/*订单取消0042*/
NSString  *n0042=@"JY0042";
/*订单取消0042*/
-(void) request0042:(NSString*)msg{
    
    

    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 订单号 备注:必填*/
    [businessparam setValue:orderNo forKey:@"orderNo"];
    /* 取消原因 备注:选填*/
    [businessparam setValue:msg forKey:@"cancelReason"];
    [businessparam setValue:_cstmMsg.cstmNo forKey:@"cstmNo"];
    
    
    
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0042 business:businessparam delegate:self viewController:self];
}




/*收货确认0043*/
NSString  *n0043=@"JY0043";
/*收货确认0043*/
-(void) request0043{
    ProductOrderForm *orderForm=[ProductOrderForm sharedInstance ];
    
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 会员编号 备注:必填*/
    [businessparam setValue:_cstmMsg.cstmNo forKey:@"cstmNo"];
    /* 订单号 备注:必填*/
    [businessparam setValue:orderNo forKey:@"orderNo"];
    
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0043 business:businessparam delegate:self viewController:self];
}




-(void) ReturnError:(MsgReturn*)msgReturn
{
    
    /*订单详情0041*/
    if ([msgReturn.formName isEqualToString:n0041]){
        [self dismissViewControllerAnimated:NO completion:^(){}];
        [self.navigationController popViewControllerAnimated:NO];
        
    }
    
}


-(void) ReturnData:(MsgReturn*)msgReturn
{
    
    /*订单详情0041*/
    if ([msgReturn.formName isEqualToString:n0041]){
        
        SqlApp  *sql=[[SqlApp alloc] init];
     
        
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        result0041 =returnDataBody;
        
        
        RespondParam0041 *commonItem=[[RespondParam0041 alloc]init];
        /* 订单号 备注:*/
        commonItem.orderNo=[returnDataBody objectForKey:@"orderNo"];
        /* 业务代号 备注:*/
        commonItem.busiNo=[returnDataBody objectForKey:@"busiNo"];
        /* 渠道代号 备注:*/
        commonItem.channelNo=[returnDataBody objectForKey:@"channelNo"];
        /* 支付方式 备注:*/
        commonItem.payType=[returnDataBody objectForKey:@"payType"];
        
        
       // sellerName	店铺名称	字符	100	2015/11/10新增
         commonItem.sellerName=[returnDataBody objectForKey:@"sellerName"];
       // subtractionPoint	扣除积分	浮点		2015/11/10新增
         commonItem.subtractionPoint=[returnDataBody objectForKey:@"subtractionPoint"];
        //donatePoint	赠送积分	浮点		2015/11/10新增
         commonItem.donatePoint=[returnDataBody objectForKey:@"donatePoint"];
        //userRemark	给卖家留言	字符	500	2015/11/10新增
         commonItem.userRemark=[returnDataBody objectForKey:@"userRemark"];
        
        if(commonItem.payType==nil || [commonItem.payType isKindOfClass:[NSNull class]])
        {
            commonItem.payType=@"";
        }
        
        /* 下单日期 备注:*/
        commonItem.bookDate=[returnDataBody objectForKey:@"bookDate"];
        /* 处理机构 备注:*/
        commonItem.dealBrch=[returnDataBody objectForKey:@"dealBrch"];
        if(commonItem.dealBrch==nil || [commonItem.dealBrch isKindOfClass:[NSNull class]])
        {
            commonItem.dealBrch=@"";
        }
        
        /* 支付状态 备注:*/
        commonItem.payStatus=[returnDataBody objectForKey:@"payStatus"];
        /* 处理状态 备注:*/
        commonItem.dealStatus=[returnDataBody objectForKey:@"dealStatus"];
        dealStatus =commonItem.dealStatus;
        /* 配送方式 备注:自提方式：自提网点代号 、自提码生效；
         寄递方式：收件人信息 生效*/
        commonItem.shipType=[returnDataBody objectForKey:@"shipType"];
        commonItem.shipMode=[returnDataBody objectForKey:@"shipMode"];
          commonItem.shipModeName=[returnDataBody objectForKey:@"shipModeName"];
        
        /* 自提网点代号 备注:*/
        commonItem.brchNo=[returnDataBody objectForKey:@"brchNo"];
        commonItem.brchName=[returnDataBody objectForKey:@"brchName"];
        commonItem.brchAddress=[returnDataBody objectForKey:@"brchAddress"];
        
        /* 自提码 备注:*/
        commonItem.toTheCode=[returnDataBody objectForKey:@"toTheCode"];
        if(commonItem.toTheCode==nil || [commonItem.toTheCode isKindOfClass:[NSNull class]])
        {
            commonItem.toTheCode=@"";
        }
        
        
        
        /* 收货人姓名 备注:收件人信息*/
        commonItem.recvName=[returnDataBody objectForKey:@"recvName"];
        /* 详细地址 备注:*/
        commonItem.detailAddress=[returnDataBody objectForKey:@"detailAddress"];
        /* 收件手机号码 备注:*/
        commonItem.mobileNo=[returnDataBody objectForKey:@"mobileNo"];
        /* 邮编 备注:*/
        commonItem.postCode=[returnDataBody objectForKey:@"postCode"];
        /* 订单总金额 备注:*/
        commonItem.orderAmt=[[returnDataBody objectForKey:@"orderAmt"] floatValue];
        /* 商品总金额 备注:*/
        commonItem.merchAmt=[[returnDataBody objectForKey:@"merchAmt"] floatValue];
        /* 配送费用 备注:*/
        commonItem.shipFee=[[returnDataBody objectForKey:@"shipFee"] floatValue];
        /* 已付金额 备注:*/
        commonItem.hasPayMoney=[[returnDataBody objectForKey:@"hasPayMoney"] floatValue];
        /* 订单备注信息 备注:*/
        
        commonItem.orderRemark=[returnDataBody objectForKey:@"orderRemark"];
         if(commonItem.orderRemark==nil || [commonItem.orderRemark isKindOfClass:[NSNull class]])
         {
          commonItem.orderRemark=@"";
         }
        
        /* 发票开具类型 备注:不开、个人、单位*/
           NSString *invoiceTypecn= [sql selectPM_ARRAYSERVICEByCode:@"INVOICETYPE" code:[returnDataBody objectForKey:@"invoiceType"]];
        
        commonItem.invoiceType=invoiceTypecn;
        /* 发票抬头 备注:当发票类型为“单位”时生效*/
        commonItem.invoiceTitle=[returnDataBody objectForKey:@"invoiceTitle"];
        if(commonItem.invoiceTitle==nil || [commonItem.invoiceTitle isKindOfClass:[NSNull class]])
        {
            commonItem.invoiceTitle=@"";
        }
        
        /* 预处理单号 备注:个性化定制业务才有预处理单号*/
        commonItem.prepNumber=[returnDataBody objectForKey:@"prepNumber"];
        if(commonItem.prepNumber==nil || [commonItem.prepNumber isKindOfClass:[NSNull class]])
        {
            commonItem.prepNumber=@"";
        }
        prepNumber = commonItem.prepNumber;
        
        commonItem.isReplacing=[returnDataBody objectForKey:@"isReplacing"];
        commonItem.changeType=[returnDataBody objectForKey:@"changeType"];
        commonItem.changeAmount=[returnDataBody objectForKey:@"changeAmount"];
        commonItem.changeStatus=[returnDataBody objectForKey:@"changeStatus"];
        
        
        
        commonItem.orderOperNum=[[returnDataBody objectForKey:@"orderOperNum"] intValue];
        
        NSMutableArray *operationTypes=[[NSMutableArray alloc] init];
        for (int i=0; i<commonItem.orderOperNum; i++) {
            
              RespondParam0041 *commonItem1=[[RespondParam0041 alloc]init];
            /* 操作类型 备注:支付、取消、换货等*/
            commonItem1.operationType=[returnDataBody objectForKey:@"operationType"][i];
            [operationTypes addObject:commonItem1.operationType];
            
            
            
            
            /* 操作截止日期 备注:*/
            commonItem1.operationEndDate=[returnDataBody objectForKey:@"operationEndDate"][i];

        }
        
        [self buttonView:operationTypes];
        
        
             commonItem.orderLogNum=[[returnDataBody objectForKey:@"orderLogNum"] intValue];
        for (int i=0; i<commonItem.orderLogNum; i++) {
              RespondParam0041 *commonItem1=[[RespondParam0041 alloc]init];
            /* 处理时间 备注:yymmddhhmmss*/
            commonItem1.dealTime=[returnDataBody objectForKey:@"dealTime"][i];
            /* 处理类型 备注:*/
            commonItem1.dealType=[returnDataBody objectForKey:@"dealType"][i];
            /* 处理内容 备注:*/
            commonItem1.dealContent=[returnDataBody objectForKey:@"dealContent"][i];
            /* 处理人 备注:*/
            commonItem1.dealPerson=[returnDataBody objectForKey:@"dealPerson"][i];
        }
       
        
         commonItem.orderEventNum=[[returnDataBody objectForKey:@"orderEventNum"] intValue];
        
        for (int i=0; i<commonItem.orderEventNum; i++) {
            RespondParam0041 *commonItem1=[[RespondParam0041 alloc]init];
        /* 事件类型 备注:退款、补款、摇号、换货*/
        commonItem1.eventType=[returnDataBody objectForKey:@"eventType"][i];
        /* 事件状态 备注:未审核、审核通过、审核不通过等*/
        commonItem1.eventStatus=[returnDataBody objectForKey:@"eventStatus"][i];
        /* 事件描述 备注:*/
        commonItem1.eventDesc=[returnDataBody objectForKey:@"eventDesc"][i];
            
        }
        
        
        
        
        commonItem.paySeqNum=[[returnDataBody objectForKey:@"paySeqNum"] intValue];
        
        for (int i=0; i<commonItem.paySeqNum; i++) {
            RespondParam0041 *commonItem1=[[RespondParam0041 alloc]init];
        
        /* 支付流水 备注:*/
        commonItem1.paySeq=[returnDataBody objectForKey:@"paySeq"][i];
        /* 支付流水状态 备注:支付、退款、补款*/
        commonItem1.paySeqStatus=[returnDataBody objectForKey:@"paySeqStatus"][i];
        /* 金额 备注:*/
        commonItem1.payMoney=[[returnDataBody objectForKey:@"payMoney"][i] floatValue];
            
        /* 流水操作状态 备注:*/
        commonItem1.payOperStatus=[returnDataBody objectForKey:@"payOperStatus"][i];
        /* 操作时间 备注:*/
        commonItem1.payDealTime=[returnDataBody objectForKey:@"payDealTime"][i];
        /* 银行流水 备注:*/
        commonItem1.bankSeq=[returnDataBody objectForKey:@"bankSeq"][i];
        /* 备注 备注:*/
        commonItem1.payRemark=[returnDataBody objectForKey:@"payRemark"][i];
        }
        
        
     
        NSString *busincn= [sql selectPM_ARRAYSERVICEByCode:@"BUSINESS" code:commonItem.busiNo];
        ////业务类型
        //[businessTypeTitleTextView setValue:]
        ////新邮预订
        businessTypeValueTextView.text=[NSString stringWithFormat:@"[%@]",busincn] ;
        
        
        
        ////订单号:
        //[orderFormNoTitleTextView setValue:]
        ////13434
        orderFormNoValueTextView.text= commonItem.orderNo;
        
        ////订单状态
        //[orderFormStateTitleTextView setValue:]
   
   
        NSString *dealStatuscn= [sql selectPM_ARRAYSERVICEByCode:@"ORDERSTATUS" code:commonItem.dealStatus];
        
        orderFromStateValueTextView.text=dealStatuscn;
        
        ////下单时间
        //[orderFormTimeTitleTextView setValue:]
        ////20150303
        orderFormTimeValueTextView.text= [DateConvert convertDateFromString:commonItem.bookDate] ;
        
        ////处理状态
        //[dealStateTitleTextView setValue:]
        ////未处理
      
        NSString *payStatuscn= [sql selectPM_ARRAYSERVICEByCode:@"PAYSTATUS" code:commonItem.payStatus];
        
        dealStateValueTextView.text=payStatuscn;
        
        ////已支付
        //[aleadyPayTitleTextView setValue:]
        ////233.00
//        aleadyPayValueTextView.text=[NSString stringWithFormat:@"¥%.2f",commonItem.hasPayMoney] ;
        
        
        ////订单金额
        //[totalMoneyTitleTextView setValue:]
        ////253.00
       
        
        if([commonItem.operationType isEqualToString:@"08"])
        {
             totalMoneyValueTextView.text= [NSString stringWithFormat:@"¥%.2f",[commonItem.changeAmount floatValue]];
        }else
        {
         totalMoneyValueTextView.text= [NSString stringWithFormat:@"¥%.2f",commonItem.orderAmt];
        }
        
        ////补款
        //[needPayTitleTextView setValue:]
        ////¥20
       
        needPayValueTextView.text= [NSString stringWithFormat:@"¥%.2f",commonItem.orderAmt-commonItem.hasPayMoney];
        
        
        ////配送方式
        //[deliverWayTitleTextView setValue:]
        ////自提
          NSString *shipTypecn= [sql selectPM_ARRAYSERVICEByCode:@"SHIPTYPE" code:commonItem.shipType];
        
        deliverWayTextView.text=[NSString stringWithFormat:@"[%@]",shipTypecn] ;
        if ([shipTypecn isEqualToString:@"自提"]) {
             self.deliverwaytype.text=@"";
              self.deliverPrice.text=@"";
        }else
        {
        self.deliverwaytype.text=commonItem.shipModeName;
            self.deliverPrice.text=[NSString stringWithFormat:@"费用:￥%.2f" ,commonItem.shipFee];
        }
        ////广州市区
        deliverWayAddressTextView.text= commonItem.detailAddress;
        
        
        
        
        ////收货人信息  自提信息
        if ([shipTypecn  rangeOfString:@"自提"].location != NSNotFound) {
            
            receiverInfoTitleTextView.text=@"自提信息";
            ////自提网点名字
            receiverNameTextView.text=[NSString stringWithFormat:@"%@%@",@"网点名: ", commonItem.brchName];
            
            ////
            receiverPhoneTextView.text=[NSString stringWithFormat:@"%@%@",@"自提码: ",commonItem.toTheCode];
            
            ////广州市
            receiverAddressTextView.text=[NSString stringWithFormat:@"%@%@",@"网点地址: ", commonItem.brchAddress];
        }else
        {
            receiverInfoTitleTextView.text=@"收货人信息";
            ////周小五
            receiverNameTextView.text=[NSString stringWithFormat:@"%@%@",@"姓名: ",  commonItem.recvName];
            ////158444399
            receiverPhoneTextView.text=[NSString stringWithFormat:@"%@%@",@"手机号: ", commonItem.mobileNo];
            ////广州市
            receiverAddressTextView.text=[NSString stringWithFormat:@"%@%@",@"地址: ", commonItem.detailAddress] ;
            
        }
        
        
        
        
        
        ////发票信息
        //[invoiceInfoTextView setValue:]
        ////个人发票
        invoiceTypeTextView.text=[NSString stringWithFormat:@"[%@]",commonItem.invoiceType ] ;
        ////李四
        invoiceUserNameTextView.text=commonItem.invoiceTitle;
        ////营销员号
        //[salerNoTitleTextView setValue:]
        ////3443
        //[salerNoValueTextView setValue:]
        
        
        
//        /* 子订单数量 备注:循环域开始*/
//        commonItem.subOrderNum=[[returnDataBody objectForKey:@"subOrderNum"] intValue];
//        for (int i=0; i<commonItem.subOrderNum; i++) {
//            
//              RespondParam0041 *commonItem1=[[RespondParam0041 alloc]init];
//       
//        /* 子订单号 备注:*/
//        commonItem1.subOrderNo1=[returnDataBody objectForKey:@"subOrderNo1"][i];
//        /* 子订单状态 备注:*/
//        commonItem1.subOrderStatus=[returnDataBody objectForKey:@"subOrderStatus"][i];
//        /* 子订单总金额 备注:*/
//        commonItem1.subOrderAmt=[[returnDataBody objectForKey:@"subOrderAmt"][i] floatValue];
//        /* 商品总金额 备注:*/
//        commonItem1.subMerchAmt=[[returnDataBody objectForKey:@"subMerchAmt"][i] floatValue];
//        /* 配送费用 备注:*/
//        commonItem1.subShipFee=[[returnDataBody objectForKey:@"subShipFee"][i] floatValue];
//        /* 子订单数量 备注:循环域结束*/
//        // commonItem.subOrderNum=[[returnDataBody objectForKey:@"subOrderNum"] intValue];
//         }
//        
        
        
        
        /* 子订单号 备注:*/
         commonItem.subOrderLogNum=[[returnDataBody objectForKey:@"subOrderLogNum"] intValue];
        
       
         for (int i=0; i<commonItem.subOrderLogNum; i++) {
             
        RespondParam0041 *commonItem2=[[RespondParam0041 alloc]init];
        commonItem2.subOrderNo2=[returnDataBody objectForKey:@"subOrderNo2"];
        /* 处理时间 备注:yymmddhhmmss*/
        commonItem2.subdealTime=[returnDataBody objectForKey:@"subdealTime"][i];
        /* 处理类型 备注:*/
        commonItem2.subdealType=[returnDataBody objectForKey:@"subdealType"][i];
        /* 处理内容 备注:*/
        commonItem2.subdealContent=[returnDataBody objectForKey:@"subdealContent"][i];
        /* 处理人 备注:*/
        commonItem2.subdealPerson=[returnDataBody objectForKey:@"subdealPerson"][i];
         }
        
             
        
        commonItem.subOrderLogistNum=[[returnDataBody objectForKey:@"subOrderLogistNum"] intValue];
        
        
        for (int i=0; i<commonItem.subOrderLogistNum; i++) {
            
            RespondParam0041 *commonItem2=[[RespondParam0041 alloc]init];
        /* 子订单号 备注:*/
        commonItem2.subOrderNo3=[returnDataBody objectForKey:@"subOrderNo3"][i];
        /* 物流公司 备注:*/
        commonItem2.logistCompany=[returnDataBody objectForKey:@"logistCompany"][i];
        /* 物流单号 备注:yymmddhhmmss*/
        commonItem2.logistNum=[returnDataBody objectForKey:@"logistNum"][i];
        /* 处理时间 备注:yymmddhhmmss*/
        commonItem2.logistDealTime=[returnDataBody objectForKey:@"logistDealTime"][i];
            
        }
        
        
        
        commonItem.merchListNum=[[returnDataBody objectForKey:@"merchListNum"] intValue];
        
        productList=[[NSMutableArray alloc ] init];
        
        for (int i=0; i<commonItem.merchListNum; i++) {
            
              RespondParam0041 *commonItem2=[[RespondParam0041 alloc]init];
        /* 商品代号 备注:*/
        commonItem2.merchID=[returnDataBody objectForKey:@"merchID"][i];
        /* 图片ID 备注:*/
        commonItem2.merchPicID=[returnDataBody objectForKey:@"merchPicID"][i];
        /* 商品名称 备注:*/
        commonItem2.merchName=[returnDataBody objectForKey:@"merchName"][i];
        /* 商品规格 备注:*/
        commonItem2.normsType=[returnDataBody objectForKey:@"normsType"][i];
            commonItem2.normsName=[returnDataBody objectForKey:@"normsName"][i];
        /* 模式单价 备注:*/
        commonItem2.normsPrice=[[returnDataBody objectForKey:@"normsPrice"][i] floatValue];
        /*个性化标志*/
        commonItem2.gxhBiaozhi=[[returnDataBody objectForKey:@"gxhBiaozhi"][i] intValue];
            
        /* 商品购买数量 备注:*/
        commonItem2.merchNum=[[returnDataBody objectForKey:@"merchNum"][i] intValue];
            [productList addObject:commonItem2];
            
         }
        
        
        
        
        
        commonItem.logisticsNum=[[returnDataBody objectForKey:@"logisticsNum"] intValue];
        
        
        for (int i=0; i<commonItem.logisticsNum; i++) {
            
            RespondParam0041 *commonItem2=[[RespondParam0041 alloc]init];
            
             commonItem2.source=[returnDataBody objectForKey:@"source"][i];
             commonItem2.acceptTime=[returnDataBody objectForKey:@"acceptTime"][i];
             commonItem2.acceptAddr=[returnDataBody objectForKey:@"acceptAddr"][i];
             commonItem2.remark=[returnDataBody objectForKey:@"remark"][i];
            
        }
        
        [self setUI:productList orderForm:commonItem];
        
    }
    
    
    
    /*订单取消0042*/
    if ([msgReturn.formName isEqualToString:n0042]){
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnBody=[returnData objectForKey:@"returnBody"];
        ProductOrderForm *orderForm=[ProductOrderForm sharedInstance ];
        orderForm.deleteOrderForm=true;
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
       
        
        msgReturn.errorCode=@"-99";//不能为空
        msgReturn.errorDesc=@"订单取消成功";
        msgReturn.errorType=@"01";
        
            [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self request0041];
                });
            
            } ];
        
    
      
    
    }
    
    
    /*收货确认0043*/
    if ([msgReturn.formName isEqualToString:n0043]){
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnBody=[returnData objectForKey:@"returnBody"];
        
    }
    
    
}



-(void) buttonView:(NSMutableArray*)operationTypes
{
    
    [self.gotoPayButton setHidden:YES];
    [self.cancelBtn setHidden:YES];
    [self.reportBtn setHidden:YES];
    [self.wuliuBtn setHidden:YES];
    [self.checkResult setHidden:YES];
    [self.diymodel setHidden:YES];
    [self.changeProduct setHidden:YES];
    
    int count =0;
    
    if ([operationTypes containsObject:@"01"]) {
        count =[operationTypes count] -1;
    }
    else
    {
        count =[operationTypes count];
    }
    
    int width=self.bottomView.frame.size.width-10;
    int height=self.bottomView.frame.size.height;
    int buttonLength = 0;
    
    if (count!=0) {
        buttonLength=width/count;
    }
    else
    {
        buttonLength=width/4;
    }

    int i=0;
    
    for (NSString *type in operationTypes) {
        
        
        
        //            如果 操作类型为“01 支付”，则显示支付按钮；
        //            如果 操作类型为“02 取消”，则显示取消按钮；
        //            如果 操作类型为“03 投诉”，则显示投诉按钮；
        //            如果 操作类型为“04 物流”，则显示物流按钮；
        //05 "审核结果"
        //06  "定制预览"
        //07 换货
        //08 补款
        
        
        
        
        if ([type isEqualToString:@"01"]) {
            [self.gotoPayButton setHidden:NO];
//            [self.gotoPayButton setFrame:CGRectMake(i*buttonLength, 0, buttonLength-1, height)];
            [self.gotoPayButton setTitle:@"订单支付" forState:UIControlStateNormal] ;
            [self.gotoPayButton setTitle:@"订单支付" forState:UIControlStateSelected] ;
            self.gotoPayButton.tag=1;
            continue;
        }
        
        
        if ([type isEqualToString:@"08"]) {
            [self.gotoPayButton setHidden:NO];
            [self.gotoPayButton setTitle:@"订单补款" forState:UIControlStateNormal] ;
             [self.gotoPayButton setTitle:@"订单补款" forState:UIControlStateSelected] ;
             self.gotoPayButton.tag=8;
            
            //            [self.gotoPayButton setFrame:CGRectMake(i*buttonLength, 0, buttonLength-1, height)];
            continue;
        }
        
        
        
        if ([type isEqualToString:@"02"]) {
            [self.cancelBtn setHidden:NO];
            [self.cancelBtn setFrame:CGRectMake(i*buttonLength, 0, buttonLength-2, height)];
            [self.bottomView addSubview:self.cancelBtn];
        }
        
        if ([type isEqualToString:@"03"]) {
            [self.reportBtn setHidden:NO];
             [self.reportBtn setFrame:CGRectMake(i*buttonLength, 0, buttonLength-2, height)];
            [self.bottomView addSubview:self.reportBtn];
        }
        
        if ([type isEqualToString:@"04"]) {
            [self.wuliuBtn setHidden:NO];
             [self.wuliuBtn setFrame:CGRectMake(i*buttonLength, 0, buttonLength-2, height)];
            [self.bottomView addSubview:self.wuliuBtn];
        }
        
        
        if ([type isEqualToString:@"05"]) {
            [self.checkResult setHidden:NO];
             [self.checkResult setFrame:CGRectMake(i*buttonLength, 0, buttonLength-2, height)];
            [self.bottomView addSubview:self.checkResult];
        }
        
        
        if ([type isEqualToString:@"06"]) {
            [self.diymodel setHidden:NO];
             [self.diymodel setFrame:CGRectMake(i*buttonLength, 0, buttonLength-2, height)];
            [self.bottomView addSubview:self.diymodel];
        }
        
        
        if ([type isEqualToString:@"07"]) {
            [self.changeProduct setHidden:NO];
            [self.changeProduct setFrame:CGRectMake(i*buttonLength, 0, buttonLength-2, height)];
            [self.bottomView addSubview:self.changeProduct];
        }
        
        
        i++;

    }
    
   
    
    
}


-(void) setUI:(NSMutableArray*) products  orderForm:(RespondParam0041*)orderForm
{

    int x=self.productView.frame.origin.x;
    int width=self.productView.frame.size.width;
    
    
    
//    //配送地址
//    [self.deliverWayAddressTextView setNumberOfLines:0];
//    self.deliverWayAddressTextView .lineBreakMode = NSLineBreakByWordWrapping;
//    
//    CGSize size = [ self.deliverWayAddressTextView sizeThatFits:CGSizeMake(self.deliverWayAddressTextView .frame.size.width, MAXFLOAT)];
//    
//    
//    [self.deliverWayAddressTextView setFrame:CGRectMake(self.deliverWayAddressTextView.frame.origin.x
//                                                  , self.deliverWayAddressTextView.frame.origin.y
//                                                  , self.deliverWayAddressTextView.frame.size.width
//                                                  ,size.height)];
//    
//    
//     [self.addressView setFrame:CGRectMake(x, self.addressView.frame.origin.y, width, self.addressView.frame.size.height+size.height)
//      ];
//    
//    
//    
//    
//    //收件人
//    [self.receiverHeadView setFrame:CGRectMake(x, self.addressView.frame.origin.y+self.addressView.frame.size.height, width, self.receiverHeadView.frame.size.height)
//     ];
//
//    
//    //
    
    [self.receiverAddressTextView setNumberOfLines:0];
    self.receiverAddressTextView .lineBreakMode = NSLineBreakByWordWrapping;
    
    CGSize size2 = [ self.receiverAddressTextView sizeThatFits:CGSizeMake(self.receiverAddressTextView .frame.size.width, MAXFLOAT)];
    
    
    [self.receiverAddressTextView setFrame:CGRectMake(self.receiverAddressTextView.frame.origin.x
                                                        , self.receiverAddressTextView.frame.origin.y
                                                        , self.receiverAddressTextView.frame.size.width
                                                        ,size2.height)];

    [self.receiverView setFrame:CGRectMake(self.receiverView.frame.origin.x
                                           , self.receiverView.frame.origin.y
                                           , self.receiverView.frame.size.width
                                           , self.receiverAddressTextView.frame.origin.y+self.receiverAddressTextView.frame.size.height+5)
     ];
    
    [self.productView setFrame:CGRectMake(self.productView.frame.origin.x
                                         , self.receiverView.frame.origin.y+self.receiverView.frame.size.height+6
                                         , self.productView.frame.size.width,
                                          self.productView.frame.size.height)];
    

    int y=   self.productView.frame.origin.y+15;
    int height=0;
    
    float mini=0;

    
    int proucductcount=0;
    //Prouct
    for (RespondParam0041 *product in products) {
        mini+=product.merchNum*product.normsPrice;
        
        OrderFormListProductCell *productItemLinearLayout = [[[NSBundle mainBundle] loadNibNamed:@"OrderFormListProductCell"  owner:self options:nil] lastObject];
        
//        if (proucductcount%2==0) {
//            [productItemLinearLayout.contentView setBackgroundColor:[UIColor whiteColor]];
//            
//        }
      //  proucductcount++;
        
         [productItemLinearLayout.productPicImageView setImageWithURL: [NSURL URLWithString:product.merchPicID] placeholderImage:[UIImage imageNamed:@"productpic.png"]];
        
        //数量
        [productItemLinearLayout.productNumTextView setText:[NSString stringWithFormat:@"%@%d",@"x", product.merchNum ]];
        
        //规格
        [productItemLinearLayout.productStypeTextView setText:product.normsName];
        //价格
        [productItemLinearLayout.productPriceTextView setText:[NSString stringWithFormat:@"%@%.2f",@"￥", product.normsPrice ]];
        
        //产品名字
        [productItemLinearLayout.productNameTextView setText:product.merchName];
        
        //start换行高度
        [productItemLinearLayout.productNameTextView setNumberOfLines:0];
        productItemLinearLayout.productNameTextView.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize   sizeproductNameTextView = [ productItemLinearLayout.productNameTextView  sizeThatFits:CGSizeMake(productItemLinearLayout.productNameTextView.frame.size.width, MAXFLOAT)];
        
        //名字
        [productItemLinearLayout.productNameTextView setFrame:CGRectMake(productItemLinearLayout.productNameTextView.frame.origin.x
                                                                         , productItemLinearLayout.productNameTextView.frame.origin.y, productItemLinearLayout.productNameTextView.frame.size.width, sizeproductNameTextView.height)];
        //end换行高度
        
        //规格
        [ productItemLinearLayout.productStypeTextView setFrame:CGRectMake(
                                                                           productItemLinearLayout.productNameTextView.frame.origin.x,
                                                                           productItemLinearLayout.productNameTextView.frame.origin.y+productItemLinearLayout.productNameTextView.frame.size.height+10,
                                                                           productItemLinearLayout.productStypeTextView.frame.size.width,
                                                                           productItemLinearLayout.productStypeTextView.frame.size.height)];
        
        //数量
        [ productItemLinearLayout.productNumTextView setFrame:CGRectMake(
                                                                         productItemLinearLayout.productNumTextView.frame.origin.x,
                                                                         productItemLinearLayout.productNameTextView.frame.origin.y+productItemLinearLayout.productNameTextView.frame.size.height+10,
                                                                         productItemLinearLayout.productNumTextView.frame.size.width,
                                                                         productItemLinearLayout.productNumTextView.frame.size.height)];
        
        //产品
        [productItemLinearLayout setFrame:CGRectMake(x, y+height, width, productItemLinearLayout.productNameTextView.frame.size.height+productItemLinearLayout.productStypeTextView.frame.size.height+40)];
        
        
        height+=productItemLinearLayout.frame.size.height;
        [self.scrollview addSubview:productItemLinearLayout];
        
        
        
    }
    
    
    //店铺名字
    OrderFormListBottomCell *partBottomLinearLayout = [[[NSBundle mainBundle] loadNibNamed:@"OrderFormListBottomCell"  owner:self options:nil] lastObject];
    
    [partBottomLinearLayout setFrame:CGRectMake(x, y+height, width, partBottomLinearLayout.frame.size.height)];
    height+=partBottomLinearLayout.frame.size.height;
    [self.scrollview addSubview:partBottomLinearLayout];
    

    
    //时间
    [partBottomLinearLayout.orderFormTimeTextView setText:@""];
    
    //广东邮政公司
    [partBottomLinearLayout.shopNameTextView setText:orderForm.sellerName];

    
    
    
    
    
    
    
    //self.miniTotalValue.text=[NSString stringWithFormat:@"￥%.2f",mini];
    
   // [self.miniTotal setFrame:CGRectMake(x, y+height-1, width, self.miniTotal.frame.size.height)];
   //  height+=self.miniTotal.frame.size.height+2;
    
    
    //发票
   [ self.invoiceView setFrame:CGRectMake(x
                                         , y+height
                                         , width
                                         , self.invoiceView.frame.size.height)];
    height+=self.invoiceView.frame.size.height;
    
  
    
    //留言
    UserMarkLinearLayoutScrollViewCell *userMarkLinearLayout = [[[NSBundle mainBundle] loadNibNamed:@"UserMarkLinearLayoutScrollViewCell"  owner:self options:nil] lastObject];
   
    
    //请尽快发货
    [userMarkLinearLayout.userMarkDetailTextView setText:orderForm.userRemark];
    
    //start换行高度
    [userMarkLinearLayout.userMarkDetailTextView setNumberOfLines:0];
    userMarkLinearLayout.userMarkDetailTextView.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize   sizeuserMarkDetailTextView = [ userMarkLinearLayout.userMarkDetailTextView  sizeThatFits:CGSizeMake(userMarkLinearLayout.userMarkDetailTextView.frame.size.width, MAXFLOAT)];
    [userMarkLinearLayout.userMarkDetailTextView setFrame:CGRectMake(userMarkLinearLayout.userMarkDetailTextView.frame.origin.x
                                                                     , userMarkLinearLayout.userMarkDetailTextView.frame.origin.y, userMarkLinearLayout.userMarkDetailTextView.frame.size.width, sizeuserMarkDetailTextView.height)];
    //end换行高度
    [userMarkLinearLayout setFrame:CGRectMake(x, y+height, width, userMarkLinearLayout.userMarkDetailTextView.frame.origin.y+userMarkLinearLayout.userMarkDetailTextView.frame.size.height+5)];
    height+=userMarkLinearLayout.frame.size.height;
    [self.scrollview addSubview:userMarkLinearLayout];
    
    
    
    
    //统计价钱
    CountMoneyLinearLayoutScrollViewCell *countMoneyLinearLayout = [[[NSBundle mainBundle] loadNibNamed:@"CountMoneyLinearLayoutScrollViewCell"  owner:self options:nil] lastObject];
    [countMoneyLinearLayout setFrame:CGRectMake(x, y+height, width, countMoneyLinearLayout.frame.size.height)];
    height+=countMoneyLinearLayout.frame.size.height;
    [self.scrollview addSubview:countMoneyLinearLayout];

    //10分  //获取积分
    [countMoneyLinearLayout.getIntegralValueTextView setText:[NSString stringWithFormat:@"%@分",orderForm.donatePoint]];
   
    
    //20分  //扣除积分
    [countMoneyLinearLayout.deleteIntegralValueTextView setText:[NSString stringWithFormat:@"%@分",orderForm.subtractionPoint]];
   
   
   
    //￥12     //+运费
    [countMoneyLinearLayout.deliverMoneyValueTextView setText:[NSString stringWithFormat:@"￥%.2f",orderForm.shipFee]];

   
    //￥143  //商品总额
    [countMoneyLinearLayout.prodctsMoneyValueTextView setText:[NSString stringWithFormat:@"￥%.2f",mini]];
   
    
    
    
    
    //实付金额
    TruePayLinearLayoutScrollViewCell *truePayLinearLayout = [[[NSBundle mainBundle] loadNibNamed:@"TruePayLinearLayoutScrollViewCell"  owner:self options:nil] lastObject];
    [truePayLinearLayout setFrame:CGRectMake(x, y+height, width, truePayLinearLayout.frame.size.height)];
    height+=truePayLinearLayout.frame.size.height;
    [self.scrollview addSubview:truePayLinearLayout];
    
    
    
    //2015年08月
    [truePayLinearLayout.orderFromTimeValueTextView setText:[DateConvert convertDateFromString: orderForm.bookDate]];
    //下单时间
    
   
    //￥200
    [truePayLinearLayout.truePayValueTextView setText:[NSString stringWithFormat:@"￥%.2f",orderForm.orderAmt]];
    //实付款
  
    
    
    
//    //scrollView
//    self.bg1447658686088ScrollView.contentSize=CGSizeMake(width, height);
//    
//    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
//    self.bg1447658686088ScrollView.contentInset = contentInsets;
//    self.bg1447658686088ScrollView.scrollIndicatorInsets = contentInsets;
//    
//    [self.bg1447658686088ScrollView setFrame:CGRectMake(0, self.head.frame.size.height, self.bg1447658686088ScrollView.frame.size.width, self.view.frame.size.height-self.head.frame.size.height-self.bottom.frame.size.height)];

    
    
    //按钮组
    [ self.bottomView setFrame:CGRectMake(self.bottomView.frame.origin.x
                                          , y+height
                                          , width
                                          , self.bottomView.frame.size.height)];
    height+=self.bottomView.frame.size.height;
    
    
    [self.scrollview setFrame:CGRectMake(0, self.headView.frame.origin.y+self.headView.frame.size.height, width, self.view.frame.size.height-self.headView.frame.size.height)];
    
    self.scrollview.contentSize=CGSizeMake(width, self.bottomView.frame.origin.y+self.bottomView.frame.size.height + 20);
}


@end



