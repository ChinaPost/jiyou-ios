//
//  NewAddressViewController.m
//  Philately
//
//  Created by Mirror on 15/6/26.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "NewAddressViewController.h"
#import "SVProgressHUD.h"
#import "ProvinceViewController.h"
#import "AddressListViewController.h"
#import "BasicClass.h"

#import "SVProgressHUD.h"
#import "PromptError.h"
#import "SysBaseInfo.h"


@interface NewAddressViewController ()

@end

#define kAlphaNum @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
#define kNum @"0123456789"

@implementation NewAddressViewController
@synthesize flag;
@synthesize dicProv;
@synthesize shipaddr;
@synthesize isModifyAddress;

static float moveHeight =0;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([UIScreen mainScreen].bounds.size.height>=568) {
        moveHeight =0;
    }
    else
    {
        moveHeight =100;
    }
  
    if (isModifyAddress) {
         self.lbtitle.text = @"修改地址"; 
    }else
    {
    self.lbtitle.text = @"新建地址";
    }
    
    if([shipaddr.isDefaultAddr isEqualToString:@"0"])
    {
         isSelected =YES;
    }else
    {
    isSelected =NO;
    }
    
    

    [self initAddr];
    [self initDelegate];
    
    imgarr = @[[UIImage imageNamed:@"check2.png"],[UIImage imageNamed:@"uncheck2.png"]];
    self.imgView.image = isSelected?imgarr[0]:imgarr[1];
    
    self.imgView.userInteractionEnabled =YES;
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(makeFirstAddr)];
    [self.imgView addGestureRecognizer:tap];
    
    UITapGestureRecognizer* tap1 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
    [self.basicView addGestureRecognizer:tap1];
    
    UITapGestureRecognizer* tap2 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoProvView)];
    [self.cityView addGestureRecognizer:tap2];
}

-(void)click
{
    [self.tfaddr resignFirstResponder];
    [self.tfmobile resignFirstResponder];
    [self.tfname resignFirstResponder];
    [self.tfpostcode resignFirstResponder];
}

-(void)initDelegate
{
    self.tfaddr.delegate =self;
    self.tfmobile.delegate =self;
    self.tfname.delegate =self;
    self.tfpostcode.delegate =self;
    
    
    self.tfname.tag =0;
    self.tfmobile.tag =1;
    self.tfaddr.tag =2;
    self.tfpostcode.tag =3;
}
-(void)initAddr
{
    if (isModifyAddress) {
        
    }else
    {
         shipaddr =[[ShipAddressEntity alloc]init];
    }
   
    self.tfname.text = shipaddr.recvName;
    self.tfmobile.text =shipaddr.mobileNo;
    self.tfaddr.text =shipaddr.detailAddress;
    self.tfpostcode.text =shipaddr.postCode;
    
    
    
    SqlQueryCity * sqlCity = [[SqlQueryCity alloc]init];
    
    shipaddr.provName = [sqlCity queryCityNameWithRegionid:shipaddr.provCode];
    shipaddr.cityName= [sqlCity queryCityNameWithRegionid:shipaddr.cityCode];
   shipaddr.countName = [sqlCity queryCityNameWithRegionid:shipaddr.countCode];
    
    self.lbprov.text =shipaddr.provName;
    self.lbcity.text =shipaddr.cityName;
    self.lbcounty.text =shipaddr.countName;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



#pragma mark - 设置成默认地址
-(void)makeFirstAddr
{
    isSelected =!isSelected;
    self.imgView.image = isSelected?imgarr[0]:imgarr[1];
}

#pragma mark- 点击textField,根据键盘上移视图
-(void)MoveView{
    if (isUp) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationBeginsFromCurrentState: YES];

        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + moveHeight, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
        isUp = false;
    }else{
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationBeginsFromCurrentState: YES];

        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - moveHeight, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
        isUp = true;
        
    }
}


#pragma mark -点击事件
//选择地区
- (void)gotoProvView{
    
    [self.tfname resignFirstResponder];
    [self.tfmobile resignFirstResponder];
    [self.tfaddr resignFirstResponder];
    [self.tfpostcode resignFirstResponder];
    
    ProvinceViewController * provView = [[ProvinceViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:provView animated:YES];
    
}

-(void)refreshAreaInfo:(ShipAddressEntity*)shipaddress
{
    shipaddr.provCode =shipaddress.provCode;
    shipaddr.cityCode =shipaddress.cityCode;
    shipaddr.countCode =shipaddress.countCode;
    self.lbprov.text = shipaddress.provName;
    self.lbcity.text= shipaddress.cityName;
    self.lbcounty.text =shipaddress.countName;
}

//保存
- (IBAction)save:(id)sender {
     MsgReturn *msgReturn=[[MsgReturn alloc]init];
    
    if(self.tfname.text==nil ||[self.tfname.text isEqualToString:@""])
    {
        msgReturn.errorCode=@"0001";//不能为空
         msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@"姓名"  viewController:self block:^(BOOL OKCancel){} ];

        return;
    }
    else
    {
        if (self.tfname.text.length<2) {
            msgReturn.errorCode=@"0002";//长度过短
             msgReturn.errorPic=true;
            [PromptError changeShowErrorMsg:msgReturn title:@"姓名" viewController:self  block:^(BOOL OKCancel){}];
            return;
        }
        if (self.tfname.text.length>30) {
            msgReturn.errorCode=@"0003";//长度超长
             msgReturn.errorPic=true;
            [PromptError changeShowErrorMsg:msgReturn title:@"姓名" viewController:self  block:^(BOOL OKCancel){}];
            return;
        }
    }
    if(self.tfmobile.text==nil ||[self.tfmobile.text isEqualToString:@""])
    {
         msgReturn.errorCode=@"0001";//不能为空
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@"手机号码"  viewController:self block:^(BOOL OKCancel){}];
        return;
    }
    else
    {
        if (self.tfmobile.text.length<11) {
            msgReturn.errorCode=@"0002";//长度过短
             msgReturn.errorPic=true;
            [PromptError changeShowErrorMsg:msgReturn title:@"手机号码"  viewController:self block:^(BOOL OKCancel){}];
            return;
        }
    }
    
    
    BasicClass* basicClass =[[BasicClass alloc]init];
    if (![basicClass validateMobile:self.tfmobile.text]) {
        msgReturn.errorCode=@"0076";//请输入正确的手机号码
        msgReturn.errorType=@"02";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){}];
        return;
        
    }
    
    if(shipaddr.provCode==nil
       ||[shipaddr.provCode isEqualToString:@""])
    {
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        msgReturn.errorCode=@"0001";//不能为空
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@"省份"  viewController:self block:^(BOOL OKCancel){}];
        return;
    }
    if(shipaddr.cityCode ==nil
       ||[shipaddr.cityCode isEqualToString:@""])
    {
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        msgReturn.errorCode=@"0001";//不能为空
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@"城市"  viewController:self block:^(BOOL OKCancel){}];
        return;
    }
    if(shipaddr.countCode==nil
       ||[shipaddr.countCode isEqualToString:@""])
    {
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        msgReturn.errorCode=@"0001";//不能为空
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@"区县"  viewController:self block:^(BOOL OKCancel){}];
        return;
    }
    if(self.tfaddr.text==nil ||[self.tfaddr.text isEqualToString:@""])
    {
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        msgReturn.errorCode=@"0001";//不能为空
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@"地址"  viewController:self block:^(BOOL OKCancel){}];        return;
    }
    else
    {
        if (self.tfaddr.text.length<5) {
            msgReturn.errorCode=@"0002";//长度过短
             msgReturn.errorPic=true;
            [PromptError changeShowErrorMsg:msgReturn title:@"地址"  viewController:self block:^(BOOL OKCancel){}];
            return;
        }
        if (self.tfaddr.text.length>100) {
            msgReturn.errorCode=@"0003";//长度过短
             msgReturn.errorPic=true;
            [PromptError changeShowErrorMsg:msgReturn title:@"地址"  viewController:self block:^(BOOL OKCancel){}];
            return;
        }
    }
    
    if(self.tfpostcode.text==nil ||[self.tfpostcode.text isEqualToString:@""])
    {
        msgReturn.errorCode=@"0001";//不能为空
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@"邮编"  viewController:self block:^(BOOL OKCancel){} ];
        
        return;
    }
    else
    {
        if (self.tfpostcode.text.length< 6) {
            msgReturn.errorCode=@"0002";//长度过短
             msgReturn.errorPic=true;
            [PromptError changeShowErrorMsg:msgReturn title:@"邮编" viewController:self  block:^(BOOL OKCancel){}];
            return;
        }
        if (self.tfpostcode.text.length > 6) {
            msgReturn.errorCode=@"0003";//长度过长
            msgReturn.errorPic=true;
            [PromptError changeShowErrorMsg:msgReturn title:@"邮编" viewController:self  block:^(BOOL OKCancel){}];
            return;
        }
    }
    
    
    if(![DateConvert isCommonChar:self.tfname.text])
    {
      
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        
        msgReturn.errorDesc=@"姓名格式不正确";//不能为空
        msgReturn.errorType=@"01";
        msgReturn.errorCode=@"-0078";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        return ;
    }
    
    if(![DateConvert isCommonChar:self.tfaddr.text])
    {
        
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        
        msgReturn.errorDesc=@"地址格式不正确";//不能为空
        msgReturn.errorType=@"01";
        msgReturn.errorCode=@"-0078";
        msgReturn.errorPic=true;
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        return ;
    }

    if(isModifyAddress)
    {
       [self request0065];
    }else
    {
    [self request0012];
    }
}

//返回
- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - textfield 代理方法
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];//得到输入
    if (textField == self.tfmobile) {
        if (toBeString.length==12) {
            [self.tfmobile resignFirstResponder];
            return NO;
        }
    }
    else if (textField == self.tfpostcode) {
        if (toBeString.length==7) {
            [self.tfpostcode resignFirstResponder];
            return NO;
        }
    }
    else if (textField == self.tfname) {
        if (toBeString.length==31) {
            [self.tfname resignFirstResponder];
            [self.tfmobile becomeFirstResponder];
            return NO;
        }
    }
    else if (textField == self.tfaddr) {
        if (toBeString.length==101) {
            [self.tfaddr resignFirstResponder];
            [self.tfpostcode becomeFirstResponder];
            return NO;
        }
    }
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag ==2) {
        [self MoveView];
    }else if (textField.tag ==3){
        [self MoveView];
    }
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag ==2) {
        [self MoveView];
    }else if (textField.tag ==3){
        [self MoveView];
    }
    
    if (textField == self.tfmobile) {
        if ([self.tfmobile.text length] > 11)
        { //如果输入框内容等于11则禁止输入
            self.tfmobile.text =[self.tfmobile.text substringToIndex:11];
            [self.tfmobile resignFirstResponder];
            return;
        }
    }
    else  if (textField == self.tfpostcode)
    {
        if ([self.tfpostcode.text length] > 6)
        {
            self.tfpostcode.text =[self.tfpostcode.text substringToIndex:6];
            [self.tfmobile resignFirstResponder];
            return;
        }
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    switch (textField.tag) {
        case 0:
            [self.tfname resignFirstResponder];
            [self.tfmobile becomeFirstResponder];
            [self.tfaddr resignFirstResponder];
            [self.tfpostcode resignFirstResponder];
            return YES;
        case 1:
            [self.tfname resignFirstResponder];
            [self.tfmobile resignFirstResponder];
            [self.tfaddr resignFirstResponder];
            [self.tfpostcode resignFirstResponder];
            return YES;
        case 2:
            [self.tfname resignFirstResponder];
            [self.tfmobile resignFirstResponder];
            [self.tfaddr resignFirstResponder];
            [self.tfpostcode becomeFirstResponder];
            return YES;
        case 3:
            [self.tfname resignFirstResponder];
            [self.tfmobile resignFirstResponder];
            [self.tfaddr resignFirstResponder];
            [self.tfpostcode resignFirstResponder];
            return YES;
            
        default:
            return NO;
    }
}
#pragma mark - 新增 收货地址
/*新增收货地址0012*/
NSString  *n0012=@"JY0012";
/*新增收货地址0012*/
-(void) request0012{
    
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];

    NSString *recvname = self.tfname.text;
    NSString*provcode = shipaddr.provCode;
    NSString*citycode =  shipaddr.cityCode;
    NSString*countcode = shipaddr.countCode;
    NSString*detailaddr = self.tfaddr.text;
    NSString*mobileno = self.tfmobile.text;
    NSString*postcode = self.tfpostcode.text;
    NSString*isdefaultaddr = isSelected?@"0":@"1";
    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 会员编号 必填*/
    [businessparam setValue:_cstmMsg.cstmNo forKey:@"cstmNo"];
    /* 收货人姓名 必填 */
    [businessparam setValue:recvname forKey:@"recvName"];
    /* 省份代号 必填 */
    [businessparam setValue:provcode forKey:@"provCode"];
    /* 市代号 必填 */
    [businessparam setValue:citycode forKey:@"cityCode"];
    /* 县代号  必填*/
    [businessparam setValue:countcode forKey:@"countCode"];
    /* 详细地址 必填  */
    [businessparam setValue:detailaddr forKey:@"detailAddress"];
    /* 收件手机号码 必填 */
    [businessparam setValue:mobileno forKey:@"mobileNo"];
    /* 邮编  */
    [businessparam setValue:postcode forKey:@"postCode"];
    /* 是否默认地址  必填  */
    [businessparam setValue:isdefaultaddr forKey:@"isDefaultAddress"];
    
    
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0012 business:businessparam delegate:self viewController:self];

}


/*修改收货地址0012*/
NSString  *n0065=@"JY0065";
/*修改收货地址0065*/
-(void) request0065{
    
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    
    NSString *recvname = self.tfname.text;
    NSString*provcode = shipaddr.provCode;
    NSString*citycode =  shipaddr.cityCode;
    NSString*countcode = shipaddr.countCode;
    NSString*detailaddr = self.tfaddr.text;
    NSString*mobileno = self.tfmobile.text;
    NSString*postcode = self.tfpostcode.text;
    NSString*isdefaultaddr = isSelected?@"0":@"1";
    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    
     [businessparam setValue:shipaddr.addressId forKey:@"addressID"];
    /* 会员编号 必填*/
    [businessparam setValue:_cstmMsg.cstmNo forKey:@"cstmNo"];
    /* 收货人姓名 必填 */
    [businessparam setValue:recvname forKey:@"recvName"];
    /* 省份代号 必填 */
    [businessparam setValue:provcode forKey:@"provCode"];
    /* 市代号 必填 */
    [businessparam setValue:citycode forKey:@"cityCode"];
    /* 县代号  必填*/
    [businessparam setValue:countcode forKey:@"countCode"];
    /* 详细地址 必填  */
    [businessparam setValue:detailaddr forKey:@"detailAddress"];
    /* 收件手机号码 必填 */
    [businessparam setValue:mobileno forKey:@"mobileNo"];
    /* 邮编  */
    [businessparam setValue:postcode forKey:@"postCode"];
    /* 是否默认地址  必填  */
    [businessparam setValue:isdefaultaddr forKey:@"isDefaultAddress"];
    
    
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0065 business:businessparam delegate:self viewController:self];
    
}


#pragma mark - 发送交易请求后 返回处理
-(void) ReturnData:(MsgReturn*)msgReturn
{
    [SVProgressHUD dismiss];
    /*收货地址新增 0012*/
    if ([msgReturn.formName isEqualToString:n0012]||[msgReturn.formName isEqualToString:n0065])
    {
        if(msgReturn.map==nil)
            return;
        
        NSLog(@"0012 %lu",(unsigned long)[msgReturn.map count]);
//        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
//        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
//        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
//        NSString *respCode=[returnHead objectForKey:@"respCode"];
//        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        
       
        if (isModifyAddress) {
             msgReturn.errorCode =@"-0035";
            msgReturn.errorDesc=@"修改地址成功";
            [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){
                if(OKCancel)
                {
                }
                else
                {}
            }];
        }else
        {
        
             msgReturn.errorCode =@"-0035";
              msgReturn.errorDesc=@"新增地址成功";
            [PromptError changeShowErrorMsg:msgReturn title:@"新增地址成功"  viewController:self block:^(BOOL OKCancel){
                if(OKCancel)
                {
                }
                else
                {}
            }];
        }
     
        for (UIViewController* uiview in self.navigationController.viewControllers) {
            if ([uiview isKindOfClass:[AddressListViewController class]]) {
                [((AddressListViewController*)uiview) viewDidLoad];
            }
        }
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}
-(void) ReturnError:(MsgReturn*)msgReturn
{
    [SVProgressHUD dismiss];
}
@end
