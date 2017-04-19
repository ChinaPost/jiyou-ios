//
//  MyYaoHaoCellViewController.m
//  Philately
//
//  Created by Mirror on 15/7/18.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "MyYaoHaoCellViewController.h"
#import "ServiceEntity.h"
#import "SqlQueryService.h"

@interface MyYaoHaoCellViewController ()

@end

@implementation MyYaoHaoCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer* tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoYaoHaoDetail)];
    [self.view addGestureRecognizer:tap];
}

-(void)initData:(NSString*)orderno withStatus:(NSString*)statuscode
{
    self.lborderNo.text =orderno;
    orderNo = orderno;
    ServiceEntity* serviceEty = [[ServiceEntity alloc]init];
    SqlQueryService* sqlservice =[[SqlQueryService alloc]init];
    serviceEty = [sqlservice queryServiceWithKey:@"ORDERSTATUS" withcode:statuscode];
    self.lbstatus.text= serviceEty.serviceName;
}

-(void)gotoYaoHaoDetail
{
    if(self.goOrderDetail)
    {
        self.goOrderDetail(orderNo);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
