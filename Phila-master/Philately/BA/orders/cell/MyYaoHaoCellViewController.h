//
//  MyYaoHaoCellViewController.h
//  Philately
//
//  Created by Mirror on 15/7/18.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyYaoHaoCellViewController : UIViewController
{
    NSString* orderNo;
}
@property (weak, nonatomic) IBOutlet UILabel *lborderNo;
@property (weak, nonatomic) IBOutlet UILabel *lbstatus;
@property(nonatomic,strong)void(^goOrderDetail)(NSString*orderNo);

-(void)initData:(NSString*)orderno withStatus:(NSString*)statuscode;

@end
