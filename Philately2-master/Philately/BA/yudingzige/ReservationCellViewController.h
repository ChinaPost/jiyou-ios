//
//  ReservationCellViewController.h
//  Philately
//
//  Created by Mirror on 15/7/6.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReservationEntity.h"

@interface ReservationCellViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lbTypeName;//类型名称
@property (weak, nonatomic) IBOutlet UILabel *lbMaxNum;//预定上限
@property (weak, nonatomic) IBOutlet UILabel *lbYuDingMoney;//预定金额
@property (weak, nonatomic) IBOutlet UILabel *lbBaoZhengMoney;//保证金额
@property (weak, nonatomic) IBOutlet UILabel *lbOtherMoney;//其它费用
@property (weak, nonatomic) IBOutlet UILabel *lbYaoHaoType;//摇号类型

-(void)initcell:(ReservationEntity*)Ety;
@end
