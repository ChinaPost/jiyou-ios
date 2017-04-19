//
//  ReplaceOrderCellViewController.m
//  Philately
//
//  Created by Mirror on 15/6/30.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "ReplaceOrderCellViewController.h"
#import "ServiceEntity.h"
#import "SqlQueryService.h"

@interface ReplaceOrderCellViewController ()

@end

@implementation ReplaceOrderCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
    [self.view addGestureRecognizer:tap];
    
}

-(void)initData:(RespondParam0057*)Ety
{
    replaceOrderEty =Ety;
    self.lbreplaceOrderNo.text= Ety.exchangMerchNo;
    self.lblinkOrderNo.text=Ety.linkOrderNo;
    self.lbcreateTime.text = Ety.applyDate;
    
    ServiceEntity* serviceEty = [[ServiceEntity alloc]init];
    SqlQueryService* sqlservice =[[SqlQueryService alloc]init];
    serviceEty = [sqlservice queryServiceWithKey:@"EXCHAGESTATUS" withcode:Ety.dealStatus];
    self.lbstatus.text= serviceEty.serviceName;
}



-(void)click
{
    if (self.delegate) {
        [self.delegate gotoReplaceDetail:replaceOrderEty];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
