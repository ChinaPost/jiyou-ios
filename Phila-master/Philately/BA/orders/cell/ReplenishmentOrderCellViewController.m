//
//  ReplenishmentOrderCellViewController.m
//  Philately
//
//  Created by Mirror on 15/6/30.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "ReplenishmentOrderCellViewController.h"
#import "OrderTrackViewController.h"
#import "SqlQueryService.h"
#import "ServiceEntity.h"


@interface ReplenishmentOrderCellViewController ()

@end

@implementation ReplenishmentOrderCellViewController

@synthesize orderEty;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.btnpay.layer.borderColor =(__bridge CGColorRef)([UIColor colorWithRed:253.0/255.0 green:95.0/255.0 blue:40.0/255.0 alpha:1.0]);
    self.btnpay.layer.borderWidth =1.0;
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goOrderDetail)];
    [self.detailView addGestureRecognizer:tap];
    
}

-(void)initData:(RespondParam0040*)Ety
{
    self.orderEty =Ety;
    ServiceEntity* serviceEty = [[ServiceEntity alloc]init];
    SqlQueryService* service = [[SqlQueryService alloc]init];
    serviceEty = [service queryServiceWithKey:@"FUNDFLAG" withcode:Ety.changeType];
    NSString* fund = serviceEty.serviceName; // 退款/补款
    self.lbbukuan.text =[NSString stringWithFormat:@"【%@】",fund];
    self.lbmoney.text = [NSString stringWithFormat:@"￥%.2f",[Ety.changeAmount floatValue] ];
    self.lborderMoney.text =[NSString stringWithFormat:@"￥%.2f",Ety.orderAmt ];
    self.lborderNo.text = Ety.orderNo;
    
    serviceEty = [service queryServiceWithKey:@"REPAIRSTATUS" withcode:Ety.changeStatus];
    NSString *Status = serviceEty.serviceName;
    self.lbstatus.text = Status;
    
    if ([Ety.changeType isEqualToString:@"2"]&&[Ety.changeStatus isEqualToString:@"01"]) {
        [self.btnpay setHidden:NO];//补款 并且未支付 则 显示 去支付
    }
    else
    {
        [self.btnpay setHidden:YES];
    }
    
}

-(void) goOrderDetail
{

    if (self.gotoDetail) {
        self.gotoDetail(orderEty.orderNo);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)gotoPay:(id)sender {
    if (self.goPay) {
        self.goPay(orderEty);
    }
}
@end
