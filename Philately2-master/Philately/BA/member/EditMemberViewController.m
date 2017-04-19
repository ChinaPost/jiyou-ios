//
//  EditMemberViewController.m
//  Philately
//
//  Created by Mirror on 15/6/23.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "EditMemberViewController.h"
#import "AuthenticationViewController.h"
#import "ChangeSexViewController.h"
#import "ChangeAddrViewController.h"
#import "ReservationViewController.h"
#import "ProvinceViewController.h"

#import "SqlQueryService.h"
#import "ServiceEntity.h"
#import "SqlQueryCity.h"

#import "NewCityViewController.h"
#import "RelateMobilePhoneViewController.h"
#import "ProductOrderForm.h"
#import "RespondParam0008.h"

@interface EditMemberViewController ()
@property (nonatomic)NSString *strSexFlag;
@property (nonatomic)NSString* stremail ;
@property (nonatomic)NSString* strbrchMobNum;

@property (nonatomic)NSString *strProvCode;
@property (nonatomic)NSString *strCityCode;
@property (nonatomic)NSString *strCountCode;

@property (nonatomic)NSString* strdetailAddr;
@property (nonatomic)NSString* strpostCode;
@end

@implementation EditMemberViewController
@synthesize strProvCode;
@synthesize strCityCode;
@synthesize strCountCode;
@synthesize strSexFlag;
@synthesize strbrchMobNum;
@synthesize stremail;
@synthesize strdetailAddr;
@synthesize strpostCode;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbtitle.text =@"编辑会员信息";
//    self.navigationController.navigationBar.hidden =YES;
    

   // tmpCstm =[CstmMsg sharedInstance];
   // [self initData];
    [self initFrame];
    
    
    UITapGestureRecognizer *click1 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(modifysex)];
    [self.sexView addGestureRecognizer:click1];
    
    
    UITapGestureRecognizer *click4 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(modifycity)];
    [self.cityView addGestureRecognizer:click4];
    
    UITapGestureRecognizer *click7 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(modifyyanzheng)];
    [self.yanzhengView addGestureRecognizer:click7];
    
    UITapGestureRecognizer *clickbackground =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickbackview)];
    [self.view addGestureRecognizer:clickbackground];
    
    [self request0008];

    
    

    
    UITapGestureRecognizer *homePhoneEditerGuest=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editTextTapHandle:)];
    
    homePhoneEditerGuest.delegate = self;//头文件<UIGestureRecognizerDelegate>
    
    [  self.homePhoneEditer  addGestureRecognizer:homePhoneEditerGuest];
    [self.homePhoneEditer addTarget:self action:@selector(liuEditTextDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [self.homePhoneEditer addTarget:self action:@selector(liuEditTextDidEnd:) forControlEvents:UIControlEventEditingDidEnd];

    
    
    
    
    
    UITapGestureRecognizer *tfemailGuest=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editTextTapHandle:)];
    
    tfemailGuest.delegate = self;//头文件
     [  self.tfemail  addGestureRecognizer:tfemailGuest];
    [self.tfemail addTarget:self action:@selector(liuEditTextDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [self.tfemail addTarget:self action:@selector(liuEditTextDidEnd:) forControlEvents:UIControlEventEditingDidEnd];

    
    
    
    
    
    UITapGestureRecognizer *tfbrchMobNumGuest=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editTextTapHandle:)];
    
    tfbrchMobNumGuest.delegate = self;//头文件
     [  self.tfbrchMobNum addGestureRecognizer:tfbrchMobNumGuest];
    [self.tfbrchMobNum addTarget:self action:@selector(liuEditTextDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [self.tfbrchMobNum addTarget:self action:@selector(liuEditTextDidEnd:) forControlEvents:UIControlEventEditingDidEnd];

    
    
    
    
    
    UITapGestureRecognizer *tfpostcodeGuest=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editTextTapHandle:)];
    
    tfpostcodeGuest.delegate = self;//头文件
     [ self.tfpostcode  addGestureRecognizer:tfpostcodeGuest];
    [self.tfpostcode addTarget:self action:@selector(liuEditTextDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [self.tfpostcode addTarget:self action:@selector(liuEditTextDidEnd:) forControlEvents:UIControlEventEditingDidEnd];

    
    
    
    
    UITapGestureRecognizer *tfdetailAddrGuest=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editTextTapHandle:)];
    
    tfdetailAddrGuest.delegate = self;//头文件
     [ self.tfdetailAddr  addGestureRecognizer:tfdetailAddrGuest];
    
    [self.tfdetailAddr addTarget:self action:@selector(liuEditTextDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [self.tfdetailAddr addTarget:self action:@selector(liuEditTextDidEnd:) forControlEvents:UIControlEventEditingDidEnd];

    
    
    
    //键盘顶起
    UITapGestureRecognizer* closeKeyboardtap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKeyboardBlankPlaceTapHandle:)];
    [self.view addGestureRecognizer:closeKeyboardtap];
    
   

    
}


-(void)liuEditTextDidEndOnExit:(UITextField *)textField{
  //  [self.view becomeFirstResponder];//把焦点给别人 键盘消失
//    int  orderFormIndex= textField.tag;
//    OrderForm *orderform=orderForms[orderFormIndex ];
//    orderform.invoiceMsg=textField.text;
}

-(void)liuEditTextDidEnd:(UITextField *)textField{
   // [self.view becomeFirstResponder];//把焦点给别人 键盘消失
//    id mId = objc_getAssociatedObject(btn, "mId");
//    //取绑定数据 int  orderFormIndex= textField.tag;
//    OrderForm *orderform=orderForms[orderFormIndex ];
//    orderform.invoiceMsg=textField.text;
}

//编辑框键盘顶起start

float touchy1;
int   movelength1;
int  keyboardHeight1;
bool keyboardOpen;

//注销键盘监听
-(void)viewDidDisappear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    
}

//<UIGestureRecognizerDelegate>
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
    
    
}



//点空白区域键盘消失
-(void)closeKeyboardBlankPlaceTapHandle:(UITapGestureRecognizer *)sender
{
    
    if (keyboardOpen) {
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    }
    
}


//touchY 触摸位置
-(void)editTextTapHandle:(UITapGestureRecognizer *)sender
{
    
    if (keyboardOpen) {
        return;
    }
    
    CGPoint point = [sender locationInView:self.view];
    touchy1=point.y+15;
    
    if(keyboardHeight1>0)
    {
        if(touchy1>keyboardHeight1)
        {
            movelength1=touchy1-keyboardHeight1;
            [self MoveView:(-movelength1)];
        }else
        {
            movelength1=0;
            [self MoveView:(-movelength1)];
        }
    }
    
}

//键盘打开监听回调
- (void)keyboardWillShow:(NSNotification *)notification {
    
    if (keyboardOpen==true) {
        return;
    }
    keyboardOpen=true;
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
    
    
    
    if(keyboardHeight1==0)
    {
        // Get the duration of the animation.
        NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        NSTimeInterval animationDuration;
        [animationDurationValue getValue:&animationDuration];
        //
        //    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:animationDuration];
        
        keyboardHeight1=keyboardTop;
        
        if(touchy1>keyboardHeight1)
        {
            movelength1=touchy1-keyboardHeight1;
            [self MoveView:(-movelength1)];
        }else
        {
            movelength1=0;
            [self MoveView:(-movelength1)];
        }
        
        
        
        [UIView commitAnimations];
    }
    
    
    
    
    
}

//键盘关闭监听回调
- (void)keyboardWillHide:(NSNotification *)notification {
    
    if (keyboardOpen==false) {
        return;
    }
    
    keyboardOpen=false;
    
   
    NSDictionary* userInfo = [notification userInfo];
    
    
    
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the disappearance of the keyboard.
     */
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    
    
    [self MoveView:(movelength1)];
    
    
    [UIView commitAnimations];
}

-(void)MoveView:(int)h{
    
    
    if (h<0) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [self.view setFrame: CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + h, self.view.frame.size.width, self.view.frame.size.height)];
        [UIView commitAnimations];
    }else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [self.view setFrame: CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+h , self.view.frame.size.width, self.view.frame.size.height)];
        [UIView commitAnimations];
    }
    
    
    
}
//编辑框键盘顶起end





-(void)viewWillAppear:(BOOL)animated
{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardDidHideNotification object:nil];
   
    
    if (tmpCstm!=nil) {
        [self initData];
    }
    
 

}

-(void)initData
{
    
    
    strSexFlag =tmpCstm.userSex;
    stremail=tmpCstm.email;
    strbrchMobNum=tmpCstm.brchMobNum;
    strProvCode=tmpCstm.provCode;
    strCityCode=tmpCstm.cityCode;
    strCountCode=tmpCstm.countCode;
    strdetailAddr=tmpCstm.detailAddress;
    strpostCode=tmpCstm.postCode;
    
    ServiceEntity* serviceEty = [[ServiceEntity alloc]init];
    SqlQueryCity * sqlCity = [[SqlQueryCity alloc]init];
    SqlQueryService* service = [[SqlQueryService alloc]init];
    serviceEty = [service queryServiceWithKey:@"SEX" withcode:strSexFlag];
    
    self.lbuserName.text =tmpCstm.userName;
    self.lbsex.text = serviceEty.serviceName;
    
    
    
    self.homePhoneEditer.text=tmpCstm.homePhone;
    
    self.homePhoneEditer.keyboardType=UIKeyboardTypePhonePad;
    self.homePhoneEditer.returnKeyType=UIReturnKeyDone;
    self.tfemail.returnKeyType=UIReturnKeyDone;
    self.tfbrchMobNum.returnKeyType=UIReturnKeyDone;
    self.tfdetailAddr.returnKeyType=UIReturnKeyDone;
    self.tfpostcode.returnKeyType=UIReturnKeyDone;
    
    self.cstmScore.text=[NSString stringWithFormat:@"%@分",tmpCstm.cstmScore];
    
    UITapGestureRecognizer *relateMobilePhoneTextTapGuest=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(relateMobilePhoneTapHandle)];

    [ self.relateMobilePhone  addGestureRecognizer:relateMobilePhoneTextTapGuest];
    
    
    
    self.tfemail.text=stremail;
    self.tfbrchMobNum.text =strbrchMobNum;
    self.lbprovName.text =[sqlCity queryCityNameWithRegionid:strProvCode];
    self.lbcityName.text =[sqlCity queryCityNameWithRegionid:strCityCode];
    self.lbcountyName.text =[sqlCity queryCityNameWithRegionid:strCountCode];
    
    self.tfdetailAddr.text = strdetailAddr;
    self.tfpostcode.text = strpostCode;
    
    NSLog(@"cstmName length [%lu]",(unsigned long)tmpCstm.cstmName.length);
    NSString* tmpcstmname =tmpCstm.cstmName.length>1?[NSString stringWithFormat:@"*%@",[tmpCstm.cstmName  substringFromIndex:1]]:tmpCstm.cstmName;
    NSString* tmpcertno = tmpCstm.certNo.length>4?[NSString stringWithFormat:@"%@******%@",[tmpCstm.certNo  substringToIndex:4],[tmpCstm.certNo  substringFromIndex:(tmpCstm.certNo.length-4)]]:tmpCstm.certNo;
    
    self.lbcstmName.text = tmpcstmname;
    self.lbcertNo.text =tmpcertno ;
    self.lbverifiMobileNo.text = tmpCstm.verifiMobileNo;
    
    
    if (tmpCstm.mobileNo==nil ||[tmpCstm.mobileNo isEqualToString:@""]) {
        [self.relateMobilePhone setHidden:NO];
        [self.relatePhoneRight setHidden:NO];
        [self.lbcstmMobile setHidden:YES];
        
        
        self.relateMobilePhone.text=@"关联手机号";
        
        
    }else
    {
        
        [self.relateMobilePhone setHidden:YES];
        [self.relatePhoneRight setHidden:YES];
        [self.lbcstmMobile setHidden:NO];
        self.lbcstmMobile.text =tmpCstm.mobileNo;
        
    }
    
    
    [self initFrame];
    [self initDelegate];
}


-(void)relateMobilePhoneTapHandle
{
    
    RelateMobilePhoneViewController *relateMobilePhoneViewController=[[RelateMobilePhoneViewController alloc]initWithNibName:@"RelateMobilePhoneViewController" bundle:nil];
    
    
 
        [self presentViewController:relateMobilePhoneViewController animated:NO completion:^{
            
        }];
   
    


}

-(void)initDelegate
{
    self.tfbrchMobNum.delegate =self;
    self.tfdetailAddr.delegate =self;
    self.tfemail.delegate =self;
    self.tfpostcode.delegate =self;
}

-(void)initFrame
{
    self.basicView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.postView.frame.origin.y+self.postView.frame.size.height);
    [self.Scrollview addSubview:self.basicView];
    
    if ([[CstmMsg sharedInstance].isAutonym isEqualToString:@"1"]) {
        
        self.yanzhengView.frame = CGRectMake(0, self.basicView.frame.size.height+1, self.view.frame.size.width, 52);
        [self.Scrollview addSubview:self.yanzhengView];
        
        self.saveView.frame = CGRectMake(0, self.basicView.frame.size.height+self.yanzhengView.frame.size.height+10, self.view.frame.size.width, 80);
        [self.Scrollview addSubview:self.saveView];
    }
    else
    {
        self.yanzhengtonguoView.frame = CGRectMake(0, self.basicView.frame.size.height+1, self.view.frame.size.width, 90);
        [self.Scrollview addSubview:self.yanzhengtonguoView];
        
        self.saveView.frame = CGRectMake(0, self.basicView.frame.size.height+self.yanzhengtonguoView.frame.size.height+105, self.view.frame.size.width, 80);
        [self.Scrollview addSubview:self.saveView];
    }
    
    self.Scrollview.frame =CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60);
    
    self.Scrollview.contentSize = CGSizeMake(self.view.frame.size.width, self.saveView .frame.size.height + self.saveView.frame.origin.y);
}
//-(void) viewDidLayoutSubviews{
//    [super viewDidLayoutSubviews];
//    
//    [self initFrame];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
#pragma mark -修改基本资料事件
-(void)modifysex
{
    [self clickdown:tagsex ];
}


-(void)modifycity
{
    
    mtarr = [NSMutableArray array];
    NewCityViewController* newcityview =[[NewCityViewController alloc]init];
    newcityview.view.frame =CGRectMake(0, self.view.bounds.size.height-230, self.view.bounds.size.width, 230);
    newcityview.provcode =strProvCode;
    newcityview.countcode =strCountCode;
    newcityview.citycode =strCityCode;
    [newcityview initdata];
    newcityview.cancleClick=^()
    {
        [pickfatherview removeFromSuperview];
    };
    newcityview.sureClick=^(NSString*provcode,NSString*provname,NSString*citycode,NSString*cityname,NSString*countcode,NSString*countname)
    {
        strProvCode = provcode;
        strCityCode = citycode;
        strCountCode =countcode;
        self.lbprovName.text =provname;
        self.lbcityName.text =cityname;
        self.lbcountyName.text =countname;
        [pickfatherview removeFromSuperview];
    };
    
    [mtarr addObject:newcityview];
    
    pickfatherview =[[UIView alloc]init];
    pickfatherview.frame = self.view.frame;
    pickfatherview.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    [pickfatherview addSubview:newcityview.view];
    [self.view addSubview:pickfatherview];
    
}


-(void)modifyyanzheng
{
    [self clickdown:tagyanzheng];
}

-(void)clickbackview
{
    [self.tfemail resignFirstResponder];
    [self.tfbrchMobNum resignFirstResponder];
    [self.tfdetailAddr resignFirstResponder];
    [self.tfpostcode resignFirstResponder];
}

-(void)clickdown:(NSInteger)tag
{
    if (tag==tagsex) {
        
        if (keyboardOpen) {
            [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        }
        
        ChangeSexViewController *changesexview =[[ChangeSexViewController alloc]init];
        changesexview.sexFlag = strSexFlag;
        changesexview.doSelectSex = ^(NSString* sexflag)
        {
            strSexFlag = sexflag;
            tmpCstm.userSex=sexflag;
            ServiceEntity *serviceEty =[[ServiceEntity alloc]init];
            SqlQueryService* service = [[SqlQueryService alloc]init];
            serviceEty = [service queryServiceWithKey:@"SEX" withcode:sexflag];
            
            self.lbsex.text = serviceEty.serviceName;
        };
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:changesexview animated:YES];
        movelength1=0;

    }
    else if (tag==tagyanzheng) {
        AuthenticationViewController* authview = [[AuthenticationViewController alloc]init];
        authview.refreshData=^(NSString*cstmName,NSString*certNo)
        {
            NSString* tmpcstmname =[NSString stringWithFormat:@"*%@",[cstmName  substringFromIndex:1]];
            NSString* tmpcertno =[NSString stringWithFormat:@"%@******%@",[certNo  substringToIndex:4],[tmpCstm.certNo  substringFromIndex:(tmpCstm.certNo.length-4)]];
            
            self.lbcstmName.text =tmpcstmname;
            self.lbcertNo.text =tmpcertno;
            
            [self initData];
            self.lbverifiMobileNo.text =tmpCstm.mobileNo;
        };
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:authview animated:YES];
    }
    else if (tag==tagcity) {
        ProvinceViewController *provView =[[ProvinceViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:provView animated:YES];
    }

    
}



#pragma mark - 选择 省，市，县 更新数据
-(void)refreshAreaInfo:(ShipAddressEntity*)shipaddress
{
    strProvCode =shipaddress.provCode;
    strCityCode =shipaddress.cityCode;
    strCountCode =shipaddress.countCode;
    self.lbprovName.text = shipaddress.provName;
    self.lbcityName.text= shipaddress.cityName;
    self.lbcountyName.text =shipaddress.countName;
}

#pragma mark -UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];//得到输入
    if (textField == self.tfbrchMobNum) {
        if (toBeString.length==13) {
            [self.tfbrchMobNum resignFirstResponder];
            return NO;
        }
    }
    else if (textField == self.tfpostcode){
        if (toBeString.length==7) {
            [self.tfpostcode resignFirstResponder];
            return NO;
        }
    }
    else if (textField == self.tfemail){
        if (toBeString.length==51) {
            [self.tfemail resignFirstResponder];
            return NO;
        }
    }
    else if (textField == self.tfdetailAddr){
        if (toBeString.length==101) {
            [self.tfdetailAddr resignFirstResponder];
            return NO;
        }
    }
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"tag:[%ld]",(long)textField.tag);
    if (textField == self.tfbrchMobNum) {
        if ([self.tfbrchMobNum.text length] > 12)
        { //如果输入框内容等于12则禁止输入
            self.tfbrchMobNum.text =[self.tfbrchMobNum.text substringToIndex:12];
            //[self.tfbrchMobNum resignFirstResponder];
            return;
        }
    }else if (textField == self.tfpostcode){
        if ([self.tfpostcode.text length] > 6)
        {
            self.tfpostcode.text =[self.tfpostcode.text substringToIndex:6];
           // [self.tfpostcode resignFirstResponder];
            return;
        }
    }
    else if (textField == self.tfemail){
        if ([self.tfemail.text length] > 50)
        {
            self.tfemail.text =[self.tfemail.text substringToIndex:50];
           // [self.tfemail resignFirstResponder];
            return;
        }
    }
    else if (textField == self.tfdetailAddr){
        if ([self.tfdetailAddr.text length] > 100)
        {
            self.tfdetailAddr.text =[self.tfdetailAddr.text substringToIndex:100];
           // [self.tfdetailAddr resignFirstResponder];
            return;
        }
    }
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    if (textField == self.tfemail){
//        [self.tfemail resignFirstResponder];
//        [self.tfbrchMobNum becomeFirstResponder];
//        [self.tfdetailAddr resignFirstResponder];
//        [self.tfpostcode resignFirstResponder];
//        
//    }else if (textField == self.tfbrchMobNum) {
//        [self.tfemail resignFirstResponder];
//        [self.tfbrchMobNum resignFirstResponder];
//        [self.tfdetailAddr resignFirstResponder];
//        [self.tfpostcode resignFirstResponder];
//    }else if (textField == self.tfdetailAddr){
//        [self.tfemail resignFirstResponder];
//        [self.tfbrchMobNum resignFirstResponder];
//        [self.tfdetailAddr resignFirstResponder];
//        [self.tfpostcode becomeFirstResponder];
//    }else if (textField == self.tfpostcode){
//        [self.tfemail resignFirstResponder];
//        [self.tfbrchMobNum resignFirstResponder];
//        [self.tfdetailAddr resignFirstResponder];
//        [self.tfpostcode resignFirstResponder];
//    }
    return YES;
}


#pragma mark - 按钮事件
- (IBAction)save:(id)sender {
    
    MsgReturn *msgReturn=[[MsgReturn alloc]init];
    
    NSString* cstmno=[CstmMsg sharedInstance].cstmNo;
    if(cstmno==nil ||[cstmno isEqualToString:@""])
    {
        msgReturn.errorCode=@"0001";//不能为空
        [PromptError changeShowErrorMsg:msgReturn title:@"会员号"  viewController:self block:^(BOOL OKCancel)
         {
             if (OKCancel) {
                 
             }else
             {
                 
             }
             return ;
         }
         ];
        
        return;
    }
    if(strSexFlag==nil ||[strSexFlag isEqualToString:@""])
    {
        msgReturn.errorCode=@"0001";//不能为空
        [PromptError changeShowErrorMsg:msgReturn title:@"性别"  viewController:self block:^(BOOL OKCancel)
         {
             if (OKCancel) {
                 
             }else
             {
                 
             }
             return ;
         }
         ];
        
        return;
    }
    

    strdetailAddr =self.tfdetailAddr.text;
    if(![strdetailAddr isEqualToString:@""])
    {
        if (strdetailAddr.length <5) {
            msgReturn.errorCode=@"0002";//长度过短
            msgReturn.errorPic=true;
            [PromptError changeShowErrorMsg:msgReturn title:@"地址"  viewController:self block:^(BOOL OKCancel){}];
            return;
        }
        if (strdetailAddr.length>100) {
            msgReturn.errorCode=@"0003";//长度超长
            msgReturn.errorPic=true;
            [PromptError changeShowErrorMsg:msgReturn title:@"地址"  viewController:self block:^(BOOL OKCancel){}];
            return;
        }
    }
        
    strpostCode = self.tfpostcode.text;
    if (![strpostCode isEqualToString:@""]) {
        if (strpostCode.length>6) {
            msgReturn.errorCode=@"0003";//长度过长
            msgReturn.errorPic=true;
            [PromptError changeShowErrorMsg:msgReturn title:@"邮编"  viewController:self block:^(BOOL OKCancel){}];
            return;
        }
        if (strpostCode.length<6) {
            msgReturn.errorCode=@"0002";//长度过短
            msgReturn.errorPic=true;
            [PromptError changeShowErrorMsg:msgReturn title:@"邮编"  viewController:self block:^(BOOL OKCancel){}];
            return;
        }
    }
    

    stremail = self.tfemail.text;
    if (![stremail isEqualToString:@""]) {
        if (stremail.length>50) {
            msgReturn.errorCode=@"0003";//长度过长
            msgReturn.errorPic=true;
            [PromptError changeShowErrorMsg:msgReturn title:@"电子邮箱"  viewController:self block:^(BOOL OKCancel){}];
            return;
        }
    }
    
    
    strbrchMobNum =self.tfbrchMobNum.text;
    
    [self request0010];
}

- (IBAction)goback:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];

}
#pragma mark - 会员基本资料修改
/*会员基本资料修改0010*/
NSString  *n0010=@"JY0010";
/*会员基本资料修改0010*/
-(void) request0010{
    
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 会员编号 必填*/
    [businessparam setValue:_cstmMsg.cstmNo forKey:@"cstmNo"];
    /* 性别 必填 */
    [businessparam setValue:strSexFlag forKey:@"userSex"];
    /* 邮箱 选填 */
    [businessparam setValue:stremail forKey:@"email"];
    
    [businessparam setValue:self.homePhoneEditer.text forKey:@"homePhone"];
    
    /* 省份代号 选填 */
    [businessparam setValue:strProvCode forKey:@"provCode"];
    /* 市代号 选填 */
    [businessparam setValue:strCityCode forKey:@"cityCode"];
    /* 县代号 选填 */
    [businessparam setValue:strCountCode forKey:@"countCode"];
    /* 详细地址 选填 */
    [businessparam setValue:strdetailAddr forKey:@"detailAddress"];
    /* 邮编 选填 */
    [businessparam setValue:strpostCode forKey:@"postCode"];
    /* 营业员联系方式 选填 */
    [businessparam setValue:strbrchMobNum forKey:@"brchMobNum"];
    /* 新邮自提机构代码 选填 */
    [businessparam setValue:tmpCstm.sinceBrchNo forKey:@"sinceBrchNo"];
    /* 零售自提机构代码 选填 */
    [businessparam setValue:tmpCstm.saleBrchNo forKey:@"saleBrchNo"];
    
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0010 business:businessparam delegate:self viewController:self];
    
}



/*会员资料标准查询0008*/
NSString  *nnn0008=@"JY0008";
/*会员资料标准查询0008*/
-(void) request0008{
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 会员编号 备注:必填*/
    [businessparam setValue:_cstmMsg.cstmNo forKey:@"cstmNo"];
    /* 手机号码 备注:必填*/
    [businessparam setValue:@"" forKey:@"mobileNo"];
    //[serviceInvoker callWebservice:businessparam formName:nn0008 ];
    
    
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
   
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:nnn0008 business:businessparam delegate:self viewController:self];
    
}


#pragma mark - 发送交易请求后 返回处理
-(void) ReturnData:(MsgReturn*)msgReturn
{
    [SVProgressHUD dismiss];
    /*修改基本会员资料 0010*/
    if ([msgReturn.formName isEqualToString:n0010])//修改基本会员资料
    {
        if(msgReturn.map==nil)
            return;
        
        NSLog(@"0010 %lu",(unsigned long)[msgReturn.map count]);
        
        msgReturn.errorCode=@"0036";//会员基本资料修改成功
        [PromptError changeShowErrorMsg:msgReturn title:@"会员基本资料修"  viewController:self block:^(BOOL OKCancel){} ];
        
        [CstmMsg sharedInstance].userSex =strSexFlag;
        [CstmMsg sharedInstance].email =stremail;
        [CstmMsg sharedInstance].brchMobNum =strbrchMobNum;
        [CstmMsg sharedInstance].provCode =strProvCode;
        [CstmMsg sharedInstance].cityCode =strCityCode;
        [CstmMsg sharedInstance].countCode =strCountCode;
        [CstmMsg sharedInstance].detailAddress =strdetailAddr;
        [CstmMsg sharedInstance].postCode =strpostCode;
         [CstmMsg sharedInstance].homePhone =self.homePhoneEditer.text;

    }
    
    
    
    /*会员资料标准查询0008*/
    if ([msgReturn.formName isEqualToString:nnn0008]){
        if(msgReturn.map==nil)
            return;
        
        NSLog(@"0008 %lu",(unsigned long)[msgReturn.map count]);
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        
        CstmMsg *cst=[CstmMsg sharedInstance];
        RespondParam0008 *commonItem=[[RespondParam0008 alloc]init];
        /* 用户头像图片ID 备注:用户头像URL地址*/
        commonItem.userPicID=[returnDataBody objectForKey:@"userPicID"];
        cst.userPicID=commonItem.userPicID;
        /* 用户名 备注:*/
        commonItem.userName=[returnDataBody objectForKey:@"userName"];
        cst.userName=commonItem.userName;
        /* 手机号码 备注:注册手机号码*/
        commonItem.mobileNo=[returnDataBody objectForKey:@"mobileNo"];
        cst.mobileNo=commonItem.mobileNo;
        
        commonItem.homePhone=[returnDataBody objectForKey:@"homePhone"];
        cst.homePhone=commonItem.homePhone;
        
        /* 性别 备注:0：男
         1：女*/
        commonItem.userSex=[returnDataBody objectForKey:@"userSex"];
        cst.userSex=commonItem.userSex;
        /* 邮箱 备注:*/
        commonItem.email=[returnDataBody objectForKey:@"email"];
        cst.email=commonItem.email;
        /* 会员积分 备注:*/
        commonItem.cstmScore=[[returnDataBody objectForKey:@"cstmScore"] intValue];
        
        cst.cstmScore=[NSString stringWithFormat:@"%d",commonItem.cstmScore];
        /* 是否历史集邮统版会员 备注:0：是
         1：否*/
        commonItem.isStampMember=[returnDataBody objectForKey:@"isStampMember"];
        cst.isStampMember=commonItem.isStampMember;
        /* 是否实名认证 备注:0：是
         1：否*/
        commonItem.isAutonym=[returnDataBody objectForKey:@"isAutonym"];
        cst.isAutonym=commonItem.isAutonym;
        /* 姓名 备注:未经过实名验证的会员这几项为空*/
        commonItem.cstmName=[returnDataBody objectForKey:@"cstmName"];
        cst.cstmName=commonItem.cstmName;
        /* 身份证号码 备注:*/
        commonItem.certNo=[returnDataBody objectForKey:@"certNo"];
        cst.certNo=commonItem.certNo;
        /* 认证手机号码 备注:*/
        commonItem.verifiMobileNo=[returnDataBody objectForKey:@"verifiMobileNo"];
        cst.verifiMobileNo=commonItem.verifiMobileNo;
        /* 省份代号 备注:2015/6/17 增加*/
        commonItem.provCode=[returnDataBody objectForKey:@"provCode"];
        cst.provCode =commonItem.provCode;
        /* 市代号 备注:2015/6/17增加*/
        commonItem.cityCode=[returnDataBody objectForKey:@"cityCode"];
        cst.cityCode=commonItem.cityCode;
        /* 县代号 备注:2015/6/17增加*/
        commonItem.countCode=[returnDataBody objectForKey:@"countCode"];
        cst.countCode=commonItem.countCode;
        /* 详细地址 备注:2015/6/17增加*/
        commonItem.detailAddress=[returnDataBody objectForKey:@"detailAddress"];
        cst.detailAddress =commonItem.detailAddress;
        /* 邮编 备注:2015/6/17增加*/
        commonItem.postCode=[returnDataBody objectForKey:@"postCode"];
        cst.postCode =commonItem.postCode;
        /* 营业员联系方式（营业员编号） 备注:2015/6/17 增加*/
        commonItem.brchMobNum=[returnDataBody objectForKey:@"brchMobNum"];
        cst.brchMobNum=commonItem.brchMobNum;
        /* 新邮自提机构代码 备注:2015/6/17增加*/
        commonItem.sinceBrchNo=[returnDataBody objectForKey:@"sinceBrchNo"];
        cst.sinceBrchNo =commonItem.sinceBrchNo;
        /* 零售自提机构代码 备注:2015/6/17增加*/
        commonItem.saleBrchNo=[returnDataBody objectForKey:@"saleBrchNo"];
        cst.saleBrchNo =commonItem.saleBrchNo;
        
        
        //        sinceBrchName	新邮自提机构名称	字符	10	2015/8/21 新增
        
        cst.sinceBrchName =[returnDataBody objectForKey:@"sinceBrchName"];
        //        sinceBrchAddress	新邮自提机构地址	字符	200	2015/8/21 新增
        
        cst.sinceBrchAddress =[returnDataBody objectForKey:@"sinceBrchAddress"];
        //        saleBrchName	零售自提机构名称	字符	10	2015/8/21 新增
        cst.saleBrchName = [returnDataBody objectForKey:@"saleBrchName"];
        
        //        saleBrchAddress	零售自提机构地址	字符	100	2015/8/21 新增
        cst.saleBrchAddress =  [returnDataBody objectForKey:@"saleBrchAddress"];
        
        
        
        
        /* 关联终端数量 备注:循环域开始*/
        commonItem.termNum=[returnDataBody objectForKey:@"termNum"];
        /* 关联终端类型 备注:01：adnroid
         02：ios
         03：微信*/
        commonItem.termType=[returnDataBody objectForKey:@"termType"];
        /* 关联终端编号 备注:微信类型的终端编号为Openid*/
        commonItem.termNo=[returnDataBody objectForKey:@"termNo"];
        /* 关联终端数量 备注:循环域结束*/
        commonItem.termNum=[returnDataBody objectForKey:@"termNum"];
        
        
        tmpCstm =[CstmMsg sharedInstance];
        [self initData];
        
        
    }

}
-(void) ReturnError:(MsgReturn*)msgReturn
{
    [SVProgressHUD dismiss];
}


@end
