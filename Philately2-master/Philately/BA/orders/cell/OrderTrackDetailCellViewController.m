//
//  OrderTrackDetailCellViewController.m
//  Philately
//
//  Created by Mirror on 15/6/29.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "OrderTrackDetailCellViewController.h"

@interface OrderTrackDetailCellViewController ()

@end

@implementation OrderTrackDetailCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData:(ShipmentInfo*)Ety withFlag:(NSString*)flag
{
    NSArray* imgarr=@[[UIImage imageNamed:@"line02.png"],[UIImage imageNamed:@"line01.png"]];
    self.lbloctaion.text=Ety.acceptAddr;
    self.lbtime.text=Ety.acceptTime;
    if ([flag isEqual:@"0"]) {
        self.img.image =imgarr[0];
    }
    else
    {
         self.img.image =imgarr[1];
        [self.lbloctaion setTextColor:[UIColor colorWithRed:0 green:216 blue:193 alpha:1]];
        [self.lbtime setTextColor:[UIColor colorWithRed:0 green:216 blue:193 alpha:1]];
    }
    
}

@end
