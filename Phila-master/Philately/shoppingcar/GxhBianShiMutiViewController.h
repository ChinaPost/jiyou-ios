//
//  GxhBianShiMutiViewController.h
//  Philately
//
//  Created by gdpost on 15/8/27.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GxhBianShiMutiViewController : UIViewController
{
    NSArray* imgarr;
    NSString* merchid;
    NSString* merchname;
    bool selected;
}

@property(nonatomic)NSString* merchid;
@property(nonatomic)NSString* merchname;
@property(nonatomic)bool selected;

@property (weak, nonatomic) IBOutlet UILabel *lbname;
@property (weak, nonatomic) IBOutlet UIImageView *imgview;
@property (weak, nonatomic) IBOutlet UIView *basiview;

@property(nonatomic,strong)void(^mutiSelected)(NSString* merchid,bool isSelected);

@end
