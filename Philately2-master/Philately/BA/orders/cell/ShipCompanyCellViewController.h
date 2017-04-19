//
//  ShipCompanyCellViewController.h
//  Philately
//
//  Created by Mirror on 15/7/20.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceEntity.h"

@interface ShipCompanyCellViewController : UIViewController
{
    NSString*code;
    NSString*name;
}
@property (weak, nonatomic) IBOutlet UIView *companyView;
@property (weak, nonatomic) IBOutlet UILabel *lbname;
@property (nonatomic,strong)void(^getShipCompany)(NSString*name);
-(void)initData:(ServiceEntity*)Ety;
@end
