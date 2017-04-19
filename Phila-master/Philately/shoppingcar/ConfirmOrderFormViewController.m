//注入网络请求,响应,等待提示



#import "ConfirmOrderFormViewController.h"
#import "UIImageView+WebCache.h"
#import <Foundation/Foundation.h>
#import <PublicFramework/JSONKit.h>
#import "RespondParam0037.h"
#import "RespondParam0038.h"
#import "ProductOrderForm.h"
#import "ConfirmOrderFormCell1.h"
#import "ConfirmOrderFormCell2.h"
#import "ConfirmOrderFormCell3.h"
#import <objc/runtime.h>
#import "DropDownConfirmOrderForm.h"
#import "RespondParam0053.h"
#import "ConfirmOrderFormCell4.h"
#import "ConfirmOrderFormCell41.h"
#import "OrderFormPayViewController.h"
#import "PickUpByMyselfAddressViewController.h"
#import "ProductOrderForm.h"
#import "SqlApp.h"
#import "ReceiverAddressManageViewController.h"
#import "ConfirmOrderFormCellVeridate.h"
#import "ConfirmOderFormAddressTableViewCell.h"
#import "CstmMsg.h"
#import "Device.h"
#import "ConfirmOrderFormUserMarkCell.h"
@implementation ConfirmOrderFormViewController

NSMutableArray *orderForms;
CGRect activeFieldRect;


//productlist
@synthesize productlistImageView;
//商品列表
@synthesize productlistTitleTextView;
//back
@synthesize backImageView;
//确认订单
@synthesize titleTextView;

//寄递
@synthesize receiverWayTitleTextView;
//right
@synthesize rightButton;
////营销员号:
//@synthesize salerNoTitleTextView;
////请输入营销员号
//@synthesize salerNoValueEditText;
////验证码:
//@synthesize codeTitleTextView;
////请输入验证码
//@synthesize codeValueEditText;
////获取验证码
//@synthesize getCodeButton;
//合计:
@synthesize totalTitleTextView;
//¥170
@synthesize totalValueTextView;
//提交订单
@synthesize submitOrderFromTextView;


NSString *busiNo;


NSString *confirm_receiverName;
NSString *confirm_receiverPhone;
NSString *confirm_receiverAddress;
NSString *confirm_cityCode;
NSString *confirm_streemCode;
NSString *confirm_proCode;
NSString *confirm_addressID;
NSString *confirm_postCode;

NSString *needVerification;
NSString *canPost;
UITextField *verificationCodeTxtFeile;
UITextField *salerNoValueTxtFeile;
 NSMutableArray *views;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
   views =[[NSMutableArray alloc] init ];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handTap)];
    [self.backImageView addGestureRecognizer:tap];
    
    
    
    
    [self.submitOrderFromTextView addTarget:self action:@selector(submitOrderFromTextViewClick:) forControlEvents:UIControlEventTouchUpInside];

    
    self.title=@"ConfirmOrderFormViewController";
    
    
 
    
   
    
    [self  request0037];
    
    
    ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
 
    
    //配送地址相关
    confirm_receiverName=[productOrderForm.shoppingCar objectForKey:@"receiverName" ];
    
    confirm_receiverPhone=[productOrderForm.shoppingCar objectForKey:@"receiverPhone" ];
    
    
    confirm_cityCode= [productOrderForm.shoppingCar objectForKey:@"cityCode"];
    
    confirm_streemCode=[productOrderForm.shoppingCar objectForKey:@"streemCode"];
    
    confirm_proCode=[productOrderForm.shoppingCar objectForKey:@"proCode"];
    
    confirm_addressID=[productOrderForm.shoppingCar objectForKey:@"addressID"];
    
    
    confirm_receiverAddress=[productOrderForm.shoppingCar objectForKey:@"receiverAddress" ];
 
    
    confirm_postCode=[productOrderForm.shoppingCar objectForKey:@"postCode"];
    
    needVerification=[productOrderForm.shoppingCar objectForKey:@"needVerification"];
    canPost=[productOrderForm.shoppingCar objectForKey:@"canPost"];
    
    
 
 
 
    UITapGestureRecognizer* closeKeyboardtap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKeyboard)];
    [self.scroll addGestureRecognizer:closeKeyboardtap];
    
    
}

-(void)closeKeyboard
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}






//获取验证码
-(void) getCodeButtonClick:(UIButton*)btn
{
    
    [verificationCodeTxtFeile setEnabled:YES];
    [self request0053];
}

-(void)handTap{
//    [self presentViewController:updatePwdViewController animated:NO completion:^{}];
[self dismissViewControllerAnimated:NO completion:^(){}];
    [self.navigationController popViewControllerAnimated:NO];
    
    if (views!=nil ) {
        
    
    for (UIView *view in views) {
        [view removeFromSuperview];
    }
    [views removeAllObjects];
    }
    
    
    
    ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
    
    if (productOrderForm.shoppingCar!=nil ) {
         [productOrderForm.shoppingCar removeAllObjects];
    }
   
    
    if (orderForms!=nil ) {
          [orderForms removeAllObjects];
    }
  
   
    
};



-(void) viewWillAppear:(BOOL)animated{
    
    ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
    
    
    //配送地址相关
    confirm_receiverName=[productOrderForm.shoppingCar objectForKey:@"receiverName" ];
    
    confirm_receiverPhone=[productOrderForm.shoppingCar objectForKey:@"receiverPhone" ];
    
    
    confirm_cityCode= [productOrderForm.shoppingCar objectForKey:@"cityCode"];
    
    confirm_streemCode=[productOrderForm.shoppingCar objectForKey:@"streemCode"];
    
    confirm_proCode=[productOrderForm.shoppingCar objectForKey:@"proCode"];
    confirm_addressID=[productOrderForm.shoppingCar objectForKey:@"addressID"];
    
    confirm_receiverAddress=[productOrderForm.shoppingCar objectForKey:@"receiverAddress" ];
    
    
    confirm_postCode=[productOrderForm.shoppingCar objectForKey:@"postCode"];
    
    needVerification=[productOrderForm.shoppingCar objectForKey:@"needVerification"];
    canPost=[productOrderForm.shoppingCar objectForKey:@"canPost"];
    
    
//    if (orderForms!=nil && [orderForms count]>0) {
//        //自提地址
//        ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
//        
//        OrderForm *form=orderForms[productOrderForm.orderFormIndex];
//        form.pickupId =productOrderForm.pickupId;
//        form.pickupAddress= productOrderForm.pickupAddress;
//        [self orderFormList:orderForms];
//    }
    
    if (productOrderForm.selectAddresss==true) {
        
         [self  request0037];
        productOrderForm.selectAddresss=false;
        
    }else
    {
    
    
    if (orderForms!=nil && [orderForms count]>0) {
     [self orderFormList:orderForms];
    }
    }
    [self registerForKeyboardNotifications];
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


-(void) setUiValue{
    
}





/*订单预处理0037*/
NSString  *n0037=@"JY0037";
/*订单预处理0037*/
-(void) request0037{
    salerNo=@"";
    phoneVerifyNo=@"";
    
    CstmMsg *_cstMsg=[CstmMsg sharedInstance];
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
    
    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 会员编号 备注:必填*/
    [businessparam setValue:[productOrderForm.shoppingCar objectForKey:@"cstmNo"] forKey:@"cstmNo"];
    /* 业务代号 备注:必填*/
    busiNo=[productOrderForm.shoppingCar objectForKey:@"busiNo"];
    
    [businessparam setValue:[productOrderForm.shoppingCar objectForKey:@"busiNo"] forKey:@"busiNo"];
    /* 渠道代号 备注:必填*/
    [businessparam setValue:_sysBaseInfo.channelNo forKey:@"channelNo"];
    /* 默认地址编号 备注:必填*/
    [businessparam setValue:[productOrderForm.shoppingCar objectForKey:@"addressID"] forKey:@"addressID"];
    /* 区域代号 备注:必填*/
    [businessparam setValue:[productOrderForm.shoppingCar objectForKey:@"streemCode"] forKey:@"cityCode"];
    
   // mergeFlag	拆单标志	字符	1	必填	2015/8/21新增：
   // 0：拆单（默认值）
   // 1：合单
    
    [businessparam setValue:[NSString stringWithFormat:@"%d", productOrderForm.mergeFlag ] forKey:@"mergeFlag"];
    
//    sinceBrchNo	新邮自提机构代码	字符	10	必填	2015/8/30新增
//    saleBrchNo	零售自提机构代码	字符	10	必填	2015/8/30新增
    
     [businessparam setValue:_cstMsg.sinceBrchNo forKey:@"sinceBrchNo"];
     [businessparam setValue:_cstMsg.saleBrchNo forKey:@"saleBrchNo"];
    
    /* 结算商品数量 备注:必填*/
    [businessparam setValue:[productOrderForm.shoppingCar objectForKey:@"recordNum"] forKey:@"recordNum"];
    /* 购物车代号 备注:必填*/
    [businessparam setValue:[productOrderForm.shoppingCar objectForKey:@"shoppingCartID"] forKey:@"shoppingCartID"];
    /* 关联业务代号 备注:必填*/
    [businessparam setValue:[productOrderForm.shoppingCar objectForKey:@"busiNo"] forKey:@"linkBusiNo"];
    /* 商品代号 备注:必填*/
    [businessparam setValue:[productOrderForm.shoppingCar objectForKey:@"merchID"] forKey:@"merchID"];
    /* 商品名称 备注:必填*/
    [businessparam setValue:[productOrderForm.shoppingCar objectForKey:@"merchName"] forKey:@"merchName"];
    /* 商品规格 备注:必填*/
    [businessparam setValue:[productOrderForm.shoppingCar objectForKey:@"normsType"] forKey:@"normsType"];
    /* 购买价格 备注:必填*/
    [businessparam setValue:[productOrderForm.shoppingCar objectForKey:@"buyPrice"] forKey:@"buyPrice"];
    
      [businessparam setValue:[productOrderForm.shoppingCar objectForKey:@"buyNum"] forKey:@"buyNum"];
    
    
    
    
    
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstMsg formName:n0037 business:businessparam delegate:self viewController:self];
    
}




/*订单生成0038*/
NSString  *n0038=@"JY0038";
/*订单生成0038*/
-(void) request0038{
    
    
    if ( [needVerification isEqualToString:@"1"] )
    {
        if  (  !verificationCodeTxtFeile ||[verificationCodeTxtFeile.text isEqualToString:@""]) {
            
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
    
            msgReturn.errorCode=@"-999";//不能为空
        msgReturn.errorDesc=@"验证码为空";
        msgReturn.errorType=@"02";
            msgReturn.errorPic=true;
            [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        return;
        }
    }
    
    
    
    
    int orderFormCount=[orderForms count];
    
    CstmMsg *_cstMsg=[CstmMsg sharedInstance];
    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 下单数量 备注:*/
    [businessparam setValue:[NSString stringWithFormat:@"%d",orderFormCount] forKey:@"orderBookNum"];
    
    NSMutableArray *prepNumbers=[[NSMutableArray alloc] init];
     NSMutableArray *cstmNos=[[NSMutableArray alloc] init];
     NSMutableArray *busiNos=[[NSMutableArray alloc] init];
     NSMutableArray *shipTypes=[[NSMutableArray alloc] init];
     NSMutableArray *shipModes=[[NSMutableArray alloc] init];
     NSMutableArray *brchNos=[[NSMutableArray alloc] init];
     NSMutableArray *recvNames=[[NSMutableArray alloc] init];
     NSMutableArray *addressIDs=[[NSMutableArray alloc] init];
     NSMutableArray *provCodes=[[NSMutableArray alloc] init];
     NSMutableArray *cityCodes=[[NSMutableArray alloc] init];
     NSMutableArray *countCodes=[[NSMutableArray alloc] init];
     NSMutableArray *detailAddresss=[[NSMutableArray alloc] init];
     NSMutableArray *mobileNos=[[NSMutableArray alloc] init];
     NSMutableArray *postCodes=[[NSMutableArray alloc] init];
     NSMutableArray *shipFees=[[NSMutableArray alloc] init];
     NSMutableArray *orderAmts=[[NSMutableArray alloc] init];
     NSMutableArray *orderRemarks=[[NSMutableArray alloc] init];
     NSMutableArray *userRemarks=[[NSMutableArray alloc] init];
    NSMutableArray *invoiceTypes=[[NSMutableArray alloc] init];
    NSMutableArray *invoiceTitles=[[NSMutableArray alloc] init];
   
    
    for (int i=0; i<orderFormCount; i++) {
        
        OrderForm *form=orderForms[i];
        
        if(![DateConvert isCommonChar:form.userMark])
        {
            //[self.view makeToast:@"请输入用户名"];
            
            MsgReturn *msgReturn=[[MsgReturn alloc]init];
            
            
            msgReturn.errorDesc=@"留言含有非法字符，请修改";//不能为空
            msgReturn.errorType=@"01";
            msgReturn.errorCode=@"-0078";
            msgReturn.errorPic=true;
            [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
            return ;
        }
        
        if([form.userMark length]>50)
        {
            //[self.view makeToast:@"请输入用户名"];
            
            MsgReturn *msgReturn=[[MsgReturn alloc]init];
            
            
            msgReturn.errorDesc=@"留言超过50个字节，请修改";//不能为空
            msgReturn.errorType=@"01";
            msgReturn.errorCode=@"-0078";
            msgReturn.errorPic=true;
            [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
            return ;
        }


        
        if(![DateConvert isCommonChar:form.invoiceMsg])
        {
            //[self.view makeToast:@"请输入用户名"];
            
            MsgReturn *msgReturn=[[MsgReturn alloc]init];
            
            
            msgReturn.errorDesc=@"发票抬头含有非法字符，请修改";//不能为空
            msgReturn.errorType=@"01";
            msgReturn.errorCode=@"-0078";
            msgReturn.errorPic=true;
            [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
            return ;
        }
        
        
        
        [prepNumbers addObject:form.orderNo];
        if (_cstMsg.cstmNo==nil) {
            [cstmNos addObject:@""];
        }else
        {
        [cstmNos addObject:_cstMsg.cstmNo];
        }
        [busiNos addObject:form.busiNo];
        
     
        
        NSString *temptype=@"";
        NSString *temppickupid=nil;
        if ([form.deliverType isEqualToString:@"02"]) {//02自提
           // shiptype   shipmode
           // 02              99
            if([form.deliverWay[form.deliverWayWhich] isEqualToString:@"99"])
            {
           temptype=@"02";
            }
            
             temppickupid=form.pickupId;
        }else if([form.deliverType isEqualToString:@"01"])
        {//寄递
           // shiptype   shipmode
           // 01            01,02,03
          
            temptype=form.deliverType;
            temppickupid=@"";
            
        }else if([form.deliverType isEqualToString:@"03"])
        {//混合
            
           // shiptype   shipmode
           // 03          01,02,03,99 （订单生成上送：01,02,03-->01，99--->02）
            if([form.deliverWay[form.deliverWayWhich] isEqualToString:@"99"])
            {
                   temptype=@"02";
                temppickupid=form.pickupId;
            }else
            {
              temptype=@"01";
                temppickupid=@"";
            }
        
        }
        
        [shipTypes addObject:temptype ];
         [shipModes addObject:form.deliverWay[form.deliverWayWhich]];
        
     
             
        if (temppickupid==nil) {
            MsgReturn *msgReturn=[[MsgReturn alloc]init];
            
            msgReturn.errorCode=@"-999";//不能为空
            msgReturn.errorDesc=@"请选择自提网点";
            msgReturn.errorType=@"02";
            msgReturn.errorPic=true;
            [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
            return;
        }
        [brchNos addObject:temppickupid];
        
        [recvNames addObject:form.receiverName];
        [provCodes addObject:form.proCode];
        [addressIDs addObject:form.addressID];
        [cityCodes addObject:form.cityCode];
        [countCodes addObject:form.streemCode];
        [detailAddresss addObject:form.receiverAddress];
        [mobileNos addObject:form.receiverPhone];
        [postCodes addObject:form.postCode];

        [shipFees addObject:form.deliverWayPrice[form.deliverWayWhich]];
        
        
        float deliverPriceFloat=[form.deliverWayPrice[form.deliverWayWhich] floatValue];
        float orderPriceFloat=[form.orderPrice floatValue];
     
        
      
        [orderAmts addObject:[NSString stringWithFormat:@"%.2f",deliverPriceFloat+orderPriceFloat]];
        
     
        [invoiceTypes addObject:form.invoiceType];
        
        if (form.invoiceMsg==nil) {
            form.invoiceMsg=@"";
        }
        
        if([form.invoiceType isEqualToString:@"2"]  && [form.invoiceMsg isEqualToString:@""])
        {
        
            MsgReturn *msgReturn=[[MsgReturn alloc]init];
            
            msgReturn.errorCode=@"-999";//不能为空
            msgReturn.errorDesc=@"发票抬头不能为空";
            msgReturn.errorType=@"02";
            msgReturn.errorPic=true;
            [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
            return;

        }
        
        if (form.userMark==nil) {
            form.userMark=@"";
        }
        
        
        
        
        [invoiceTitles addObject:form.invoiceMsg];
        [orderRemarks addObject:@""];
        
        [userRemarks addObject:form.userMark];
        
    }
    /* 预处理单号 备注:必填*/
    [businessparam setValue:[NSString  stringWithFormat:@"%d",orderFormCount]  forKey:@"orderBookNum"];
    /* 预处理单号 备注:必填*/
    [businessparam setValue:prepNumbers forKey:@"prepNumber"];
    /* 会员编号 备注:必填*/
    [businessparam setValue:cstmNos forKey:@"cstmNo"];
    /* 业务代号 备注:必填*/
    [businessparam setValue:busiNos forKey:@"busiNo"];
    /* 配送方式 备注:必填*/
    [businessparam setValue:shipTypes forKey:@"shipType"];
    /* 配送模式 备注:*/
    [businessparam setValue:shipModes forKey:@"shipMode"];
    /* 自提网点代号 备注:必填*/
    [businessparam setValue:brchNos forKey:@"brchNo"];
    /* 收货人姓名 备注:必填*/
    [businessparam setValue:recvNames forKey:@"recvName"];
    [businessparam setValue:addressIDs forKey:@"addressId"];
    /* 省份代号 备注:必填*/
    [businessparam setValue:provCodes forKey:@"provCode"];
    /* 市代号 备注:必填*/
    [businessparam setValue:cityCodes forKey:@"cityCode"];
    /* 县代号 备注:必填*/
    [businessparam setValue:countCodes forKey:@"countCode"];
    /* 详细地址 备注:必填*/
    [businessparam setValue:detailAddresss forKey:@"detailAddress"];
    /* 收件手机号码 备注:必填*/
    [businessparam setValue:mobileNos forKey:@"mobileNo"];
    /* 邮编 备注:选填*/
    [businessparam setValue:postCodes forKey:@"postCode"];
    /* 配送费用 备注:必填*/
    [businessparam setValue:shipFees forKey:@"shipFee"];
    /* 订单总金额 备注:必填*/
    [businessparam setValue:orderAmts forKey:@"orderAmt"];
    /* 订单备注信息 备注:选填*/
    [businessparam setValue:orderRemarks forKey:@"orderRemark"];
    /* 发票开具类型 备注:必填*/
    [businessparam setValue:invoiceTypes forKey:@"invoiceType"];
    /* 发票抬头 备注:选填*/
    [businessparam setValue:invoiceTitles forKey:@"invoiceTitle"];
    
     [businessparam setValue:userRemarks forKey:@"userRemark"];





    /* 手机验证码 备注:必填*/
    [businessparam setValue:verificationCodeTxtFeile.text forKey:@"verificationCode"];
    /* 营业员联系方式 备注:选填*/
    NSString *salerno=@"";
    if(salerNoValueTxtFeile.text==nil)
    {
    }else
    {
        salerno=salerNoValueTxtFeile.text;
    }
    [businessparam setValue:salerno forKey:@"brchMobNum"];


    NSMutableArray *LinkprepNumbers=[[NSMutableArray alloc] init];
    NSMutableArray *shoppingCartIDs=[[NSMutableArray alloc] init];
    NSMutableArray *merchIDs=[[NSMutableArray alloc] init];
    NSMutableArray *normsTypes=[[NSMutableArray alloc] init];
     NSMutableArray *buyNums=[[NSMutableArray alloc] init];
    NSMutableArray *merchPrices=[[NSMutableArray alloc] init];
    NSMutableArray *buyPrices=[[NSMutableArray alloc] init];


    
    
    int productCount=0;
    for (OrderForm *form in orderForms) {
       productCount+=[form.products count];
        
        for (Product *product in form.products ) {
            
            [LinkprepNumbers addObject:form.orderNo];
            [shoppingCartIDs addObject:product.shoppingCartID];
            [merchIDs addObject:product.productId];
            [normsTypes addObject:product.normsType];
            [buyNums addObject:product.number];
            [merchPrices addObject:product.price];
            [buyPrices addObject:product.buyprice];
        }
    }
    
    
    /* 预受理单关联商品数量 备注:必填*/
    [businessparam setValue:[NSString stringWithFormat:@"%d",productCount] forKey:@"merchInfoNum"];
    
    /* 关联预受理单编号 备注:必填*/
    [businessparam setValue:LinkprepNumbers forKey:@"linkprepNumber"];
    /* 业务代号 备注:必填*/
    [businessparam setValue:shoppingCartIDs forKey:@"shoppingCartID"];
    /* 商品代号 备注:必填*/
    [businessparam setValue:merchIDs forKey:@"merchID"];
    /* 商品规格 备注:必填*/
    [businessparam setValue:normsTypes forKey:@"normsType"];
    /* 商品规格 备注:必填*/
    [businessparam setValue:buyNums forKey:@"buyNum"];
    /* 商品价格 备注:必填*/
    [businessparam setValue:merchPrices forKey:@"merchPrice"];
    /* 购买价格 备注:必填*/
    [businessparam setValue:buyPrices forKey:@"buyPrice"];
    /* 预受理单关联商品数量 备注:*/



    
    
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstMsg formName:n0038 business:businessparam delegate:self viewController:self];
}



/*手机验证码发送0053*/
NSString  *nnn0053=@"JY0053";
/*手机验证码发送0053*/
-(void) request0053{
     CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 手机号码 备注:必填*/
   
    if ([busiNo isEqualToString:@"66"])
    {
        if (_cstmMsg.verifiMobileNo==nil || [_cstmMsg.verifiMobileNo isEqualToString:@""]) {
            
      
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        msgReturn.errorCode=@"0001";//不能为空
        msgReturn.errorDesc=@"";
        msgReturn.errorType=@"02";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@"手机号码"  viewController:self block:^(BOOL OKCancel){} ];
        
            return;
          }
        
        
        if ([_cstmMsg.verifiMobileNo length]!=11 || [[_cstmMsg.verifiMobileNo substringWithRange:NSMakeRange(0, 1) ] intValue]!=1) {
            
            
            MsgReturn *msgReturn=[[MsgReturn alloc]init];
            msgReturn.errorCode=@"-1001";//不能为空
            msgReturn.errorDesc=@"验证码接收手机:格式不正确";
            msgReturn.errorType=@"02";
            msgReturn.errorPic=true;
            [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
            
            return;
        }
        
        [businessparam setValue:_cstmMsg.verifiMobileNo forKey:@"mobileNo"];
    }else
    {
        if (_cstmMsg.mobileNo==nil || [_cstmMsg.mobileNo isEqualToString:@""]) {
            
            
            MsgReturn *msgReturn=[[MsgReturn alloc]init];
            msgReturn.errorCode=@"0001";//不能为空
            msgReturn.errorDesc=@"";
            msgReturn.errorType=@"02";
            msgReturn.errorPic=true;
            [PromptError changeShowErrorMsg:msgReturn title:@"手机号码"  viewController:self block:^(BOOL OKCancel){} ];
            
            return;
        }
        
        
        if ([_cstmMsg.mobileNo length]!=11 || [[_cstmMsg.mobileNo substringWithRange:NSMakeRange(0, 1) ] intValue]!=1) {
            
            
            MsgReturn *msgReturn=[[MsgReturn alloc]init];
            msgReturn.errorCode=@"-1001";//不能为空
            msgReturn.errorDesc=@"验证码接收手机:格式不正确";
            msgReturn.errorType=@"02";
            msgReturn.errorPic=true;
            [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
            
            return;
        }
        [businessparam setValue:_cstmMsg.mobileNo forKey:@"mobileNo"];
    }
    
   
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:nnn0053 business:businessparam delegate:self viewController:self];
}


-(void) ReturnError:(MsgReturn*)msgReturn
{
    if ([msgReturn.formName isEqualToString:n0037]) {
        [self dismissViewControllerAnimated:NO completion:^(){}];
        [self.navigationController popViewControllerAnimated:NO];
    }

    
}

-(void) ReturnData:(MsgReturn*)msgReturn
{
    
    
    NSMutableArray *listData=[[NSMutableArray alloc]init];
    /*订单预处理0037*/
    if ([msgReturn.formName isEqualToString:n0037]){
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        RespondParam0037 *commonItem=[[RespondParam0037 alloc]init];
        /* 预受理单数量 备注:循环域开始*/
        commonItem.preOrderNum=[[returnDataBody objectForKey:@"preOrderNum"] intValue];
        
        //commonItem.busiNo=[returnDataBody objectForKey:@"busiNo"] ;
        
        orderForms=[[NSMutableArray alloc] init];
        
        
        for (int i=0; i<commonItem.preOrderNum; i++) {
            
            OrderForm *orderForm=[[OrderForm alloc ] init ];
            
            RespondParam0037 *commonItem1=[[RespondParam0037 alloc]init];
            /* 预处理单编号 备注:2015/6/17增加*/
            commonItem1.prepNumber=[returnDataBody objectForKey:@"prepNumber"][i];
           
            /* 业务代号 备注:2015/6/29增加*/
            commonItem1.busiNo=[returnDataBody objectForKey:@"busiNo"][i];
            /* 配送方式 备注:*/
            commonItem1.shipType=[returnDataBody objectForKey:@"shipType"][i];
            /* 预受理单金额 备注:2015/7/4新增*/
            commonItem1.prepPrice=[[returnDataBody objectForKey:@"prepPrice"][i] floatValue];
         
            //积分
              commonItem1.subtractionPoint=[[returnDataBody objectForKey:@"subtractionPoint"][i] floatValue];
            
             commonItem1.sinceProvComp=[returnDataBody objectForKey:@"sinceProvComp"][i] ;
//            sinceProvComp	自提省份代号组合	字符	500	2015/8/21新增：
//            1）	当配送方式为“02 自提”、“03 寄递+自提”时生效；
//            2）	空（""）表示全国各省都分配自提网点；
//            3）	非空表示特定省分配自提网点；多个省份以“,”隔开，如：110000,320000,310000
            
             commonItem1.sinceCityComp=[returnDataBody objectForKey:@"sinceCityComp"][i] ;
            
            
            orderForm.orderNo= commonItem1.prepNumber;
            orderForm.busiNo=commonItem1.busiNo;
            orderForm.deliverType=commonItem1.shipType;
            orderForm.orderPrice=[NSString stringWithFormat:@"%.2f",commonItem1.prepPrice ];
       
             orderForm.subtractionPoint=commonItem1.subtractionPoint ;
            
            
            orderForm.receiverName= confirm_receiverName;
            orderForm.receiverPhone= confirm_receiverPhone;
             orderForm.receiverAddress= confirm_receiverAddress;
             orderForm.cityCode= confirm_cityCode;
            orderForm.streemCode= confirm_streemCode;
             orderForm.proCode= confirm_proCode;
            orderForm.postCode=confirm_postCode;
            orderForm.sinceProvComp=commonItem1.sinceProvComp;
            orderForm.sinceCityComp=commonItem1.sinceCityComp;
            
            [orderForms addObject:orderForm];
        }
        
        
        
        
        
        /* 预受理单关联商品数量 备注:2015/6/17增加
         循环域开始*/
        commonItem.merchInfoNum=[[returnDataBody objectForKey:@"merchInfoNum"] intValue];
        /* 关联预受理单编号 备注:为了避免嵌套循环，通过预受理单关联对应的商品，一个预受理单可关联多个商品*/
        for (int i=0; i<commonItem.merchInfoNum; i++) {
            
            RespondParam0037 *commonItem1=[[RespondParam0037 alloc]init];
            
            commonItem1.LinkprepNumber1=[returnDataBody objectForKey:@"linkprepNumber1"][i];
            
            
            OrderForm *morderForm;
            for (OrderForm *orderForm in orderForms) {
                
                if ([orderForm.orderNo isEqualToString:commonItem1.LinkprepNumber1]) {
                    morderForm=orderForm;
                }
            }
            
            
            Product *product=[[Product alloc] init ];
            
            
            product.shoppingCartID=[returnDataBody objectForKey:@"shoppingCartID"][i];
            commonItem1.shoppingCartID=[returnDataBody objectForKey:@"shoppingCartID"][i];
            /* 商品代号 备注:*/
            commonItem1.merchID=[returnDataBody objectForKey:@"merchID"][i];
            product.productId=commonItem1.merchID;
            /* 商品名称 备注:2015/6/29增加*/
            commonItem1.merchName=[returnDataBody objectForKey:@"merchName"][i];
            product.name=commonItem1.merchName;
            /* 商品规格 备注:单张、四方连*/
            commonItem1.normsType=[returnDataBody objectForKey:@"normsType"][i];
             commonItem1.normsName=[returnDataBody objectForKey:@"normsName"][i];
            product.normsType=commonItem1.normsType;
            product.normsName=commonItem1.normsName;
            /* 商品价格 备注:*/
            commonItem1.merchPrice=[[returnDataBody objectForKey:@"merchPrice"][i]floatValue];
            
            /* 购买价格 备注:*/
            commonItem1.buyPrice=[[returnDataBody objectForKey:@"buyPrice"][i] floatValue];
            commonItem1.buyNum=[[returnDataBody objectForKey:@"buyNum"][i] intValue];
            
            product.price=[NSString stringWithFormat:@"%.2f",commonItem1.merchPrice ];
            
            product.buyprice=[NSString stringWithFormat:@"%.2f",commonItem1.buyPrice ];
             product.number=[NSString stringWithFormat:@"%d",commonItem1.buyNum ];
            product.busiNo=morderForm.busiNo;
            /* 预受理单关联商品数量 备注:2015/6/17增加
             循环域结束*/
            // commonItem.merchInfoNum=[returnDataBody objectForKey:@"merchInfoNum"];
            
            
            for (OrderForm *order in orderForms) {
                if ([order.orderNo isEqualToString:commonItem1.LinkprepNumber1]) {
                    if(order.products==nil)
                    {
                        order.products=[[NSMutableArray alloc] init];
                    }
                    
                    [order.products addObject:product];
                }
            }
            
        }
        
        /* 预受理单关联配送模式数量 备注:2015/6/17增加
         循环域开始*/
        commonItem.shipModeNum=[[returnDataBody objectForKey:@"shipModeNum"] intValue];
        /* 关联预受理单编号 备注:为了避免嵌套循环，通过预受理单关联对应的佩服模式，一个预受理单可关联配送模式*/
        for (int i=0; i<commonItem.shipModeNum; i++) {
            
            RespondParam0037 *commonItem1=[[RespondParam0037 alloc]init];
            commonItem1.LinkprepNumber2=[returnDataBody objectForKey:@"linkprepNumber2"][i];
            
            OrderForm *morderForm;
            for (OrderForm *orderForm in orderForms) {
                
                if ([orderForm.orderNo isEqualToString:commonItem1.LinkprepNumber2]) {
                    morderForm=orderForm;
                }
            }
            
            /* 配送模式 备注:01：EMS
             02：小包*/
            commonItem1.shipMode=[returnDataBody objectForKey:@"shipMode"][i];
             commonItem1.shipModeName=[returnDataBody objectForKey:@"shipModeName"][i];
            if(commonItem1.shipModeName==nil)
            {
            commonItem1.shipModeName=@"";
            }
            if (morderForm.deliverWay==nil) {
                morderForm.deliverWay=[[NSMutableArray alloc]init];
            }
            if (morderForm.deliverWayName==nil) {
                morderForm.deliverWayName=[[NSMutableArray alloc]init];
            }
            [morderForm.deliverWay addObject:commonItem1.shipMode];
            [morderForm.deliverWayName addObject:commonItem1.shipModeName];
            
            /* 配送费用 备注:*/
            commonItem1.shipFee=[[returnDataBody objectForKey:@"shipFee"][i]floatValue];
            
            if (morderForm.deliverWayPrice==nil) {
                morderForm.deliverWayPrice=[[NSMutableArray alloc]init];
            }
            [morderForm.deliverWayPrice addObject:[NSString stringWithFormat:@"%.2f",commonItem1.shipFee ]];
        
            morderForm.deliverWayWhich=0;
            
            /* 预受理单关联配送费用 备注:2015/6/17增加
             循环域结束*/

            
            
        }
        
        
        
        //ui
        [self orderFormList:orderForms];
        
    }
    
    
    
    
    // NSMutableArray *listData=[[NSMutableArray alloc]init];
    /*订单生成0038*/
    if ([msgReturn.formName isEqualToString:n0038]){
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        RespondParam0038 *commonItem=[[RespondParam0038 alloc]init];
        /* 订单数量 备注:循环域开始*/
        commonItem.orderNoNum=[[returnDataBody objectForKey:@"orderNoNum"] intValue];
        
        NSMutableArray *datas=[[NSMutableArray alloc] init ];
        for (int i=0; i<commonItem.orderNoNum; i++) {
            
            RespondParam0038 *commonItem1=[[RespondParam0038 alloc]init];
            /* 订单号 备注:*/
            commonItem1.orderNo=[returnDataBody objectForKey:@"orderNo"][i];
            /* 个性化订单号 备注:默认为空*/
            commonItem1.perOrderId=[returnDataBody objectForKey:@"perOrderId"][i];
            /* 订单总金额 备注:*/
            commonItem1.orderTotalAmount=[[returnDataBody objectForKey:@"orderTotalAmount"][i] floatValue];
            /* 运费 备注:*/
            commonItem1.freight=[[returnDataBody objectForKey:@"freight"][i] floatValue];
            /* 订单状态 备注:2015/6/27 新增：
             用于判断是否能发起支付*/
            commonItem1.orderStatus=[returnDataBody objectForKey:@"orderStatus"][i];
            /* 订单数量 备注:循环域结束*/
            //commonItem.orderNoNum=[returnDataBody objectForKey:@"orderNoNum"];
            [datas addObject:commonItem1];
                   }
        
        
        OrderFormPayViewController *orderFormPayViewController=[[OrderFormPayViewController alloc ] initWithNibName:@"OrderFormPayViewController" bundle:nil];
        
        orderFormPayViewController.orderForms=datas;
      
        
//        [self presentViewController:shoppingCarEmptyViewController animated:NO completion:^{
//            
//        }];
         self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:orderFormPayViewController animated:NO];
        
        
        
        if (views!=nil ) {
            
            
            for (UIView *view in views) {
                [view removeFromSuperview];
            }
            [views removeAllObjects];
        }
        
        
        
        ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
        
        if (productOrderForm.shoppingCar!=nil ) {
            [productOrderForm.shoppingCar removeAllObjects];
        }
        
        
        if (orderForms!=nil ) {
            [orderForms removeAllObjects];
        }

    }
    
    
    
    
    
    /*手机验证码发送0053*/
    if ([msgReturn.formName isEqualToString:nnn0053]){
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnBody=[returnData objectForKey:@"returnBody"];
        RespondParam0053 *commonItem=[[RespondParam0053 alloc]init];
        
        MsgReturn * msgReturn =[[MsgReturn alloc]init];
        msgReturn.errorCode=@"0024";
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){}];
    }
}


-(void )setAddress:(ConfirmOderFormAddressTableViewCell*)confirmOderFormAddressTableViewCell

{
    
    
    
    ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
    //张三
    confirmOderFormAddressTableViewCell.receiverValueTextView.text=[productOrderForm.shoppingCar objectForKey:@"receiverName" ];
    //13339489
    confirmOderFormAddressTableViewCell.receiverPhoneTextView.text=[productOrderForm.shoppingCar objectForKey:@"receiverPhone" ];
    
    
    //配送地址相关
    confirm_receiverName=[productOrderForm.shoppingCar objectForKey:@"receiverName" ];
    
    confirm_receiverPhone=[productOrderForm.shoppingCar objectForKey:@"receiverPhone" ];
    
    
    
    
    confirm_cityCode= [productOrderForm.shoppingCar objectForKey:@"cityCode"];
    
    confirm_streemCode=[productOrderForm.shoppingCar objectForKey:@"streemCode"];
    
    confirm_proCode=[productOrderForm.shoppingCar objectForKey:@"proCode"];
    
    confirm_addressID=[productOrderForm.shoppingCar objectForKey:@"addressID"];
    
    
    SqlApp *sql=[[SqlApp alloc ] init];
    NSString *proCn= [sql selectPM_REGION:confirm_proCode];
    NSString *cityCn= [sql selectPM_REGION:confirm_cityCode];
    NSString *stringCn= [sql selectPM_REGION:confirm_streemCode];
    NSString *addressfull=[NSString stringWithFormat:@"%@%@%@ %@",proCn,cityCn,stringCn,[productOrderForm.shoppingCar objectForKey:@"receiverAddress" ]];
    
    confirm_receiverAddress=[productOrderForm.shoppingCar objectForKey:@"receiverAddress" ];
    //广东省什么
    confirmOderFormAddressTableViewCell.receiverAddressTextView.text=addressfull;
    
    confirm_postCode=[productOrderForm.shoppingCar objectForKey:@"postCode"];
    
    needVerification=[productOrderForm.shoppingCar objectForKey:@"needVerification"];
    canPost=[productOrderForm.shoppingCar objectForKey:@"canPost"];
    
    
      for (OrderForm *form in orderForms) {
          
          
         form.receiverName=confirm_receiverName;
          form.addressID=confirm_addressID;
          form.proCode=confirm_proCode;
         form.cityCode=confirm_cityCode;
          form.streemCode=confirm_streemCode;
         form.receiverAddress=confirm_receiverAddress;
         form.receiverPhone=confirm_receiverPhone;
          form.postCode=confirm_postCode;

      }
    
    
}



float total=0;
-(void) orderFormList:(NSMutableArray*) orderForms
{

    for (UIView *view in views) {
            [view removeFromSuperview];
    }
    [views removeAllObjects];
    
    total=0;
   
    
    int height=0;
    int width=self.scroll.frame.size.width;
    int x=0;
    int y=0;
    
    float jifeng=0;
    
   ConfirmOderFormAddressTableViewCell *confirmOderFormAddressTableViewCell = [[[NSBundle mainBundle] loadNibNamed:@"ConfirmOderFormAddressTableViewCell" owner:self options:nil] lastObject];

    
    if([canPost isEqualToString:@"1"])
    {
        
        [confirmOderFormAddressTableViewCell setFrame:CGRectMake(0, 0, confirmOderFormAddressTableViewCell.frame.size.width, confirmOderFormAddressTableViewCell.frame.size.height)];
        
  
    }else
    {
    //寄递
    [confirmOderFormAddressTableViewCell setFrame:CGRectMake(0, 0, confirmOderFormAddressTableViewCell.frame.size.width, 0)];
    }
    
       [confirmOderFormAddressTableViewCell.addressBtn addTarget:self action:@selector(addressBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setAddress:confirmOderFormAddressTableViewCell];
    
        [self.scroll addSubview:confirmOderFormAddressTableViewCell];
      [views addObject:confirmOderFormAddressTableViewCell];
    height+=confirmOderFormAddressTableViewCell.frame.size.height;
    
    
    
    int i=0;
    for (OrderForm *orderForm in orderForms) {
        
        jifeng+=orderForm.subtractionPoint;
        
        //预受理单号 ui
        ConfirmOrderFormCell2    *cell2 = [[[NSBundle mainBundle] loadNibNamed:@"ConfirmOrderFormCell2" owner:self options:nil] lastObject];
        
        [cell2 setFrame:CGRectMake(x
                                   , y+height
                                   , width
                                   , cell2.frame.size.height)];
        height+=cell2.frame.size.height;
        
        [self.scroll addSubview:cell2];
        [views addObject:cell2];
        
        cell2.orderFormNoTextView.text=orderForm.orderNo;
        
        
        
        int productCount=0;
        for (Product *product in orderForm.products) {
          
            
            //邮票名 价格 数量
            ConfirmOrderFormCell1    *cell1 = [[[NSBundle mainBundle] loadNibNamed:@"ConfirmOrderFormCell1" owner:self options:nil] lastObject];
            
            if (productCount==0) {
                [cell1.line setHidden:true];
            }else
            {
                [cell1.line setHidden:NO];
            }
            productCount++;
            
          //  SqlApp *sql=[[SqlApp alloc] init];
           // NSString *normsTypeCn=[sql selectPM_ARRAYSERVICEByCode:@"MERCHNORMS" code:product.normsType];
            cell1.stype.text=product.normsName;
            
            cell1.productNameTextView.text=product.name;
        
            //start换行高度
            [cell1.productNameTextView setNumberOfLines:0];
            cell1.productNameTextView.lineBreakMode = NSLineBreakByWordWrapping;
            CGSize   sizeaaTextView = [ cell1.productNameTextView  sizeThatFits:CGSizeMake(cell1.productNameTextView.frame.size.width, MAXFLOAT)];
            [cell1.productNameTextView setFrame:CGRectMake(cell1.productNameTextView.frame.origin.x
                                                 , cell1.productNameTextView.frame.origin.y, cell1.productNameTextView.frame.size.width, sizeaaTextView.height)];
            //end换行高度
            
            cell1.productNumTextView.text=product.number;
            cell1.productPriceTextView.text=[NSString stringWithFormat:@"¥%@",product.price]  ;
            
            
            [cell1 setFrame:CGRectMake(x
                                       , y+height
                                       , width
                                       , cell1.productNameTextView.frame.size.height+20)];
          
            
            height+=cell1.frame.size.height;
            
            [self.scroll addSubview:cell1];
            [views addObject:cell1];
            
        }
        
       // if ([orderForm.deliverType isEqualToString:@"02"]) {
            //自提
           // ConfirmOrderFormCell41 *cell41 = [[[NSBundle mainBundle] loadNibNamed:@"ConfirmOrderFormCell41" owner:self options:nil] lastObject];
            //[cell41 setFrame:CGRectMake(x
                                    //   , y+height
                                     //  , width
                                      // , cell41.frame.size.height)];
            //height+=cell41.frame.size.height;
            //[self.scroll addSubview:cell41];
              //[views addObject:cell41];
            
            
            //自提
          
    //}else
        {
        
        //配送方式 价钱
          ConfirmOrderFormCell4  *cell4 = [[[NSBundle mainBundle] loadNibNamed:@"ConfirmOrderFormCell4" owner:self options:nil] lastObject];
       

            
            //part1
            [cell4.part1 setFrame:CGRectMake(0, 0, cell4.part1.frame.size.width, cell4.part1.frame.size.height)];
             NSString *cnDeliverWay=@"";
            NSString *deliverPrice=@"";
            if (orderForm.deliverWay==nil || [orderForm.deliverWay count]<1) {
                
            }else
            {
            
//            SqlApp *sql=   [[SqlApp alloc ] init ];
//             cnDeliverWay= [sql selectPM_ARRAYSERVICEByCode:@"SHIPMODE" code:orderForm.deliverWay[orderForm.deliverWayWhich]];
               deliverPrice=orderForm.deliverWayPrice[orderForm.deliverWayWhich];
                
                cnDeliverWay=  orderForm.deliverWayName[orderForm.deliverWayWhich];
            }
            
            
            
        [cell4.deliverWayValueTextView setTitle:cnDeliverWay forState:UIControlStateNormal] ;
       
            
            float  deliverPriceFloat=  [[deliverPrice stringByReplacingOccurrencesOfString:@"¥" withString:@""] floatValue];
            float  orderPriceFloat= [[orderForm.orderPrice stringByReplacingOccurrencesOfString:@"¥" withString:@""] floatValue];

            
             //part2
            if (([orderForm.deliverType isEqualToString:@"02"] ||[orderForm.deliverType isEqualToString:@"03"]) && [orderForm.deliverWay[orderForm.deliverWayWhich] isEqualToString:@"99"]) {//(自提  或 自提加寄递) 且 用户选择自提
                
                if ( [orderForm.busiNo isEqualToString:@"66"]) {//新邮预定
                    
                       CstmMsg *cst=[CstmMsg sharedInstance ];
                    if (cst.sinceBrchName!=nil && ![cst.sinceBrchName isEqualToString:@""]  && cst.sinceBrchAddress!=nil && ![cst.sinceBrchAddress isEqualToString:@""] ) {
                        cell4.pickupName.text=cst.sinceBrchName;
                        [cell4.pickupSelectBtn setHidden:YES];
                    }else
                    {
                    
                    }
                    
                }else
                    
                {
                    CstmMsg *cst=[CstmMsg sharedInstance ];
                    if (cst.saleBrchName!=nil && ![cst.saleBrchName isEqualToString:@""]  && cst.saleBrchAddress!=nil && ![cst.saleBrchAddress isEqualToString:@""]) {
                        cell4.pickupName.text=cst.saleBrchName;
                     
                    }else
                    {
                        
                    }
                
                }
                
                
                
                  [cell4.part2 setFrame:CGRectMake(0, cell4.part1.frame.size.height, cell4.part2.frame.size.width, cell4.part2.frame.size.height)];
            }else
            {
             [cell4.part2 setFrame:CGRectMake(0, cell4.part1.frame.size.height, cell4.part2.frame.size.width, 0)];
                
              
            }
        
          
            cell4.pickupSelectBtn.tag=i;
            [cell4.pickupSelectBtn addTarget:self action:@selector(pickupSelectBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            
            if( orderForm.pickupName==nil || [orderForm.pickupName isEqualToString:@""])
            {
                cell4.pickupName.text=@"请选择自提网点";
            }else
            {
                cell4.pickupName.text= orderForm.pickupName;
            }
          
        
            
          

            
            
            
        //part3
            [cell4.part3 setFrame:CGRectMake(0, cell4.part2.frame.origin.y
                                             +cell4.part2.frame.size.height,
                                             cell4.part3.frame.size.width, cell4.part3.frame.size.height)];
            
        cell4.deliverWayPriceValueTextView.text=[NSString stringWithFormat:@"¥%.2f",[deliverPrice floatValue]];
            
        cell4.minTotalValueTextView.text=[NSString stringWithFormat:@"¥%.2f",deliverPriceFloat+orderPriceFloat] ;
        
        total+= deliverPriceFloat+orderPriceFloat;
        
        
        
        objc_setAssociatedObject(cell4.deliverWayValueTextView, "deliverWayPriceValueTextView",cell4.deliverWayPriceValueTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            cell4.deliverWayValueTextView.tag=i;
        [cell4.deliverWayValueTextView addTarget:self action:@selector(deliverWayValueTextViewClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            
           int cell4Height= cell4.part1.frame.size.height+cell4.part2.frame.size.height+cell4.part3.frame.size.height;
            [cell4 setFrame:CGRectMake(x
                                       , y+height
                                       , width
                                       , cell4Height)];
            height+=cell4.frame.size.height;
            NSLog(@"%@",cell4);
            [self.scroll addSubview:cell4];
            [views addObject:cell4];
        }
        
      
        
        
        
        //发票
        ConfirmOrderFormCell3    *cell3 = [[[NSBundle mainBundle] loadNibNamed:@"ConfirmOrderFormCell3" owner:self options:nil] lastObject];
        
        if ([orderForm.invoiceCheck isEqualToString:@"1"]) {//选中
            
            [cell3 setFrame:CGRectMake(x
                                       , y+height
                                       , width
                                       , cell3.frame.size.height)];
            cell3.invoiceCheckButton.selected=true;
            cell3.invoiceCheckButtonCover.selected=true;
            
            if( [orderForm.invoiceType isEqualToString:@"0"])
            {//不开
               orderForm.invoiceType=@"1";//初始化 个人
            }
            
            
            
            
            
            if([orderForm.invoiceType isEqualToString:@"2"] )
            {//公司
                cell3.companyCheckButton.selected=true;
                cell3.companyCheckButtonCover.selected=true;
                cell3.personCheckButton.selected=false;
                  cell3.personCheckButtonCover.selected=false;
                cell3.invoiceHeadValueEditText.enabled=true;
                
                
                [cell3 setFrame:CGRectMake(x
                                           , y+height
                                           , width
                                           , cell3.part1.frame.size.height+cell3.part2.frame.size.height)];
            }else
            {//个人
                cell3.companyCheckButton.selected=false;
                 cell3.companyCheckButtonCover.selected=false;
                cell3.personCheckButton.selected=true;
                 cell3.personCheckButtonCover.selected=true;
                cell3.invoiceHeadValueEditText.enabled=false;
                
                [cell3 setFrame:CGRectMake(x
                                           , y+height
                                           , width
                                           , cell3.part1.frame.size.height+cell3.part2.frame.size.height-cell3.titleView.frame.size.height)];
                
            }
            
            
        }else
        {
            [cell3 setFrame:CGRectMake(x
                                       , y+height
                                       , width
                                       , cell3.part1.frame.size.height)];
             cell3.invoiceCheckButton.selected=false;
            cell3.invoiceCheckButtonCover.selected=false;
            //没选中 不开
             orderForm.invoiceType=@"0";
        }
        
        

        NSLog(@"%@",cell3);
        
      
        
      
           objc_setAssociatedObject(cell3.invoiceCheckButton, "orderFormIndex",[NSNumber numberWithInt:i], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [cell3.invoiceCheckButton addTarget:self action:@selector(invoiceCheckButtonClicked:) forControlEvents:UIControlEventTouchDown];
        [cell3.invoiceCheckButtonCover  setBackgroundImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        [cell3.invoiceCheckButtonCover  setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateSelected];
        
     
       
    
        
   
        
        height+=cell3.frame.size.height+1;
        [self.scroll addSubview:cell3];
        [views addObject:cell3];
    
        //个人
        objc_setAssociatedObject(cell3.personCheckButton, "orderFormIndex",[NSNumber numberWithInt:i], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
         objc_setAssociatedObject(cell3.personCheckButton, "otherCheckButton",cell3.companyCheckButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
         objc_setAssociatedObject(cell3.personCheckButton, "invoicehead",cell3.invoiceHeadValueEditText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [cell3.personCheckButton addTarget:self action:@selector(personCheckButtonClicked:) forControlEvents:UIControlEventTouchDown];
        
        [cell3.personCheckButtonCover  setBackgroundImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        [cell3.personCheckButtonCover  setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateSelected];
        
        
       
        //单位
     
        cell3.companyCheckButton.tag=i;
        objc_setAssociatedObject(cell3.companyCheckButton, "otherCheckButton",cell3.personCheckButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
          objc_setAssociatedObject(cell3.companyCheckButton, "invoicehead",cell3.invoiceHeadValueEditText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [cell3.companyCheckButton addTarget:self action:@selector(companyCheckButtonClicked:) forControlEvents:UIControlEventTouchDown];
        
        [cell3.companyCheckButtonCover  setBackgroundImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        [cell3.companyCheckButtonCover  setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateSelected];
        
        //发票抬头
        
        cell3.invoiceHeadValueEditText.tag=i;
            [cell3.invoiceHeadValueEditText addTarget:self action:@selector(invoiceHeadValueEditTextDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
        
     
        [cell3.invoiceHeadValueEditText addTarget:self action:@selector(invoiceHeadValueEditTextDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
        
       
           objc_setAssociatedObject(cell3.invoiceHeadValueEditText, "parent",cell3, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
             [cell3.invoiceHeadValueEditText addTarget:self action:@selector(invoiceHeadValueEditTextDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
        
        cell3.invoiceHeadValueEditText.returnKeyType=UIReturnKeyDone;
        cell3.invoiceHeadValueEditText.text=orderForm.invoiceMsg;
        
        
        
        
        
        //留言
        ConfirmOrderFormUserMarkCell *confirmOrderFormUserMark = [[[NSBundle mainBundle] loadNibNamed:@"ConfirmOrderFormUserMarkCell"  owner:self options:nil] lastObject];
        
        [confirmOrderFormUserMark setFrame:CGRectMake(x, y+height, width, confirmOrderFormUserMark.frame.size.height)];
        height+=confirmOrderFormUserMark.frame.size.height;
        [self.scroll addSubview:confirmOrderFormUserMark];
        
        [views addObject:confirmOrderFormUserMark];
        
        
        confirmOrderFormUserMark.userMarkEditText.returnKeyType=UIReturnKeyDone;
    
        confirmOrderFormUserMark.userMarkEditText.tag=i;
        [confirmOrderFormUserMark.userMarkEditText addTarget:self action:@selector(userMarkEditTextDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
        
       
        [confirmOrderFormUserMark.userMarkEditText addTarget:self action:@selector(userMarkEditTextDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
        
    
        objc_setAssociatedObject(confirmOrderFormUserMark.userMarkEditText, "parent",confirmOrderFormUserMark, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [confirmOrderFormUserMark.userMarkEditText addTarget:self action:@selector(userMarkValueEditTextDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
        
         confirmOrderFormUserMark.userMarkEditText.text=orderForm.userMark;
        
        
        i++;
    }
    
    
    
    
    //验证
     ConfirmOrderFormCellVeridate    *cellVeridate = [[[NSBundle mainBundle] loadNibNamed:@"ConfirmOrderFormCellVeridate" owner:self options:nil] lastObject];
    
    if ([needVerification isEqualToString:@"1"]) {//需要验证
        
         [cellVeridate setFrame:CGRectMake(x , y+height+10, width, cellVeridate.frame.size.height)];
    }else
    {
  
    [cellVeridate setFrame:CGRectMake(x , y+height+10, width, cellVeridate.salerNoValueEditText.frame.size.height+10)];
    }
    
    height+=cellVeridate.frame.size.height+1;
       [self.scroll addSubview:cellVeridate];
      [views addObject:cellVeridate];
    
    
    if ([busiNo isEqualToString:@"66"])
    {
            CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
      
        cellVeridate.verifyPhone.text=_cstmMsg.verifiMobileNo;
    }else
    {
            CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    
          cellVeridate.verifyPhone.text=_cstmMsg.mobileNo;
    }
    
    [cellVeridate.getCodeButton addTarget:self action:@selector(getCodeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
 
    
    objc_setAssociatedObject(cellVeridate.salerNoValueEditText, "parent",cellVeridate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSLog(@"%@",cellVeridate);
    
    
  
    //营销员号
      cellVeridate.salerNoValueEditText.keyboardType=UIKeyboardTypeNumberPad;
    [cellVeridate.salerNoValueEditText addTarget:self action:@selector(salerNoValueEditTextDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
     [cellVeridate.salerNoValueEditText addTarget:self action:@selector(salerNoValueEditTextDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    
     [cellVeridate.salerNoValueEditText addTarget:self action:@selector(salerNoValueEditTextDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    
    cellVeridate.salerNoValueEditText.returnKeyType=UIReturnKeyDone;
    
    cellVeridate.salerNoValueEditText.text=salerNo;
    
    salerNoValueTxtFeile=cellVeridate.salerNoValueEditText;
 
    
    //手机验证码
    objc_setAssociatedObject(cellVeridate.codeValueEditText, "parent",cellVeridate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    cellVeridate.codeValueEditText.text=phoneVerifyNo;
    verificationCodeTxtFeile=cellVeridate.codeValueEditText ;
    
    [cellVeridate.codeValueEditText addTarget:self action:@selector(codeValueEditTextDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
     [cellVeridate.codeValueEditText addTarget:self action:@selector(codeValueEditTextDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    
      [cellVeridate.codeValueEditText addTarget:self action:@selector(codeValueEditTextDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    cellVeridate.codeValueEditText.returnKeyType=UIReturnKeyDone;
  
    
    

  
    
 
    
  
    
    
    self.scroll.contentSize=CGSizeMake(width, height+10);
    
 
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scroll.contentInset = contentInsets;
    self.scroll.scrollIndicatorInsets = contentInsets;
    

    [self.scroll setFrame:CGRectMake(0, self.head1.frame.size.height, self.scroll.frame.size.width, self.view.frame.size.height-self.head1.frame.size.height-self.bottom2.frame.size.height)];
    
    

    //buttom2
    [self.bottom2 setFrame:CGRectMake(x, self.view.frame.size.height-self.bottom2.frame.size.height, width, self.bottom2.frame.size.height)];
 
    
    NSString* totalvalue = [NSString stringWithFormat:@"￥%.2f",total ];
    self.totalValueTextView.text=totalvalue;
    self.needFeng.text= [NSString stringWithFormat:@"%.0f分",jifeng ];
}


-(void)pickupSelectBtnClicked:(UIButton*)btn
{
  
    
    int i=btn.tag;
       OrderForm *orderform=orderForms[i];
    
    
    PickUpByMyselfAddressViewController *pickUpByMyselfAddressViewController=[[PickUpByMyselfAddressViewController alloc ] initWithNibName:@"PickUpByMyselfAddressViewController" bundle:nil];
    pickUpByMyselfAddressViewController.sinceProvComp=orderform.sinceProvComp;
    pickUpByMyselfAddressViewController.sinceCityComp=orderform.sinceCityComp;
    pickUpByMyselfAddressViewController.orderFormIndex=i;
    [pickUpByMyselfAddressViewController setProucts:orderform.products btn:btn delegate:self whichForm:i];
   
   [self presentViewController:pickUpByMyselfAddressViewController animated:NO completion:^{}];
    
}


//配送方式 下拉
DropDownConfirmOrderForm *dropDown1 ;

- (void)deliverWayValueTextViewClicked:(UIButton*)btn {
    
    int i=btn.tag;

    dropDown1 = [[DropDownConfirmOrderForm alloc]initWithNibName:@"DropDownViewController" bundle:nil];
            

            
    [self.view addSubview:dropDown1.view];
        
        
    [dropDown1 setParentView:btn   name:[NSString stringWithFormat:@"%d",i] delegate:self];
        
    OrderForm *form=orderForms[i];
    
    NSMutableArray *arr=[[NSMutableArray alloc] init ];
    int j=0;
    for(NSString *way in form.deliverWay ) {
         DropDownRowConfirm *r=[[DropDownRowConfirm alloc] init ];
        r.rowId=way;
       // SqlApp *sql=   [[SqlApp alloc ] init ];
       // NSString *cnway= [sql selectPM_ARRAYSERVICEByCode:@"SHIPMODE" code:way];
        NSString *cnprice=form.deliverWayPrice[j];
        r.rowMsg=[NSString stringWithFormat:@"%@",form.deliverWayName[j]];
        r.price=cnprice;
        [arr addObject:r];
        j++;
    }
    
        [dropDown1 setUiValue:arr];
}



//地址修改
-(void)addressBtnClick:(UIButton*)btn
{
    
    ReceiverAddressManageViewController *receiverAddressManageViewController=[[ReceiverAddressManageViewController alloc ] initWithNibName:@"ReceiverAddressManageViewController" bundle:nil];
    receiverAddressManageViewController.whereCome=@"ConfirmOrderFormViewController";
    
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:receiverAddressManageViewController animated:NO];
    
    
    
}


//销售员号
-(void)salerNoValueEditTextDidEnd:(UITextField*)txt
{
    [self.view becomeFirstResponder];
    salerNo=txt.text;
    
    
}

//销售员号
-(void)salerNoValueEditTextDidEndOnExit:(UITextField*)txt
{
    [self.view becomeFirstResponder];
    salerNo=txt.text;
    
    
}




//验证码
-(void)codeValueEditTextDidEndOnExit:(UITextField*)txt
{
    [self.view becomeFirstResponder];
    phoneVerifyNo=txt.text;
    
}

//验证码
-(void)codeValueEditTextDidEnd:(UITextField*)txt
{
    [self.view becomeFirstResponder];
     phoneVerifyNo=txt.text;
    
}


//订单生成
-(void)submitOrderFromTextViewClick:(UIButton*)btn
{
    
    [self request0038];
}


//键盘顶起
-(void)userMarkValueEditTextDidBegin:(UITextField*)textField
{
    // activeField = textField;
    
    UIView *parentView= objc_getAssociatedObject(textField, "parent");
    
    int truey=parentView.frame.origin.y+parentView.frame.size.height;
    CGRect txtRect=CGRectMake(textField.frame.origin.x
                              , truey
                              , textField.frame.size.width
                              , textField.frame.size.height);
    
    
    activeFieldRect = txtRect;
}

//键盘顶起
-(void)invoiceHeadValueEditTextDidBegin:(UITextField*)textField
{
// activeField = textField;
    
    UIView *parentView= objc_getAssociatedObject(textField, "parent");
    
    int truey=parentView.frame.origin.y+parentView.frame.size.height;
    CGRect txtRect=CGRectMake(textField.frame.origin.x
                              , truey
                              , textField.frame.size.width
                              , textField.frame.size.height);
    
    
    activeFieldRect = txtRect;
}

//键盘顶起
-(void)codeValueEditTextDidBegin:(UITextField *)textField{
    //activeField = textField;
    
    UIView *parentView= objc_getAssociatedObject(textField, "parent");
    
    int truey=parentView.frame.origin.y+parentView.frame.size.height;
    CGRect txtRect=CGRectMake(textField.frame.origin.x
                              , truey
                              , textField.frame.size.width
                              , textField.frame.size.height);
    
    
    activeFieldRect = txtRect;
}

//键盘顶起 销售员号
- (void)salerNoValueEditTextDidBegin:(UITextField *)textField
{
    
    
     UIView *parentView= objc_getAssociatedObject(textField, "parent");
  
    int truey=parentView.frame.origin.y+parentView.frame.size.height;
    CGRect txtRect=CGRectMake(textField.frame.origin.x
                              , truey
                              , textField.frame.size.width
                              , textField.frame.size.height);

    
    activeFieldRect = txtRect;

}


- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
  
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

int scrollvalue=0;
// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scroll.contentInset = contentInsets;
    self.scroll.scrollIndicatorInsets = contentInsets;
    
  
    
    //页面总区域－键盘区域＝剩余区域

    
    int kby=self.view.frame.size.height-self.head1.frame.size.height-kbSize.height;
    
     scrollvalue=activeFieldRect.origin.y-kby;

    if (scrollvalue>0) {
        CGPoint scrollPoint = CGPointMake(0.0, scrollvalue+10);
        [self.scroll setContentOffset:scrollPoint animated:YES];
    }
    

}



// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scroll.contentInset = contentInsets;
    self.scroll.scrollIndicatorInsets = contentInsets;
    
    

        
        [self.scroll setFrame:CGRectMake(self.scroll.frame.origin.x
                                         , self.head1.frame.size.height
                                         , self.scroll.frame.size.width
                                         , self.view.frame.size.height-self.head1.frame.size.height-self.bottom2.frame.size.height)];
    
}



-(void) invoiceHeadValueEditTextDidEnd:(UITextField *)txt
{
    
    [self.view becomeFirstResponder];
    
    if (orderForms==nil || [orderForms count]==0) {
        return;
    }
    
    int  orderFormIndex= txt.tag;
    OrderForm *orderform=orderForms[orderFormIndex ];
    
    orderform.invoiceMsg=txt.text;
}

-(void) invoiceHeadValueEditTextDidEndOnExit:(UITextField *)txt
{

    [self.view becomeFirstResponder];
    
    if (orderForms==nil || [orderForms count]==0) {
        return;
    }
    int  orderFormIndex= txt.tag;
    OrderForm *orderform=orderForms[orderFormIndex ];
    
    orderform.invoiceMsg=txt.text;
}


-(void)userMarkEditTextDidEndOnExit:(UITextField *)textField{
    [self.view becomeFirstResponder];//把焦点给别人 键盘消失
//    int  orderFormIndex= textField.tag;
//    OrderForm *orderform=orderForms[orderFormIndex ];
//    orderform.invoiceMsg=textField.text;
    
    
    if (orderForms==nil || [orderForms count]==0) {
        return;
    }
    int  orderFormIndex= textField.tag;
    OrderForm *orderform=orderForms[orderFormIndex];
    
    orderform.userMark=textField.text;
}

-(void)userMarkEditTextDidEnd:(UITextField *)textField{
    [self.view becomeFirstResponder];//把焦点给别人 键盘消失
//    id mId = objc_getAssociatedObject(btn, "mId");
//    //取绑定数据 int  orderFormIndex= textField.tag;
//    OrderForm *orderform=orderForms[orderFormIndex ];
//    orderform.invoiceMsg=textField.text;
    
    
   
    
    int  orderFormIndex= textField.tag;
    
    if (orderForms==nil || [orderForms count]==0) {
        return;
    }
    OrderForm *orderform=orderForms[orderFormIndex];
    
    orderform.userMark=textField.text;
}



-(void) invoiceCheckButtonClicked:(UIButton*)btn
{
    // btn.selected=!btn.selected;
    
    NSNumber *orderFormIndex= objc_getAssociatedObject(btn, "orderFormIndex");
   
    
   
    
    OrderForm *orderform=orderForms[[orderFormIndex intValue]];
    
    if (![orderform.invoiceCheck isEqualToString:@"1"]) {//选中
         orderform.invoiceCheck=@"1";
        
    }else
    {
         orderform.invoiceCheck=@"0";
     
    }
    //ui
    [self orderFormList:orderForms];
    
}
-(void) personCheckButtonClicked:(UIButton *)btn
{
    btn.selected=!btn.selected;
    
   NSNumber *orderFormIndex= objc_getAssociatedObject(btn, "orderFormIndex");
     UIButton *otherButton= objc_getAssociatedObject(btn, "otherCheckButton");
    
    UITextField *invoicehead= objc_getAssociatedObject(btn, "invoicehead");
    invoicehead.enabled=false;
    
    if (otherButton.selected) {
        otherButton.selected=false;
    }else
    {
        otherButton.selected=true;
        
    }
    
    OrderForm *orderform=orderForms[[orderFormIndex intValue]];
    
    orderform.invoiceType=@"1";//个人
    
    [self orderFormList:orderForms];
}


-(void) companyCheckButtonClicked:(UIButton *)btn
{
    btn.selected=!btn.selected;
    
    int  orderFormIndex= btn.tag;
    UIButton *otherButton= objc_getAssociatedObject(btn, "otherCheckButton");
    
      UITextField *invoicehead= objc_getAssociatedObject(btn, "invoicehead");
    invoicehead.enabled=true;
    
    if (otherButton.selected) {
        otherButton.selected=false;
    }else
    {
        otherButton.selected=true;
        
    }
    
    OrderForm *orderform=orderForms[orderFormIndex];
    
    orderform.invoiceType=@"2";
        [self orderFormList:orderForms];
}



//配送方式弹框回调
-(void) dropDownCallBack:(NSString *)code name:(NSString *)name selectWhich:(int)selectWhich
{
    
  //name orderForm i
     OrderForm *orderform=orderForms[[name intValue]];
    orderform.deliverWayWhich=selectWhich;
    
 
  
    //ui
    [self orderFormList:orderForms];
   
}


-(void) pickUpAddressCallBack:(int)whichForm addressId:(NSString*)addressId address:(NSString*)address name:(NSString *)name
{
    
 OrderForm *orderform=orderForms[whichForm];
    orderform.pickupId=addressId;
    orderform.pickupAddress=address;
    orderform.pickupName=name;
    
    //ui
    [self orderFormList:orderForms];
    
}
@end


@implementation OrderForm
@synthesize  orderNo;
@synthesize busiNo;
@synthesize orderPrice;
@synthesize deliverType;
@synthesize deliverWay;
@synthesize deliverWayName;
@synthesize deliverWayPrice;
@synthesize deliverWayWhich;
@synthesize subtractionPoint;
@synthesize pickupId;
@synthesize pickupAddress;
@synthesize pickupName;

@synthesize receiverName;
@synthesize receiverAddress;
@synthesize receiverPhone;
@synthesize postCode;

@synthesize addressID;
@synthesize proCode;
@synthesize cityCode;
@synthesize streemCode;
@synthesize  sinceProvComp;
@synthesize  sinceCityComp;


@synthesize invoiceCheck;
@synthesize invoiceType;
@synthesize invoiceMsg;
@synthesize products;
@end


@implementation Product

@synthesize shoppingCartID;
@synthesize name;
@synthesize price;
@synthesize buyprice;
@synthesize number;
@synthesize productId;
@synthesize busiNo;
@synthesize normsType;
@synthesize normsName;
@end



