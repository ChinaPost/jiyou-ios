//
//  GxhBianShiSingleViewController.h
//  Philately
//
//  Created by gdpost on 15/8/27.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GxhBianShiSingleViewController : UIViewController
{
    NSArray* imgarr;
    NSString* merchid;
    NSString* merchname;
}

@property(nonatomic)NSString* merchid;
@property(nonatomic)NSString* merchname;

@property (weak, nonatomic) IBOutlet UILabel *lbname;
@property (weak, nonatomic) IBOutlet UIImageView *imgview;

//@property(nonatomic,strong)void(^singleSelected)(NSString* merchid);

@end
