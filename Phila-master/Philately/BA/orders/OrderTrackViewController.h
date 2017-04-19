//
//  OrderTrackViewController.h
//  Philately
//
//  Created by Mirror on 15/6/29.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ShipmentInfo : NSObject
{
    NSString* source;
    NSString* acceptTime;
    NSString* acceptAddr;
    NSString* remark;
}
@property(nonatomic)NSString* source;
@property(nonatomic)NSString* acceptTime;
@property(nonatomic)NSString* acceptAddr;
@property(nonatomic)NSString* remark;
@end


@interface OrderTrackViewController : UIViewController
{
    NSMutableArray *mtarray;
    NSMutableArray *dataList;
    NSDictionary* resultData;
}
@property (weak, nonatomic) IBOutlet UILabel *lborderNo;
@property (weak, nonatomic) IBOutlet UILabel *lbremark;

@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet UIView *basicview;
@property (weak, nonatomic) IBOutlet UIView *wuliuview;

@property(nonatomic,retain)NSDictionary* resultData;
- (IBAction)goback:(id)sender;

@end
