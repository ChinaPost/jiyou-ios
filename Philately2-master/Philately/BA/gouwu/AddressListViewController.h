//
//  AddressListViewController.h
//  Philately
//
//  Created by Mirror on 15/7/1.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressListCellViewController.h"
#import "StampTranCall.h"


@interface AddressListViewController : UIViewController<AddressListCellDelegate,StampTranCallDelegate>
{
    
    NSMutableArray *mtarr;
    NSMutableArray *addrList;
}
@property (strong, nonatomic) IBOutlet UIView *nonView;
@property (weak, nonatomic) IBOutlet UILabel *lbtitle;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet UIView *addView;


- (IBAction)goAddNewAddr:(id)sender;
- (IBAction)goback:(id)sender;






@end
