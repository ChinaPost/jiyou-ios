//
//  ReservationViewController.m
//  Philately
//
//  Created by Mirror on 15/6/26.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "ReservationViewController.h"

#import "ReservationEntity.h"

#import "SVProgressHUD.h"
#import "SysBaseInfo.h"
#import "CstmMsg.h"

@interface ReservationViewController ()

@end

@implementation ReservationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbtitle.text=@"预订资格查询";
    dataList = [NSMutableArray array];
    [self query];
    

}

-(void)bindData
{
    
    int count = (int)dataList.count;

    if (count>0) {
        self.navigationController.navigationBarHidden=YES;
        mtarr =[NSMutableArray array];
        ReservationCellViewController *recell;
        for (int i=0; i<count; i++) {
            recell = [[ReservationCellViewController alloc]init];
            if (i==0) {
                recell.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 100);
            }
            else
            {
                recell.view.frame = CGRectMake(0, i*(100+1), self.view.frame.size.width, 100);
            }
            [recell initcell:dataList[i]];
            [mtarr addObject:recell];
            [self.scrollView addSubview:recell.view];
        }
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, mtarr.count*(101));

    } else
    {
        self.NonTableView.frame =CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60);
        [self.view addSubview: self.NonTableView];
        self.scrollView.hidden = YES;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.scrollView.frame =CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60);
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, mtarr.count*(101));
}
#pragma mark - 预订资格查询
NSString* n0015 =@"JY0015";
-(void)query
{
    CstmMsg *_cstmmsg = [CstmMsg sharedInstance];
    SysBaseInfo *_sysBaseInfo = [SysBaseInfo sharedInstance];
    
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    [para setValue:_cstmmsg.cstmNo forKey:@"cstmNo"];
    
    StampTranCall * stampTranCall =[StampTranCall sharedInstance];
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmmsg formName:n0015 business:para delegate:self viewController:self];
}

-(void)ReturnData:(MsgReturn *)msgReturn
{
    [SVProgressHUD dismiss];
    
    if(msgReturn.map==nil)
        return;
    
    NSLog(@"0015 %lu",(unsigned long)[msgReturn.map count]);
    NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
    NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
    NSString *respDesc=[returnHead objectForKey:@"respDesc"];
    NSString *respCode=[returnHead objectForKey:@"respCode"];
    NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
    
    int recordNum =[[returnDataBody objectForKey:@"recordNum"] intValue];
    
    for (int i=0; i<recordNum; i++) {
        ReservationEntity *reservationEntity =[[ReservationEntity alloc]init];
        reservationEntity.bookType = [returnDataBody objectForKey:@"bookType"][i];
        reservationEntity.bookName = [returnDataBody objectForKey:@"bookName"][i];
        reservationEntity.bookAmount = [returnDataBody objectForKey:@"bookAmount"][i];
        reservationEntity.marginAmount = [returnDataBody objectForKey:@"marginAmount"][i];
        reservationEntity.otherAmount = [returnDataBody objectForKey:@"otherAmount"][i];
        reservationEntity.limitNum = [returnDataBody objectForKey:@"limitNum"][i];
        reservationEntity.flag = [returnDataBody objectForKey:@"flag"][i];
        [dataList addObject:reservationEntity];
    }
    [self bindData];
}


-(void)ReturnError:(MsgReturn *)msgReturn
{
    [SVProgressHUD dismiss];
    
}




#pragma mark -返回事件

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
