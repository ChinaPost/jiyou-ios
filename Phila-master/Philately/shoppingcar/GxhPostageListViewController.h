//
//  GxhPostageListViewController.h
//  Philately
//
//  Created by Mirror on 15/8/20.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "StampTranCall.h"

#import "RespondParam0061.h"


@interface GxhPostageListViewController : UIViewController<StampTranCallDelegate>
{
    NSString* orderNo;//订单号
    NSMutableArray *cellarr;
    NSMutableArray *datalist;

}

@property (weak, nonatomic) IBOutlet UILabel *lbtitle;
@property (nonatomic)NSString* flag;
@property (nonatomic)NSString* orderNo;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (strong, nonatomic) IBOutlet UILabel* lbnon;



- (IBAction)goback:(id)sender;


@end
