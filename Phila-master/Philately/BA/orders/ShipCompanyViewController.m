//
//  ShipCompanyViewController.m
//  Philately
//
//  Created by Mirror on 15/7/20.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "ShipCompanyViewController.h"



#import "SqlQueryService.h"
#import "ServiceEntity.h"

@interface ShipCompanyViewController ()

@end

@implementation ShipCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataList =[NSMutableArray array];
    [self initData];
    UITapGestureRecognizer* tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
    [self.view addGestureRecognizer:tap];
}
-(void)click
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData
{
    mtarr =[NSMutableArray array];
    SqlQueryService* service =[[SqlQueryService alloc]init];
    dataList = [service queryServiceWithKey:@"LOGISTCOMPANY"];
    for (int i=0; i<dataList.count; i++) {
        
        ShipCompanyCellViewController *shipcellview=[[ShipCompanyCellViewController alloc]init];
        if (i==0) {
            shipcellview.view.frame = CGRectMake(0, 2, self.view.frame.size.width, 40);
        }
        else
        {
             shipcellview.view.frame = CGRectMake(0, 2+i*(40+2), self.view.frame.size.width, 40);
        }
        [shipcellview initData:dataList[i]];
        shipcellview.getShipCompany=^(NSString*name){
        
            if (self.refreshCompany) {
                self.refreshCompany(name);
            }
            
            [self dismissViewControllerAnimated:YES completion:^{
            }];
            
        };        
        [mtarr addObject:shipcellview];
        [self.scrollView addSubview:shipcellview.view];
    }
    [self initframe];
}
-(void)initframe
{
    self.basicView.frame=CGRectMake(0, 60, self.view.frame.size.width, 40);
    self.scrollView.frame =CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-100);
    if (dataList.count>0) {
        self.scrollView.contentSize =CGSizeMake(self.view.frame.size.width, self.basicView.frame.size.height+dataList.count*40);
    }
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self initframe];
}


@end
