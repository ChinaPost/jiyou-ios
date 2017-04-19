//
//  MyOrdersTableCell.h
//  Philately
//
//  Created by Mirror on 15/6/27.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrdersTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lborderNo;
@property (weak, nonatomic) IBOutlet UILabel *lborderMoney;
@property (weak, nonatomic) IBOutlet UILabel *lbcreateTime;
@property (weak, nonatomic) IBOutlet UILabel *lborderStatus;

@end
