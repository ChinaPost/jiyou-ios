//
//  ReplaceOrderDetailCellViewController.m
//  Philately
//
//  Created by Mirror on 15/7/1.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "ReplaceOrderDetailCellViewController.h"

@interface ReplaceOrderDetailCellViewController ()

@end

@implementation ReplaceOrderDetailCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)initData:(ApplyMerchItems*)Ety
{
    self.lbname.text=[NSString stringWithFormat:@"%@  %@件",Ety.merchName,Ety.merchNum];
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
