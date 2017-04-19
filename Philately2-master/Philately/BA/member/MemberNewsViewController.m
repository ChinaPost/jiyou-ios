
//  memberNewsViewController.m
//  Philately
//
//  Created by Mirror on 15/6/27.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "MemberNewsViewController.h"
#import "MemNewsDetailViewController.h"
#import "memberNewsTableCell.h"

#import "PromptError.h"
#import "SysBaseInfo.h"
#import "SVProgressHUD.h"

@interface MemberNewsViewController ()

@end

@implementation MemberNewsViewController

static int pagenum = 10;
static int pagecode = 1;
static bool istrue= true;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbtitle.text=@"我的消息";
    
    self.MyNewsView.dataSource =self;
    self.MyNewsView.delegate =self;
    [self.MyNewsView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    
    
    datalist =[[NSMutableArray alloc]init];
    pagecode =1;
    istrue= true;
    [self queryMyNews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.MyNewsView.frame =CGRectMake(0,60, self.view.frame.size.width, self.view.frame.size.height-60);
}

#pragma mark - 我的消息 与 返回处理方法
NSString * n0056 =@"JY0056";
-(void)queryMyNews
{
    CstmMsg *_cstmmsg = [CstmMsg sharedInstance];
    
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    [para setValue:_cstmmsg.cstmNo forKey:@"cstmNo"];
    [para setValue:@"0" forKey:@"sortFieldID"];
    [para setValue:[NSString stringWithFormat:@"%d",pagecode] forKey:@"pageCode"];
    [para setValue:[NSString stringWithFormat:@"%d",pagenum] forKey:@"pageNum"];

    SysBaseInfo *_sysBaseInfo = [SysBaseInfo sharedInstance];
    StampTranCall * stampTranCall = [StampTranCall sharedInstance];
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmmsg formName:n0056 business:para delegate:self viewController:self];
   
}

-(void) ReturnData:(MsgReturn*)msgReturn
{
    
    if ([msgReturn.formName isEqual:n0056]) {
        if(msgReturn.map==nil)
            return;
        
        NSLog(@"0056 %lu",(unsigned long)[msgReturn.map count]);
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        
        
        int recordNum = [[returnDataBody objectForKey:@"recordNum"] intValue];
        
       
        if (recordNum==pagenum) {
            pagecode = pagecode+1;
            istrue= true;
        }
        else
        {
            istrue= false;
        }
        
        for (int i=0; i<recordNum; i++) {
            newsEty = [[NewsEntity alloc]init];
            newsEty.infoID = [returnDataBody objectForKey:@"infoID"][i];
            newsEty.infoTitle = [returnDataBody objectForKey:@"infoTitle"][i];
            newsEty.infoContent = [returnDataBody objectForKey:@"infoContent"][i];
            newsEty.gmtCreate = [returnDataBody objectForKey:@"gmtCreate"][i];
            
            [datalist addObject:newsEty];
        }
        
        if (datalist.count==0) {
            self.nonView.frame =CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60);
            [self.view addSubview:self.nonView];
        }
        else{
            [self.MyNewsView reloadData];
            if (datalist.count>0&&datalist.count<10) {
                self.MyNewsView. tableFooterView =[[UIView alloc]init];
            }
        }
    }
}
-(void) ReturnError:(MsgReturn*)msgReturn
{
    [SVProgressHUD dismiss];
}

#pragma mark - tableview 绑定数据
//设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return datalist.count ;
}
//设置单元格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellid =@"cerid";
    memberNewsTableCell *cell = (memberNewsTableCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"memberNewsTableCell" owner:nil options:nil]lastObject];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSLog(@"row[%ld]",(long)[indexPath row]);
    NSLog(@"count[%lu]",(unsigned long)datalist.count);
    [cell initcell:datalist[[indexPath row] ]];
    return cell;
 

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MemNewsDetailViewController * detailView = [[MemNewsDetailViewController alloc]init];
    detailView.newsEty =datalist[[indexPath row]];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailView animated:YES];
    

}

- (IBAction)goback:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //康海涛测试Ok的
    CGPoint offset1 = scrollView.contentOffset;
    CGRect bounds1 = scrollView.bounds;
    CGSize size1 = scrollView.contentSize;
    UIEdgeInsets inset1 = scrollView.contentInset;
    float y1 = offset1.y + bounds1.size.height - inset1.bottom;
    float h1 = size1.height;
    NSLog(@"y1[%.2f],height[%.2f],h1[%.2f]",y1,self.MyNewsView.frame.size.height,h1);
//    if (y1 > self.MyNewsView.frame.size.height) {
////        flagShuaxin = YES;
//    }
//    else if (y1 < self.MyNewsView.frame.size.height) {
////        flagShuaxin = NO;
//    }
//    else if (y1 == self.MyNewsView.frame.size.height) {
////        DLog(@"%@", flagShuaxin ? @"上拉刷新" : @"下拉刷新");
//        if (istrue) {
//            [self queryMyNews];
//        }
//        
//    }
    
    if (y1==h1) {
        if (istrue) {
            [self queryMyNews];
        }
    }
}

@end
