//
//  ProvinceViewController.h
//  Philately
//
//  Created by Mirror on 15/7/2.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SqlQueryCity.h"

#import "ShipAddressEntity.h"

@interface ProvinceViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    CityEntity *provEty;
    CityEntity *cityEty;

}

- (IBAction)goback:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *lbtitle;


@end
