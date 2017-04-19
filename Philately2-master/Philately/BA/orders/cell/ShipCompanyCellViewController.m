//
//  ShipCompanyCellViewController.m
//  Philately
//
//  Created by Mirror on 15/7/20.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "ShipCompanyCellViewController.h"


@interface ShipCompanyCellViewController ()

@end

@implementation ShipCompanyCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITapGestureRecognizer* tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectCompany)];
    [self.companyView addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];    
}

-(void)selectCompany
{
    if (self.getShipCompany) {
        self.getShipCompany(name);
    }
}
-(void)initData:(ServiceEntity*)Ety
{
    self.lbname.text=Ety.serviceName;
    code =Ety.serviceCode;
    name=Ety.serviceName;
}

@end
