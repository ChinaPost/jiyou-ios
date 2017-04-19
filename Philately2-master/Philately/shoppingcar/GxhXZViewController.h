//
//  GxhXZViewController.h
//  Philately
//
//  Created by Mirror on 15/7/23.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GxhXZViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray* dataList;
}



@property (weak, nonatomic) IBOutlet UIView *basicView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)void(^selectXZ)(NSString*xzNO,NSString*xzName);
@end
