//
//  ReplenishmentOrderCellViewController.h
//  Philately
//
//  Created by Mirror on 15/6/30.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RespondParam0040.h"

@interface ReplenishmentOrderCellViewController : UIViewController
{
    RespondParam0040* orderEty;
}
@property (weak, nonatomic) IBOutlet UILabel *lbmoney;
@property (weak, nonatomic) IBOutlet UILabel *lborderNo;
@property (weak, nonatomic) IBOutlet UILabel *lborderMoney;
@property (weak, nonatomic) IBOutlet UILabel *lbstatus;
@property (weak, nonatomic) IBOutlet UILabel *lbbukuan;
@property (weak, nonatomic) IBOutlet UIButton *btnpay;
@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (nonatomic)RespondParam0040* orderEty;

- (IBAction)gotoPay:(id)sender;
@property (nonatomic,strong)void(^gotoDetail)(NSString* orderNo);
@property (nonatomic,strong)void(^goPay)(RespondParam0040* ety);

-(void)initData:(RespondParam0040*)Ety;
@end

