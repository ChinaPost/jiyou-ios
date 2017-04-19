//
//  ReservationCellViewController.m
//  Philately
//
//  Created by Mirror on 15/7/6.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "ReservationCellViewController.h"
#import "ServiceEntity.h"
#import "SqlQueryService.h"

@interface ReservationCellViewController ()

@end

@implementation ReservationCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initcell:(ReservationEntity*)Ety
{
    NSString *bookname =Ety.bookName ;
    NSString *marginamount =[NSString stringWithFormat:@"￥%.0f",[Ety.marginAmount doubleValue]];
    NSString *limitnum =[NSString stringWithFormat:@"%@套",Ety.limitNum];
    NSString *otheramount =[NSString stringWithFormat:@"￥%.0f",[Ety.otherAmount doubleValue]] ;
    NSString *flag =Ety.flag;
    NSString *bookamount =[NSString stringWithFormat:@"￥%.0f",[Ety.bookAmount doubleValue]];
    
    ServiceEntity *ety = [[ServiceEntity alloc]init];
    SqlQueryService * service = [[SqlQueryService alloc]init];
    ety = [service queryServiceWithKey:@"LOTTERYTYPE" withcode:flag];
    
    
    NSLog(@"bookname:%@,marginamount:%@,limitnum:%@,otheramount:%@,flag:%@,bookamount:%@",bookname,marginamount,limitnum,otheramount,flag,bookamount);
    
    self.lbTypeName.text = bookname ;
    self.lbBaoZhengMoney.text =marginamount;
    self.lbMaxNum.text =limitnum;
    self.lbOtherMoney.text = otheramount;
    self.lbYaoHaoType.text =ety.serviceName;
    self.lbYuDingMoney.text=bookamount;

}

@end
