//
//  OderPayViewTableViewCell.h
//  Philately
//
//  Created by gdpost on 15/7/22.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OderPayViewTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIView *payView;
@property (weak, nonatomic) IBOutlet UILabel *orderFormPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *payWayLabel;



@end
