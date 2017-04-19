//
//  GxhBianShiSingleViewController.m
//  Philately
//
//  Created by gdpost on 15/8/27.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "GxhBianShiSingleViewController.h"

@interface GxhBianShiSingleViewController ()

@end

@implementation GxhBianShiSingleViewController
@synthesize merchid;
@synthesize merchname;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lbname.text =merchname;
    
//    self.imgview.userInteractionEnabled =YES;
//    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickimg)];
//    [self.imgview addGestureRecognizer:tap];
    
    imgarr =@[[UIImage imageNamed:@"check1.png"],[UIImage imageNamed:@"uncheck1.png"]];
    self.imgview.image = imgarr[0];
}

//-(void)clickimg
//{
//    self.imgview.image = imgarr[0];//选中
//    if (self.singleSelected) {
//        self.singleSelected(merchid);
//    }
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
