//
//  memberNewsTableCell.h
//  Philately
//
//  Created by Mirror on 15/6/27.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsEntity.h"
@interface memberNewsTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbtitle;
@property (weak, nonatomic) IBOutlet UILabel *lbdate;



-(void)initcell:(NewsEntity*)Ety;
@end
