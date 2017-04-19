//
//  touSuListViewController.h
//  Philately
//
//  Created by Mirror on 15/6/27.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouSuCellViewController.h"

#import "StampTranCall.h"
#import "ComplaintOrderEntity.h"

@interface TouSuListViewController : UIViewController<StampTranCallDelegate,TouSuCellDelegate,UIScrollViewDelegate>
{
    NSString* orderNo;//订单号
    NSMutableArray *tousuarr;
    NSMutableArray *tousulist;
    ComplaintOrderEntity* complaintOrder;
}
@property (weak, nonatomic) IBOutlet UILabel *lbtitle;
@property (nonatomic)NSString* flag;
@property (nonatomic)NSString* orderNo;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (strong, nonatomic) IBOutlet UILabel* lbnon;
@property (weak, nonatomic) IBOutlet UIButton *btnApplication;


- (IBAction)doAppliction:(id)sender;

- (IBAction)goback:(id)sender;

@end
