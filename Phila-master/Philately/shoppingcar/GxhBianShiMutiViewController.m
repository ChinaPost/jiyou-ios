//
//  GxhBianShiMutiViewController.m
//  Philately
//
//  Created by gdpost on 15/8/27.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "GxhBianShiMutiViewController.h"

@interface GxhBianShiMutiViewController ()

@end

@implementation GxhBianShiMutiViewController
@synthesize merchid;
@synthesize merchname;
@synthesize  selected;
- (void)viewDidLoad {
    [super viewDidLoad];

    self.lbname.text = merchname;

    
    UITapGestureRecognizer* tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
    [self.view addGestureRecognizer:tap];
    
    imgarr =@[[UIImage imageNamed:@"check1.png"],[UIImage imageNamed:@"uncheck1.png"]];
    
    [self initImg:selected];
    
}

-(void)initImg:(bool)isselected
{
    if (selected)
    {
        self.imgview.image = imgarr[0];//选中
    }
    else
    {
        self.imgview.image = imgarr[1];//未选中
    }
}

-(void)click
{
    NSLog(@"adfadfadfas");
    selected=!selected;
    self.imgview.image = selected?imgarr[0]:imgarr[1];//选中
    if (self.mutiSelected) {
        self.mutiSelected(merchid,selected);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
