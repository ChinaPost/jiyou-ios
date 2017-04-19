//
//  MyYaoHaoViewController.m
//  Philately
//
//  Created by Mirror on 15/7/18.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "MyYaoHaoViewController.h"
#import "MyYaoHaoCellViewController.h"
#import "OrderFormDetailViewController.h"
@interface MyYaoHaoViewController ()

@end

@implementation MyYaoHaoViewController
static int pagenum = 10;
static int pagecode = 1;
static int totalnum =0;

- (void)viewDidLoad {
    [super viewDidLoad];


    dataList =[NSMutableArray array];
    
    self.scrollView.delegate =self;
    pagecode =1;
    [self queryOrder];

}
-(void)bindData
{
    mtarr =[NSMutableArray array];
    if (dataList.count==0) {
        self.nonview.frame=self.scrollView.frame;
        [self.scrollView addSubview: self.nonview];
    }
    else {
        for (int i=0; i<dataList.count; i++) {
                MyYaoHaoCellViewController * yaoHaoCell =[[MyYaoHaoCellViewController alloc]init];
                if (i==0) {
                    yaoHaoCell.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 50);
                }
                else
                {
                    yaoHaoCell.view.frame = CGRectMake(0, i*(50 +2), self.view.frame.size.width, 50);
                }
                
                yaoHaoCell.goOrderDetail=^(NSString* orderNO){
                    OrderFormDetailViewController* orderDetailView =[[OrderFormDetailViewController alloc]init];
                    orderDetailView.orderNo= orderNO;
                    self.hidesBottomBarWhenPushed=YES;
                    [self.navigationController pushViewController:orderDetailView animated:YES];
                    
                };
            [yaoHaoCell initData:((RespondParam0040*)dataList[i]).orderNo withStatus:((RespondParam0040*)dataList[i]).dealStatus];
            [mtarr addObject:yaoHaoCell];
            [self.scrollView addSubview: yaoHaoCell.view];
        }
        
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, dataList.count*(50+2));
    }
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.scrollView.frame =CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60);
    self.scrollView.contentSize =CGSizeMake(self.view.frame.size.width, dataList.count*(50+2));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 返回事件
- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 查询摇号 与 返回处理方法
-(void)queryOrder
{
    NSString * n0040 =@"JY0040";
    CstmMsg *_cstmmsg = [CstmMsg sharedInstance];
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    [para setValue:_cstmmsg.cstmNo forKey:@"cstmNo"];
    [para setValue:@"" forKey:@"orderNo"];
    [para setValue:@"" forKey:@"busiNo"];
    [para setValue:@"1" forKey:@"orderStatusNum"];
    NSArray* orderstatus =@[@"01"];
    [para setValue:orderstatus forKey:@"orderStatus"];
    [para setValue:@"" forKey:@"startDate"];
    [para setValue:@"" forKey:@"endDate"];
    [para setValue:@"" forKey:@"channelNo"];
    [para setValue:@"" forKey:@"payType"];
    [para setValue:@"2" forKey:@"sortType"];
    [para setValue:@"0" forKey:@"sortFieldID"];
    [para setValue:@"" forKey:@"queryTypeFlag"];
    [para setValue:@"" forKey:@"fundFlag"];
    [para setValue:[NSString stringWithFormat:@"%d",pagecode] forKey:@"pageCode"];
    [para setValue:[NSString stringWithFormat:@"%d",pagenum] forKey:@"pageNum"];
    
    SysBaseInfo *_sysBaseInfo = [SysBaseInfo sharedInstance];
    StampTranCall * stampTranCall = [StampTranCall sharedInstance];
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmmsg formName:n0040 business:para delegate:self viewController:self];
    
}
-(void) ReturnData:(MsgReturn*)msgReturn
{
    [SVProgressHUD dismiss];
    if ([msgReturn.formName isEqual:@"JY0040"]) {
        if(msgReturn.map==nil)
            return;
        [dataList removeAllObjects];
        NSLog(@"0040 %lu",(unsigned long)[msgReturn.map count]);
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        
        totalnum = [[returnDataBody objectForKey:@"totalNum"] intValue];
        int recordNum =[[returnDataBody objectForKey:@"recordNum"] intValue];
        for (int i=0; i<recordNum; i++) {
            orderEty = [[RespondParam0040 alloc]init];
            orderEty.orderNo =[returnDataBody objectForKey:@"orderNo"][i];
            orderEty.busiNo =[returnDataBody objectForKey:@"busiNo"][i];
            orderEty.orderAmt =[[returnDataBody objectForKey:@"orderAmt"][i] floatValue];
            orderEty.bookDate =[returnDataBody objectForKey:@"bookDate"][i];
            orderEty.payStatus =[returnDataBody objectForKey:@"payStatus"][i];
            orderEty.dealStatus =[returnDataBody objectForKey:@"dealStatus"][i];
            orderEty.channelNo =[returnDataBody objectForKey:@"channelNo"][i];
            orderEty.isReplacing =[returnDataBody objectForKey:@"isReplacing"][i];
            orderEty.changeType =[returnDataBody objectForKey:@"changeType"][i];
            orderEty.changeAmount =[returnDataBody objectForKey:@"changeAmount"][i];
            orderEty.changeStatus =[returnDataBody objectForKey:@"changeStatus"][i];
            [dataList addObject:orderEty];
        }
        [self bindData];
    }
}
-(void) ReturnError:(MsgReturn*)msgReturn
{
    [SVProgressHUD dismiss];
}
#pragma mark -scrollview 滑动到底部触发事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView

{
    
    CGPoint offset = scrollView.contentOffset;
    
    
    
    CGRect bounds = scrollView.bounds;
    
    
    
    CGSize size = scrollView.contentSize;
    
    
    
    UIEdgeInsets inset = scrollView.contentInset;
    
    
    
    CGFloat currentOffset = offset.y + bounds.size.height - inset.bottom;
    
    
    
    CGFloat maximumOffset = size.height;
    
    
    
    //当currentOffset与maximumOffset的值相等时，说明scrollview已经滑到底部了。也可以根据这两个值的差来让他做点其他的什么事情
    
    
    
    if(currentOffset==maximumOffset)
    {
        
        NSLog(@"-----我要刷新数据-----");
        if(totalnum % pagenum == 0)
        {
            if (pagecode<totalnum/pagenum) {
                pagecode =pagecode+1;
                [self queryOrder];
            }
        }
        else
        {
            if (pagecode<totalnum/pagenum+1) {
                pagecode =pagecode+1;
                [self queryOrder];
            }
        }
        
        
        
    }
    
}

@end
