//
//  CityViewController.m
//  Philately
//
//  Created by Mirror on 15/7/3.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "CityViewController.h"
#import "CountyViewController.h"
#import "NewAddressViewController.h"
#import "EditMemberViewController.h"

@interface CityViewController ()

@end


@implementation CityViewController

@synthesize cityEty;
@synthesize provarr;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbtitle.text=@"城市";
    // Do any additional setup after loading the view from its nib.
    
//    cityEty =[[CityEntity alloc] init];
//    SqlQueryCity * queryProv = [[SqlQueryCity alloc]init];
//    cityEty = [queryProv queryCityMSG:provID ];
    
    self.tableView.dataSource = self;
    self.tableView.delegate =self;
    
    self.tableView.tableFooterView =[[UIView alloc]init];
    
    
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
    return cityEty.superiorid.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    cell.textLabel.text = cityEty.regionname[[indexPath row]];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
     cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //跳转等其他操作
    [self performSelector:@selector(unselectCell:) withObject:nil afterDelay:0.5];
    NSString *regionId = cityEty.regionid[[indexPath row]];//选中的市id
    NSString *regionName = cityEty.regionname[[indexPath row]];//选中的市name
    
    NSArray *cityarr = [[NSArray alloc]initWithObjects:regionId,regionName, nil];
    
    SqlQueryCity * queryProv = [[SqlQueryCity alloc]init];
    countyEty = [queryProv queryCityMSG:regionId withLevel:@"4"];
    
    if (countyEty.superiorid.count>0) {
        CountyViewController *countyview = [[CountyViewController alloc]init];
        countyview.countyEty = countyEty;
        countyview.cityarr = cityarr;
        countyview.proarr = self.provarr;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:countyview animated:YES];
    }
    else
    {
        
        ShipAddressEntity* shipaddr = [[ShipAddressEntity alloc]init];
        shipaddr.provCode =self.provarr[0];
        shipaddr.provName =self.provarr[1];
        shipaddr.cityCode =cityarr[0];
        shipaddr.cityName =cityarr[1];
        shipaddr.countCode =@"";
        shipaddr.countName =@"";
        
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isKindOfClass:[NewAddressViewController class]])
            {
                [self.navigationController popToViewController:temp animated:YES];
                [((NewAddressViewController*)temp) refreshAreaInfo:shipaddr];
            }
            if ([temp isKindOfClass:[EditMemberViewController class]])
            {
                [self.navigationController popToViewController:temp animated:YES];
                [((EditMemberViewController*)temp) refreshAreaInfo:shipaddr];
            }
        }
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

- (IBAction)docancel:(id)sender {

    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[NewAddressViewController class]])
        {
            [self.navigationController popToViewController:temp animated:YES];
            
        }
        if ([temp isKindOfClass:[EditMemberViewController class]])
        {
            [self.navigationController popToViewController:temp animated:YES];
            
        }
    }
    
    
}

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
