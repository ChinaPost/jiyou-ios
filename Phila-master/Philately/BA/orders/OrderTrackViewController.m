//
//  OrderTrackViewController.m
//  Philately
//
//  Created by Mirror on 15/6/29.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "OrderTrackViewController.h"
#import "OrderTrackDetailCellViewController.h"

@implementation ShipmentInfo
@synthesize remark;
@synthesize acceptTime;
@synthesize acceptAddr;
@synthesize source;

@end

@interface OrderTrackViewController ()

@end

@implementation OrderTrackViewController
@synthesize resultData;

- (void)viewDidLoad {
    [super viewDidLoad];

    dataList =[NSMutableArray array];
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)initData
{
    [dataList removeAllObjects];
    int logisticsNum = [[resultData objectForKey:@"logisticsNum"]intValue];
    for (int i =0; i<logisticsNum; i++) {
        ShipmentInfo * shipmentInfo =[[ShipmentInfo alloc]init];
        NSString* source =[resultData objectForKey:@"source"][i];
        NSString* acceptTime =[resultData objectForKey:@"acceptTime"][i];
        NSString* acceptAddr =[resultData objectForKey:@"acceptAddr"][i];
        NSString* remark =[resultData objectForKey:@"remark"][i];
        
        shipmentInfo.source =source;
        shipmentInfo.acceptAddr=acceptAddr;
        shipmentInfo.acceptTime =acceptTime;
        shipmentInfo.remark =remark;
        [dataList addObject:shipmentInfo];
    }
    NSString* orderNo =[resultData objectForKey:@"orderNo"];
    self.lborderNo.text =orderNo;
    if (dataList.count>0) {
        self.lbremark.text =((ShipmentInfo*)dataList[0]).source;
    }
    else
    {
        self.lbremark.text =@"";
    }
    [self initFrame];
}

-(void)initFrame
{
    mtarray = [NSMutableArray array];
    for (int i = 0; i<dataList.count; i++) {
                    
        OrderTrackDetailCellViewController *orderTackDetailcell =[[OrderTrackDetailCellViewController alloc] init];
        NSString* flag = @"0";
        if (i==0) {
            orderTackDetailcell.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 70);
            flag = @"1";
        }
        else
        {
            orderTackDetailcell.view.frame = CGRectMake(0, i*(70+1), self.view.bounds.size.width, 70);
            flag = @"0";
        }
        
        [mtarray addObject:orderTackDetailcell];
        [orderTackDetailcell initData:dataList[i] withFlag:flag];
        [self.ScrollView addSubview: orderTackDetailcell.view];
     }
    self.ScrollView.contentSize =CGSizeMake(self.view.frame.size.width, dataList.count*71);
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.ScrollView.contentSize =CGSizeMake(self.view.bounds.size.width, dataList.count*71+20);
    self.ScrollView.frame =CGRectMake(0, 60+self.basicview.frame.size.height+self.wuliuview.frame.size.height+2, self.view.bounds.size.width, self.view.bounds.size.height -60-self.basicview.frame.size.height-self.wuliuview.frame.size.height);
    
}



- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}
@end
