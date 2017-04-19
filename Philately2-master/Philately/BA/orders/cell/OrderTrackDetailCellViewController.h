//
//  OrderTrackDetailCellViewController.h
//  Philately
//
//  Created by Mirror on 15/6/29.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderTrackViewController.h"

@interface OrderTrackDetailCellViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lbloctaion;
@property (weak, nonatomic) IBOutlet UILabel *lbtime;
-(void)initData:(ShipmentInfo*)Ety withFlag:(NSString*)flag;


@end
