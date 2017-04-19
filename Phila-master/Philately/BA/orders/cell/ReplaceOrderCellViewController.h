//
//  ReplaceOrderCellViewController.h
//  Philately
//
//  Created by Mirror on 15/6/30.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RespondParam0057.h"

@protocol ReplaceOrderCellDelegate <NSObject>

-(void)gotoReplaceDetail:(RespondParam0057*)Ety;

@end

@interface ReplaceOrderCellViewController : UIViewController
{
    RespondParam0057* replaceOrderEty;
}

@property (weak, nonatomic) IBOutlet UILabel *lbreplaceOrderNo;
@property (weak, nonatomic) IBOutlet UILabel *lblinkOrderNo;
@property (weak, nonatomic) IBOutlet UILabel *lbcreateTime;
@property (weak, nonatomic) IBOutlet UILabel *lbstatus;
@property (nonatomic,retain) id<ReplaceOrderCellDelegate>delegate;

-(void)initData:(RespondParam0057*)Ety;
@end
