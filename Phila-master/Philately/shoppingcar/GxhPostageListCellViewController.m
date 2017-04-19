//
//  GxhPostageListCellViewController.m
//  Philately
//
//  Created by gdpost on 15/8/24.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "GxhPostageListCellViewController.h"
#import "SqlQueryService.h"
#import "ServiceEntity.h"


@interface GxhPostageListCellViewController ()

@end

@implementation GxhPostageListCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initCell:(RespondParam0061*)ety
{
    SqlQueryService* service =[[SqlQueryService alloc]init];
    ServiceEntity* serviceEty = [service queryServiceWithKey:@"GXHCHECKSTATUS" withcode:[NSString stringWithFormat:@"%d",ety.status]];
    
    self.lborderno.text = ety.orderId;
    self.lbstatus.text =serviceEty.serviceName;
    self.lbcontent.text= ety.checkContent;
    self.lbdate.text= ety.updateTime;
    
    serviceEty = [service queryServiceWithKey:@"ISPACKAGING" withcode:ety.packageStatus];
    self.lbpackage.text =serviceEty.serviceName;
    
}

@end
