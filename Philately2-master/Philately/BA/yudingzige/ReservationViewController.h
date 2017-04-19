//
//  ReservationViewController.h
//  Philately
//
//  Created by Mirror on 15/6/26.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReservationCellViewController.h"
#import "StampTranCall.h"

//预定资格查询
@interface ReservationViewController : UIViewController<StampTranCallDelegate>
{
    NSMutableArray *dataList;
    NSMutableArray *mtarr;
}
- (IBAction)goback:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *NonTableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *lbtitle;


@end
