//
//  GxhSXViewController.m
//  Philately
//
//  Created by Mirror on 15/7/23.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "GxhSXViewController.h"
#import "ServiceEntity.h"
#import "SqlQueryService.h"
@interface GxhSXViewController ()

@end

@implementation GxhSXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource =self;
    self.tableView.delegate=self;
    
    SqlQueryService* service =[[SqlQueryService alloc]init];
    dataList =[service queryServiceWithKey:@"SXINFO"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UITableViewDataSource方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataList.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellid=@"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.textLabel.text =((ServiceEntity*)dataList[[indexPath row]]).serviceName;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectSX) {
        self.selectSX(((ServiceEntity*)dataList[[indexPath row]]).serviceCode,((ServiceEntity*)dataList[[indexPath row]]).serviceName);
    }
    [self dismissViewControllerAnimated:YES completion:^{}];
    
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60);
    
}
@end

