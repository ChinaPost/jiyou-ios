//
//  CountyViewController.m
//  Philately
//
//  Created by Mirror on 15/7/3.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "CountyViewController.h"
#import "NewAddressViewController.h"
#import "EditMemberViewController.h"

@interface CountyViewController ()

@end

@implementation CountyViewController

@synthesize countyEty;
@synthesize proarr;
@synthesize cityarr;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbtitle.text=@"区县";
    // Do any additional setup after loading the view from its nib.
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
    return countyEty.superiorid.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    cell.textLabel.text = countyEty.regionname[[indexPath row]];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //跳转等其他操作
    [self performSelector:@selector(unselectCell:) withObject:nil afterDelay:0.5];

    NSString *regionId = countyEty.regionid[[indexPath row]];//选中的区县id
    NSString *regionName = countyEty.regionname[[indexPath row]];//选中的区县name
    NSArray *countyarr = [[NSArray alloc]initWithObjects:regionId,regionName, nil];


    ShipAddressEntity* shipaddr = [[ShipAddressEntity alloc]init];
    shipaddr.provCode =proarr[0];
    shipaddr.provName =proarr[1];
    shipaddr.cityCode =cityarr[0];
    shipaddr.cityName =cityarr[1];
    shipaddr.countCode =countyarr[0];
    shipaddr.countName =countyarr[1];
    
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
-(void)unselectCell:(id)sender{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

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
@end
