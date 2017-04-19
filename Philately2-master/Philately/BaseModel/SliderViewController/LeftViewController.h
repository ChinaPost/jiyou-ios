//
//  LeftViewController.h
//  Philately
//
//  Created by gdpost on 15/6/15.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ServiceInvoker.h>
@interface LeftViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,ServiceInvokerDelegate,UIAlertViewDelegate>
{
    NSString *appUrl;
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UILabel *lbphone;
@property (weak, nonatomic) IBOutlet UIView *subphoneView;

- (IBAction)docall:(id)sender;
- (IBAction)cancleCall:(id)sender;

@end
