//
//  ShipCompanyViewController.h
//  Philately
//
//  Created by Mirror on 15/7/20.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShipCompanyCellViewController.h"

@interface ShipCompanyViewController : UIViewController
{
    NSMutableArray* mtarr;
    NSMutableArray* dataList;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *basicView;
@property(nonatomic,strong)void(^refreshCompany)(NSString*name);
@end
