//
//  touSuDetailViewController.m
//  Philately
//
//  Created by Mirror on 15/6/27.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "TouSuDetailViewController.h"
#import "ServiceEntity.h"
#import "SqlQueryService.h"
#import "TouSuListViewController.h"

@interface TouSuDetailViewController ()

@end

@implementation TouSuDetailViewController
@synthesize complaintOrderEty;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbtitle.text =@"投诉详情";
    [self initData:complaintOrderEty];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData:(ComplaintOrderEntity*)Ety
{
    self.tfreason.editable =NO;
    self.tfcomplaintContent.editable =NO;
    
    self.lbcomplaintNo.text = Ety.complaintNo;
    self.lblinkOrderNo.text =Ety.orderNo;
    NSString *strdate = ([Ety.complaintTime isKindOfClass:[NSNull class]])?@"":Ety.complaintTime;
    if ([strdate isEqual:@""]) {
        self.lbtousudate.text =@"";//投诉时间
    }
    else
    {
        NSString* year = [strdate substringToIndex:4];
        NSString* mon =[strdate substringWithRange:NSMakeRange(5, 2)];
        NSString* day =[strdate substringWithRange:NSMakeRange(8, 2)];
        NSString* hour =[strdate substringWithRange:NSMakeRange(11, 2)];
        NSString* mini =[strdate substringWithRange:NSMakeRange(14, 2)];
        NSString* createDate =[NSString stringWithFormat:@"%@年%@月%@日%@:%@",year,mon,day,hour,mini];
        
        self.lbtousudate.text =createDate;//投诉时间
    }
    self.lbcstmName.text = Ety.cstmName;
    self.lbmobile.text = Ety.cstmPhone;
    
    self.tfcomplaintContent.text = Ety.complaintContent;//投诉内容
    self.tfreason.text = [NSString stringWithFormat:@"%@ %@",Ety.opinionContent,Ety.opinionTime];//投诉处理说明
    
    NSString *status = Ety.complaintStatus;
    ServiceEntity *serviceEty = [[ServiceEntity alloc]init];
    SqlQueryService *service = [[SqlQueryService alloc]init];
    serviceEty = [service queryServiceWithKey:@"COMPLAINTSTATUS" withcode:status];
    self.lbstatus.text = serviceEty.serviceName;
    
    
    if ([status isEqual:@"1"]) {
        [self.btnCancel setHidden:NO];//处理中
    }
    else
    {
        [self.btnCancel setHidden:YES];//隐藏
        self.tferrReason.text =Ety.errorReason;
    }
    [self initframe];
}

-(void)initframe
{
    self.basicView.frame =CGRectMake(0, 0, self.view.frame.size.width, 440);
    [self.scrollView addSubview:self.basicView];
    
    self.errReasonView.frame =CGRectMake(0, 470, self.view.frame.size.width, 100);
        
    
    self.scrollView.frame =CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60);
    
    if ([complaintOrderEty.complaintStatus  isEqual: @"0"]) {//处理失败
        
        [self.scrollView addSubview:self.errReasonView];
        self.scrollView.contentSize =CGSizeMake(self.view.frame.size.width, self.basicView.frame.size.height+self.errReasonView.frame.size.height+180);
    }
    else
    {
        self.scrollView.contentSize =CGSizeMake(self.view.frame.size.width, self.basicView.frame.size.height+10);
    }
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self initframe];
}

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)doCancel:(id)sender {
    
    MsgReturn *msgReturn = [[MsgReturn alloc]init];
    msgReturn.errorCode=@"0042";//是否确认取消本条投诉单
    [PromptError changeShowErrorMsg:msgReturn title:@"收货地址"  viewController:self block:^(BOOL OKCancel)
     {
         if (OKCancel) {
             [self CancelTouSu];
         }else
         {
             
         }
         return ;
     }
     ];

    
    
    
    
    
}
#pragma mark - 取消投诉 与 返回处理方法
NSString * n0062 =@"JY0062";
-(void)CancelTouSu
{
    CstmMsg *_cstmmsg = [CstmMsg sharedInstance];
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    [para setValue:complaintOrderEty.complaintNo forKey:@"complaintNo"];
    
    SysBaseInfo *_sysBaseInfo = [SysBaseInfo sharedInstance];
    StampTranCall * stampTranCall = [StampTranCall sharedInstance];
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmmsg formName:n0062 business:para delegate:self viewController:self];
    
}

-(void) ReturnData:(MsgReturn*)msgReturn
{
    [SVProgressHUD dismiss];
    if ([msgReturn.formName isEqual:n0062]) {
        if(msgReturn.map==nil)
            return;
        
        NSLog(@"0062 %lu",(unsigned long)[msgReturn.map count]);

        
        for (UIViewController* uiview in self.navigationController.viewControllers)
        {
            if ([uiview isKindOfClass:[TouSuListViewController class]]) {
                [((TouSuListViewController*)uiview) viewDidLoad];
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
