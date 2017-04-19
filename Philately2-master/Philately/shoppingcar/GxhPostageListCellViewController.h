//
//  GxhPostageListCellViewController.h
//  Philately
//
//  Created by gdpost on 15/8/24.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RespondParam0061.h"


@interface GxhPostageListCellViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lborderno;
@property (weak, nonatomic) IBOutlet UILabel *lbstatus;
@property (weak, nonatomic) IBOutlet UILabel *lbcontent;
@property (weak, nonatomic) IBOutlet UILabel *lbdate;
@property (weak, nonatomic) IBOutlet UILabel *lbpackage;

-(void)initCell:(RespondParam0061*)ety;
@end
