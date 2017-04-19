//
//  ProvinceViewController.m
//  Philately
//
//  Created by Mirror on 15/7/2.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "ProvinceViewController.h"
#import "CityEntity.h"

#import "SqlApp.h"
//#import "ErrorObject.h"
#import "CityViewController.h"

@interface ProvinceViewController ()

@end

@implementation ProvinceViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.lbtitle.text=@"省份";
   
    provEty =[[CityEntity alloc] init];
    SqlQueryCity * queryProv = [[SqlQueryCity alloc]init];
    provEty = [queryProv queryCityMSG:@"000000" withLevel:@"2"];
    
    self.tableView.dataSource = self;
    self.tableView.delegate =self;
    
    
}

-(void)viewDidLayoutSubviews
{
    self.tableView.frame =CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 60);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return provEty.superiorid.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.textLabel.text = provEty.regionname[[indexPath row]];
    cell.textLabel.font = [UIFont systemFontOfSize:14];//采用系统默认文字设置大小
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //跳转等其他操作
    [self performSelector:@selector(unselectCell:) withObject:nil afterDelay:0.5];
    NSString *regionId = provEty.regionid[[indexPath row]];//选中的省id
    NSString *regionName = provEty.regionname[[indexPath row]];//选中的省name
    
    NSArray *provarr = [[NSArray alloc]initWithObjects:regionId,regionName, nil];
    
    SqlQueryCity * queryProv = [[SqlQueryCity alloc]init];
    cityEty = [queryProv queryCityMSG:regionId withLevel:@"3"];
    
    if (cityEty.superiorid.count>0) {
        CityViewController *cityview = [[CityViewController alloc]init];
        cityview.cityEty  =cityEty;
        cityview.provarr =provarr;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cityview animated:YES];
    }
    else
    {
        
    }
    
}
-(void)unselectCell:(id)sender{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
