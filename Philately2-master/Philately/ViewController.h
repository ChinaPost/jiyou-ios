//
//  ViewController.h
//  PublicLibUI
//
//  Created by gdpost on 15/5/13.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ServiceInvoker.h>

//http://www.oschina.net/translate/a-lightweight-ios-image-cache

@interface ViewController : UIViewController 

//sdd
@property (weak, nonatomic) IBOutlet UILabel *sddTextView;
//专题
@property (weak, nonatomic) IBOutlet UILabel *zhuangTextView;
//1分种
@property (weak, nonatomic) IBOutlet UILabel *miniTextView;
//北京强力禁烟
@property (weak, nonatomic) IBOutlet UILabel *msgTextView;
//热点
@property (weak, nonatomic) IBOutlet UILabel *hotTextView;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UITextField *edittexdt;

@end

