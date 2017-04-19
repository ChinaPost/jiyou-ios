//
//  MyReplaceOrderCellViewController.m
//  Philately
//
//  Created by Mirror on 15/6/30.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "MyReplaceOrderCellViewController.h"

#import "SqlQueryService.h"
#import "ServiceEntity.h"

@interface MyReplaceOrderCellViewController ()

@end

@implementation MyReplaceOrderCellViewController
@synthesize isReplacing;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.       
}

-(void)initData:(RespondParam0040*)Ety
{
    NSString *strdate = ([Ety.bookDate isKindOfClass:[NSNull class]])?@"":Ety.bookDate;
    if ([strdate isEqual:@""]) {
        self.lbcreateTime.text =@"";
    }
    else
    {
        NSString* year = [strdate substringToIndex:4];
        NSString* mon =[strdate substringWithRange:NSMakeRange(5, 2)];
        NSString* day =[strdate substringWithRange:NSMakeRange(8, 2)];
        NSString* createDate =[NSString stringWithFormat:@"%@年%@月%@日",year,mon,day];
        self.lbcreateTime.text =createDate;
    }
    self.lborderNo.text = Ety.orderNo;
    self.lborderMoney.text =[NSString stringWithFormat:@"￥%.2f",Ety.orderAmt];
    
    isReplacing =Ety.isReplacing;
    ServiceEntity* serviceEty = [[ServiceEntity alloc]init];
    SqlQueryService* service = [[SqlQueryService alloc]init];
    serviceEty = [service queryServiceWithKey:@"ISREPLACING" withcode:isReplacing];
    NSString *Status = serviceEty.serviceName;
    self.lbStatus.text = Status;
       
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goHistory:(id)sender {
    if (self.gotoHistory) {
        self.gotoHistory(self.lborderNo.text,isReplacing);
    }
}

- (IBAction)goReplaceOrder:(id)sender {
    if (self.gotoReplaceOrder) {
        self.gotoReplaceOrder(self.lborderNo.text);
    }
}
@end
