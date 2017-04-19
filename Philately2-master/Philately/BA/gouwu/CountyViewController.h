//
//  CountyViewController.h
//  Philately
//
//  Created by Mirror on 15/7/3.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SqlQueryCity.h"
#import "ShipAddressEntity.h"
//@protocol CountyViewDelegate <NSObject>
//
//-(void)modifyAreaInfo:(NSArray*)Prov andCity:(NSArray*)City andCounty:(NSArray*)County;
//
//@end

@interface CountyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    CityEntity *countyEty;    
    NSArray *proarr;
    NSArray *cityarr;

}
@property (nonatomic)NSArray* proarr;
@property (nonatomic)NSArray* cityarr;
@property (nonatomic)NSArray* countyarr;

@property (nonatomic)CityEntity *countyEty;
@property (weak, nonatomic) IBOutlet UILabel *lbtitle;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)goback:(id)sender;
- (IBAction)docancel:(id)sender;


@end
