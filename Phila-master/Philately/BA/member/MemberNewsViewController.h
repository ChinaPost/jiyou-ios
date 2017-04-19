//
//  memberNewsViewController.h
//  Philately
//
//  Created by Mirror on 15/6/27.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsEntity.h"

#import "StampTranCall.h"

@interface MemberNewsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,StampTranCallDelegate>
{
    NSMutableArray * datalist;
    NewsEntity *newsEty;
}


@property (weak, nonatomic) IBOutlet UILabel *lbtitle;
@property (strong, nonatomic) IBOutlet UIView *nonView;

@property (weak, nonatomic) IBOutlet UITableView *MyNewsView;
- (IBAction)goback:(id)sender;

@end
