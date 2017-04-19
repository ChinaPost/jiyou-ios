//
//  FirstHeadTableViewCell.h
//  Philately
//
//  Created by gdpost on 15/7/3.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstHeadTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIView *content;
@property (weak, nonatomic) IBOutlet UIButton *morebtn;

@end
