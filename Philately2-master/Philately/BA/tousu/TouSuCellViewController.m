//
//  touSuCellViewController.m
//  Philately
//
//  Created by Mirror on 15/6/27.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "TouSuCellViewController.h"
#import "SqlQueryService.h"
#import "TouSuDetailViewController.h"

@interface TouSuCellViewController ()
-(void)clickdown:(NSString*)car;
@end

@implementation TouSuCellViewController
@synthesize complaintOrderEty;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    UITapGestureRecognizer *clickDownGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickdown)];
    [self.view addGestureRecognizer:clickDownGesture];    
    
}
-(void)initcell:(ComplaintOrderEntity*)Ety
{
    self.lbcomplaintNo.text =Ety.complaintNo;
    self.lblinkOrderNo.text =Ety.orderNo;
    self.lbcomplaintContent.text =Ety.complaintContent;
    NSString *status = Ety.complaintStatus;
    ServiceEntity *serviceEty = [[ServiceEntity alloc]init];
    SqlQueryService *service = [[SqlQueryService alloc]init];
    serviceEty = [service queryServiceWithKey:@"COMPLAINTSTATUS" withcode:status];
    self.lbstatus.text = serviceEty.serviceName;
    
    NSString *strdate = ([Ety.complaintTime isKindOfClass:[NSNull class]])?@"":Ety.complaintTime;
    if ([strdate isEqual:@""]) {
        self.lbtouSuDate.text =@"";//投诉时间
    }
    else
    {
        NSString* year = [strdate substringToIndex:4];
        NSString* mon =[strdate substringWithRange:NSMakeRange(5, 2)];
        NSString* day =[strdate substringWithRange:NSMakeRange(8, 2)];
        NSString* hour =[strdate substringWithRange:NSMakeRange(11, 2)];
        NSString* mini =[strdate substringWithRange:NSMakeRange(14, 2)];
        NSString* createDate =[NSString stringWithFormat:@"%@-%@-%@ %@:%@",year,mon,day,hour,mini];
        
        self.lbtouSuDate.text =createDate;//投诉时间
    }
    
    self.complaintOrderEty = Ety;
}
-(void)clickdown
{
    if (self.delegate) {
        [self.delegate goTouSuDetail:complaintOrderEty];
    }
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
