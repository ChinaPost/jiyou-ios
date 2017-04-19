//
//  touSuListViewController.m
//  Philately
//
//  Created by Mirror on 15/6/27.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "TouSuListViewController.h"
#import "TouSuDetailViewController.h"
#import "MenberMainViewController.h"
#import "TouSuShengQingViewController.h"

#import "PromptError.h"
#import "SysBaseInfo.h"
#import "SVProgressHUD.h"

#import "FirstPageViewController.h"
#import "ShoppingCarViewController.h"

#import "AppDelegate.h"

@interface TouSuListViewController ()

@end


@implementation TouSuListViewController
@synthesize  flag;
@synthesize orderNo;

static int pagenum = 4;
static int pagecode = 1;
static int totalnum =0;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.lbtitle.text =@"投诉列表";
    self.ScrollView.delegate =self;
    pagecode=1;
    
    tousulist =[NSMutableArray array];
    [self queryTouSu];
   
    [self.btnApplication setHidden:YES];
//    if (orderNo==nil||[orderNo isEqualToString:@""]) {
//        [self.btnApplication setHidden:YES];
//    }
//    else
//    {
//        [self.btnApplication setHidden:NO];
//    }

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.ScrollView.frame =CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60);
    self.ScrollView.contentSize=CGSizeMake(self.view.frame.size.width, tousulist.count*(120));
}

#pragma mark - 查询投诉 与 返回处理方法
NSString * n0058 =@"JY0058";
-(void)queryTouSu
{
    CstmMsg *_cstmmsg = [CstmMsg sharedInstance];
    
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    
    [para setValue:_cstmmsg.cstmNo forKey:@"cstmNo"];
    [para setValue:orderNo==nil?@"":orderNo forKey:@"orderNo"];
    [para setValue:[NSString stringWithFormat:@"%d",pagecode] forKey:@"pageCode"];
    [para setValue:[NSString stringWithFormat:@"%d",pagenum] forKey:@"pageNum"];
    
    SysBaseInfo *_sysBaseInfo = [SysBaseInfo sharedInstance];
    StampTranCall * stampTranCall = [StampTranCall sharedInstance];
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmmsg formName:n0058 business:para delegate:self viewController:self];
   
}

-(void) ReturnData:(MsgReturn*)msgReturn
{
    [SVProgressHUD dismiss];
    if ([msgReturn.formName isEqual:n0058]) {
        if(msgReturn.map==nil)
            return;
        
        NSLog(@"0058 %lu",(unsigned long)[msgReturn.map count]);
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        
        
        totalnum = [[returnDataBody objectForKey:@"totalNum"] intValue];
        int recordNum = [[returnDataBody objectForKey:@"recordNum"] intValue];
        for (int i=0; i<recordNum; i++) {
            complaintOrder = [[ComplaintOrderEntity alloc]init];
            complaintOrder.complaintNo = [returnDataBody objectForKey:@"complaintNo"][i];
            complaintOrder.orderNo =[returnDataBody objectForKey:@"orderNo"][i];
            complaintOrder.complaintStatus = [returnDataBody objectForKey:@"complaintStatus"][i];
            complaintOrder.errorReason = [returnDataBody objectForKey:@"errorReason"][i];
            complaintOrder.complaintTime = [returnDataBody objectForKey:@"complaintTime"][i];
            complaintOrder.cstmName = [returnDataBody objectForKey:@"cstmName"][i];
            complaintOrder.cstmPhone = [returnDataBody objectForKey:@"cstmPhone"][i];
            complaintOrder.complaintContent = [returnDataBody objectForKey:@"complaintContent"][i];
            complaintOrder.opinionContent = [returnDataBody objectForKey:@"opinionContent"][i];
            complaintOrder.opinionTime = [returnDataBody objectForKey:@"opinionTime"][i];
            [tousulist addObject:complaintOrder];
        }
        [self bindData];
    }
}
-(void) ReturnError:(MsgReturn*)msgReturn
{
    [SVProgressHUD dismiss];
}

-(void)bindData
{
    tousuarr =[NSMutableArray array];
    if (tousulist.count==0) {
        [self.lbnon setHidden:NO];
    }
    else{
        [self.lbnon setHidden:YES];
        for (int i = 0; i<tousulist.count; i++) {
            TouSuCellViewController* touSuCell =[[TouSuCellViewController alloc]init] ;
            if (i==0) {
                touSuCell.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 115);
            }
            else
            {
                touSuCell.view.frame = CGRectMake(0, i*(115 +5), self.view.frame.size.width, 115);                
            }
            touSuCell.delegate =self;
            [touSuCell initcell:tousulist[i]];
            [tousuarr addObject:touSuCell];
            [self.ScrollView addSubview:touSuCell.view];
        }
        self.ScrollView.contentSize=CGSizeMake(self.view.frame.size.width, tousulist.count*(120));
    }
}
#pragma mark - TouSuCellDelegate 方法实现
-(void)goTouSuDetail:(ComplaintOrderEntity*)Ety
{
    TouSuDetailViewController *detailView = [[TouSuDetailViewController alloc]init];
    detailView.complaintOrderEty =Ety;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailView animated:YES];

}

#pragma mark -按钮点击事件
- (IBAction)doAppliction:(id)sender {
    TouSuShengQingViewController * touSuShengQing =[[TouSuShengQingViewController alloc]init];
    touSuShengQing.orderNO =orderNo;

    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:touSuShengQing animated:YES];


    
}

- (IBAction)goback:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
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
                [self queryTouSu];
            }
        }
        else
        {
            if (pagecode<totalnum/pagenum+1) {
                pagecode =pagecode+1;
                [self queryTouSu];
            }
        }
        
    }

}

@end
