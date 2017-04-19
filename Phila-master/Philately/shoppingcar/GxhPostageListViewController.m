//
//  GxhPostageListViewController.m
//  Philately
//
//  Created by Mirror on 15/8/20.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "GxhPostageListViewController.h"
#import "GxhPostageListCellViewController.h"


#import "PromptError.h"
#import "SysBaseInfo.h"
#import "SVProgressHUD.h"

#import "SqlQueryService.h"
#import "ServiceEntity.h"

@interface GxhPostageListViewController ()

@end

@implementation GxhPostageListViewController

@synthesize orderNo;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbtitle.text =@"个性化定制审核结果";
    
    datalist =[NSMutableArray array];
    [self query0061];
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.ScrollView.frame =CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height-60);
    self.ScrollView.contentSize=CGSizeMake(self.view.bounds.size.width, datalist.count*(130));
}

#pragma mark - 个性化定制审核结果查询 与 返回处理方法
NSString * n0061 =@"JY0061";
-(void)query0061
{
    CstmMsg *_cstmmsg = [CstmMsg sharedInstance];
    
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    
    [para setValue:_cstmmsg.cstmNo forKey:@"cstmNo"];
    [para setValue:orderNo==nil?@"":orderNo forKey:@"prepNumber"];
    
    SysBaseInfo *_sysBaseInfo = [SysBaseInfo sharedInstance];
    StampTranCall * stampTranCall = [StampTranCall sharedInstance];
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmmsg formName:n0061 business:para delegate:self viewController:self];
    
}

-(void) ReturnData:(MsgReturn*)msgReturn
{
    [SVProgressHUD dismiss];
    if ([msgReturn.formName isEqual:n0061]) {
        if(msgReturn.map==nil)
            return;
        
        NSLog(@"0061 %lu",(unsigned long)[msgReturn.map count]);
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];

        RespondParam0061* ety0061 =[[RespondParam0061 alloc]init];
        ety0061.checkId =[[returnDataBody objectForKey:@"checkId"]intValue];;
        ety0061.orderId =[returnDataBody objectForKey:@"orderId"];
        ety0061.status =[[returnDataBody objectForKey:@"status"]intValue];;
        ety0061.checkContent =[returnDataBody objectForKey:@"checkContent"];
        ety0061.createTime =[returnDataBody objectForKey:@"createTime"];
        ety0061.updateTime =[returnDataBody objectForKey:@"updateTime"];
        ety0061.packageStatus =[returnDataBody objectForKey:@"packageStatus"];
        [datalist addObject:ety0061];

        [self bindData];
    }
}
-(void) ReturnError:(MsgReturn*)msgReturn
{
    [SVProgressHUD dismiss];
}

-(void)bindData
{
    cellarr =[NSMutableArray array];
    if (datalist.count==0) {
        [self.lbnon setHidden:NO];
    }
    else{
        [self.lbnon setHidden:YES];
        for (int i = 0; i<datalist.count; i++) {

            GxhPostageListCellViewController* Cell = [[GxhPostageListCellViewController alloc]init];
            if (i==0) {
               Cell.view.frame  = CGRectMake(0, 0, self.view.frame.size.width, 125);
            }
            else
            {
                Cell.view.frame = CGRectMake(0, i*(125 +5), self.view.frame.size.width, 125);
            }
            
            [Cell initCell:datalist[i]];
            [cellarr addObject:Cell];
            [self.ScrollView addSubview:Cell.view];
        }
        self.ScrollView.contentSize=CGSizeMake(self.view.frame.size.width, datalist.count*(130));
    }
}

- (IBAction)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
