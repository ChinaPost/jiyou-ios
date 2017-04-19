//
//  CityViewController.h
//  Philately
//
//  Created by Mirror on 15/7/3.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SqlQueryCity.h"
#import "ShipAddressEntity.h"

@interface CityViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    CityEntity *cityEty;
    CityEntity *countyEty;
    NSArray* provarr; //存放选中的省份

}

@property (nonatomic)NSArray *provarr;

@property (weak, nonatomic) IBOutlet UILabel *lbtitle;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) CityEntity *cityEty;

- (IBAction)docancel:(id)sender;
- (IBAction)goback:(id)sender;
@end
