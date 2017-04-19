//
//  ReplaceOrderDetailCellViewController.h
//  Philately
//
//  Created by Mirror on 15/7/1.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RespondParam0057.h"
@interface ReplaceOrderDetailCellViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lbname;

-(void)initData:(ApplyMerchItems*)Ety;

@end
