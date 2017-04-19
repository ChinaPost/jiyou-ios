//
//  GxhPostageCopyImgCellViewController.m
//  Philately
//
//  Created by gdpost on 15/9/17.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "GxhPostageCopyImgCellViewController.h"

@interface GxhPostageCopyImgCellViewController ()

@end

@implementation GxhPostageCopyImgCellViewController

@synthesize contentid;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer* tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
    [self.view addGestureRecognizer:tap];
    
}

-(void)click
{

    self.smallImgview.image =imgarr[0];
    
    if (self.clickimg) {
        self.clickimg(contentid);
    }    
}

-(void)initdata:(ContentClass*)ety
{
    contentid =ety.contentid;
    imgarr =@[[UIImage imageNamed:@"check1.png"],[UIImage imageNamed:@"uncheck1.png"]];
    
    self.smallImgview.image =imgarr[1];
    self.bigimgview.image = ety.img;
    
    self.lbtitle.text= ety.contentnotice;
    
    
}

-(void)setSelected:(bool)selected
{
    if (selected) {
        self.smallImgview.image =imgarr[0];
    }
    else
    {
        self.smallImgview.image =imgarr[1];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
