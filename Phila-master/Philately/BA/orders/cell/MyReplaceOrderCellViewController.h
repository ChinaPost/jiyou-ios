//
//  MyReplaceOrderCellViewController.h
//  Philately
//
//  Created by Mirror on 15/6/30.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RespondParam0040.h"

@interface MyReplaceOrderCellViewController : UIViewController
{
    NSString* isReplacing;
}

@property (weak, nonatomic) IBOutlet UILabel *lborderNo;
@property (weak, nonatomic) IBOutlet UILabel *lborderMoney;
@property (weak, nonatomic) IBOutlet UILabel *lbcreateTime;
@property (weak, nonatomic) IBOutlet UILabel *lbStatus;
@property (weak, nonatomic) IBOutlet UIButton *btnApplicationOrder;
@property (weak, nonatomic) IBOutlet UIView *infoView;

@property(nonatomic)NSString* isReplacing;

@property(nonatomic,strong)void(^gotoHistory)(NSString*orderNo,NSString* isReplacing);
@property(nonatomic,strong)void(^gotoReplaceOrder)(NSString*orderNo);

- (IBAction)goHistory:(id)sender;
- (IBAction)goReplaceOrder:(id)sender;

-(void)initData:(RespondParam0040*)Ety;

@end
