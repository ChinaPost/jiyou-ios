//
//  MyReplaceOrdersViewController.m
//  Philately
//
//  Created by Mirror on 15/6/30.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "MyReplaceOrdersViewController.h"
#import "ReplaceOrderViewController.h"
#import "MyReplaceOrderCellViewController.h"
#import "ReplaceOrderApplicationViewController.h"
#import "OrderTrackViewController.h"

@interface MyReplaceOrdersViewController ()

@end

@implementation MyReplaceOrdersViewController

static int pagenum = 10;
static int pagecode = 1;
static int totalnum =0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.ScrollView.delegate =self;
    dataList =[NSMutableArray array];
    pagecode =1;
    [self queryOrder];
}

-(void)bindData
{
    mtarr =[NSMutableArray array];
    if (dataList.count==0) {
        self.nonView.frame=self.ScrollView.frame;
        [self.ScrollView addSubview: self.nonView];
    }
    else
    {
        for (int i =0; i<dataList.count; i++) {
            MyReplaceOrderCellViewController *myReplaceOrderCell =[[MyReplaceOrderCellViewController alloc]init];
            if (i==0) {
                myReplaceOrderCell.view.frame =CGRectMake(0, 0, self.view.frame.size.width, 120);
            }
            else
            {
                myReplaceOrderCell.view.frame =CGRectMake(0, i*(120+5), self.view.frame.size.width, 120);
            }
            
            myReplaceOrderCell.gotoHistory=^(NSString* strorderNO,NSString* isReplacing)
            {//换货记录
                ReplaceOrderViewController * replaceOrderView = [[ReplaceOrderViewController alloc]init];
                replaceOrderView.status = isReplacing;
                replaceOrderView.orderNo =strorderNO;
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:replaceOrderView animated:YES];
            };
            myReplaceOrderCell.gotoReplaceOrder=^(NSString* strorderNO)
            {//我的换货
                orderNo =strorderNO;
                [self gotoAppliction];
            };
            [myReplaceOrderCell initData:dataList[i]];
            [mtarr addObject:myReplaceOrderCell];
            [self.ScrollView addSubview: myReplaceOrderCell.view];
        }
    }
    [self initframe];
}
-(void)initframe
{
    self.ScrollView.frame =CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60);
    if (dataList.count>0) {
        self.ScrollView.contentSize =CGSizeMake(self.view.frame.size.width, dataList.count*(120+5));
    }
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self initframe];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)goback:(id)sender {
//    [self.navigationController popViewControllerAnimated:YES];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 订单详情 获取 已购买商品信息
-(void)gotoAppliction
{
    Request0041 *request0041 =[[Request0041 alloc]init];
    request0041.delegate =self;
    [request0041 request0041:orderNo];
}
-(void)jy0041Result:(NSDictionary *)result
{
    ReplaceOrderApplicationViewController *orderApplication =[[ReplaceOrderApplicationViewController alloc]init];
    orderApplication.orderNo=orderNo;
    orderApplication.resultData=result;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:orderApplication animated:YES];
}

#pragma mark - 订单查询 与 返回处理方法
-(void)queryOrder
{
    NSString * n0040 =@"JY0040";
    CstmMsg *_cstmmsg = [CstmMsg sharedInstance];
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    [para setValue:_cstmmsg.cstmNo forKey:@"cstmNo"];
    [para setValue:@"" forKey:@"orderNo"];
    [para setValue:@"" forKey:@"busiNo"];
    [para setValue:@"0" forKey:@"orderStatusNum"];
    [para setValue:@"" forKey:@"startDate"];
    [para setValue:@"" forKey:@"endDate"];
    [para setValue:@"" forKey:@"channelNo"];
    [para setValue:@"" forKey:@"payType"];
    [para setValue:@"2" forKey:@"sortType"];
    [para setValue:@"0" forKey:@"sortFieldID"];
    [para setValue:@"1" forKey:@"queryTypeFlag"];
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
        
        NSLog(@"0040 %lu",(unsigned long)[msgReturn.map count]);
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
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
