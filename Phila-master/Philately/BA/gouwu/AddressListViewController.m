//
//  AddressListViewController.m
//  Philately
//
//  Created by Mirror on 15/7/1.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "AddressListViewController.h"
#import "NewAddressViewController.h"
#import "ShipAddressEntity.h"
#import "SVProgressHUD.h"


#import "PromptError.h"
#import "SysBaseInfo.h"

#import "SignServiceEntity.h"
#import "SqlQuerySignService.h"

@interface AddressListViewController ()

@end

@implementation AddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbtitle.text=@"收货地址";
    
    addrList =[NSMutableArray array];
    [self request0011];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self initframe];
}


#pragma mark - 查询收货地址信息
-(void) request0011{
    /*收货地址查询0011*/
    NSString  *n0011=@"JY0011";
    /*收货地址查询0011*/
    
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];

    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 会员编号 备注:必填*/
    [businessparam setValue:_cstmMsg.cstmNo forKey:@"cstmNo"];
    /* 默认地址查询标志 */
    [businessparam setValue:@"0" forKey:@"isDefaultAddress"];
    
    [businessparam setValue:@"1" forKey:@"pageCode"];
    [businessparam setValue:@"100" forKey:@"pageNum"];
    
    
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
 
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0011 business:businessparam delegate:self viewController:self];

}

-(void) request0013:(NSString*)addrID
{
    /*收货地址删除0013*/
    NSString  *n0013=@"JY0013";
    /*收货地址删除0013*/
    
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
   // _cstmMsg.cstmNo=@"123";
    
    if (_cstmMsg.cstmNo==nil||[_cstmMsg.cstmNo isEqualToString:@""])
    {
        
    }
    else
    {
        NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
        /* 会员编号 备注:必填*/
        [businessparam setValue:_cstmMsg.cstmNo forKey:@"cstmNo"];
        /* 收货地址编号 */
        [businessparam setValue:addrID forKey:@"addressID"];
        
        
        SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
        StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
        
     
        [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0013 business:businessparam delegate:self viewController:self];
        
    }
}

#pragma mark - 发送交易请求后 返回处理
-(void) ReturnData:(MsgReturn*)msgReturn
{
    
    /*收货地址查询 0011*/
    if ([msgReturn.formName isEqualToString:@"JY0011"]){
        [SVProgressHUD dismiss];
        if(msgReturn.map==nil)
            return;
        

        ShipAddressEntity *shipaddr;
        
        NSLog(@"0011 %lu",(unsigned long)[msgReturn.map count]);
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        
        int totalnum = [[returnDataBody objectForKey:@"totalNum"] intValue];
        int recordnum =[[returnDataBody objectForKey:@"recordNum"] intValue];
        
        for (int i =0; i<recordnum; i++) {
            shipaddr =[[ShipAddressEntity alloc]init];
            NSString* addressID = [returnDataBody objectForKey:@"addressID"][i];
            NSString* recvName = [returnDataBody objectForKey:@"recvName"][i];
            NSString* provCode = [returnDataBody objectForKey:@"provCode"][i];
            NSString* cityCode = [returnDataBody objectForKey:@"cityCode"][i];
            NSString* countCode = [returnDataBody objectForKey:@"countCode"][i];
            NSString* detailAddress = [returnDataBody objectForKey:@"detailAddress"][i];
            NSString* mobileNo = [returnDataBody objectForKey:@"mobileNo"][i];
            NSString* postCode = [returnDataBody objectForKey:@"postCode"][i];
            NSString* isDefaultAddress = [returnDataBody objectForKey:@"isDefaultAddress"][i];
            shipaddr.addressId =addressID;
            shipaddr.recvName =recvName;
            shipaddr.provCode = provCode;
            shipaddr.cityCode =cityCode;
            shipaddr.countCode =countCode;
            shipaddr.detailAddress =detailAddress;
            shipaddr.mobileNo =mobileNo;
            shipaddr.postCode=postCode;
            shipaddr.isDefaultAddr =isDefaultAddress;
            [addrList addObject:shipaddr];
        }
        [self bindData:addrList];
    }
    else if ([msgReturn.formName isEqualToString:@"JY0013"])//地址删除
    {
        if(msgReturn.map==nil)
            return;
        
        NSLog(@"0013 %lu",(unsigned long)[msgReturn.map count]);
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        
//        [self.view makeToast:@"修改密码成功"];
        NSLog(@"删除成功");
        addrList =[NSMutableArray array];
        [self request0011];
        
    }
}
-(void) ReturnError:(MsgReturn*)msgReturn
{
    [SVProgressHUD dismiss];
}


-(void)bindData:(NSMutableArray*)dataArr
{
    mtarr =[NSMutableArray array];
    if (dataArr.count==0) {
        NSArray *views = [self.ScrollView subviews];
        for( UIView * view in views)
        {
            [view removeFromSuperview];
        }
        self.nonView.frame=self.ScrollView.frame;
        [self.ScrollView addSubview: self.nonView];
    }
    else
    {
        //----begin  删除 父视图中的所有子视图-----------------///
        NSArray *views = [self.ScrollView subviews];
        for( UIView * view in views)
        {
            [view removeFromSuperview];
        }
        /////------------end-----------------///
        
        for (int i=0; i<dataArr.count; i++) {
            AddressListCellViewController * addcell = [[AddressListCellViewController alloc]init];
            addcell.delegate =self;
            addcell.shipaddr =(ShipAddressEntity*)dataArr[i];
            if (i==0) {
                addcell.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 150);
            }
            else
            {
                addcell.view.frame = CGRectMake(0, i*(150+1), self.view.frame.size.width, 150);
            }
            [mtarr addObject:addcell];
            [self.ScrollView addSubview:addcell.view];
        }
    }
    [self initframe];
}
-(void)initframe
{
    self.addView.frame =CGRectMake(0, self.view.frame.size.height-77, self.view.frame.size.width, 77);
    self.ScrollView.frame=CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60-77);
    if (addrList.count>0) {
        self.ScrollView.contentSize = CGSizeMake(self.view.frame.size.width, addrList.count*(151));
    }
}
#pragma mark - 实现AddressListCellDelegate 方法
//删除地址
-(void)godeleteAddr:(ShipAddressEntity *)shipaddress
{

    MsgReturn *msgReturn=[[MsgReturn alloc]init];
    
    msgReturn.errorCode=@"0045";//是否确认删除
    [PromptError changeShowErrorMsg:msgReturn title:@"收货地址"  viewController:self block:^(BOOL OKCancel)
     {
         if (OKCancel) {
             [self request0013:shipaddress.addressId];
         }else
         {
             
         }
         return ;
     }
     ];
}

-(void)goAddressDetail:(ShipAddressEntity *)shipaddress
{
    
    NewAddressViewController* newaddr = [[NewAddressViewController alloc]init];
    newaddr.shipaddr=shipaddress;
    newaddr.isModifyAddress=true;
  
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newaddr animated:YES];


}


#pragma mark - 点击事件
- (IBAction)goAddNewAddr:(id)sender {
    
    SignServiceEntity* signServiceEty = [[SignServiceEntity alloc]init];
    SqlQuerySignService *sqlService =[[SqlQuerySignService alloc]init];
    signServiceEty = [sqlService querySignServiceWithKey:@"MAXADDRESSNUM"];
    
    if (addrList.count>=[signServiceEty.serviceValue intValue]) {
        MsgReturn * msgReturn =[[MsgReturn alloc]init];
        msgReturn.errorCode=@"0034";
        [PromptError changeShowErrorMsg:msgReturn title:@"添加地址"  viewController:self block:^(BOOL OKCancel){}];
    }
    else
    {
        NewAddressViewController* newaddr = [[NewAddressViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:newaddr animated:YES];
    }
}

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
