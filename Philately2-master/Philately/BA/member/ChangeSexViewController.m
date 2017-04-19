//
//  changeSexViewController.m
//  Philately
//
//  Created by Mirror on 15/6/25.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "ChangeSexViewController.h"

@interface ChangeSexViewController ()

@end

@implementation ChangeSexViewController
@synthesize sexFlag;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbtitle.text =@"选择性别";
    
    imgarr = @[[UIImage imageNamed:@"check1.png"],[UIImage imageNamed:@"uncheck1.png"]];
    
    if ([sexFlag isEqualToString:@"0"]) {//保密
        self.img0.image = imgarr[0];
        self.img1.image = imgarr[1];
        self.img2.image = imgarr[1];
        
    }
    else if ([sexFlag isEqualToString:@"1"]) {//女
        self.img1.image = imgarr[1];
        self.img2.image = imgarr[0];
        self.img0.image = imgarr[1];
       
    }
    else if ([sexFlag isEqualToString:@"2"]) {//男
        self.img1.image = imgarr[0];
        self.img2.image = imgarr[1];
        self.img0.image = imgarr[1];
    }
    
    self.img0.userInteractionEnabled =YES;
    UITapGestureRecognizer *tap0 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImg0)];
    [self.img0 addGestureRecognizer:tap0];
    
    self.img1.userInteractionEnabled =YES;
    UITapGestureRecognizer *tap1 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImg1)];
    [self.img1 addGestureRecognizer:tap1];
    
    self.img2.userInteractionEnabled =YES;
    UITapGestureRecognizer *tap2 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImg2)];
    [self.img2 addGestureRecognizer:tap2];
}
-(void)clickImg0
{//保密
    self.img0.image = imgarr[0];
    self.img1.image = imgarr[1];
    self.img2.image = imgarr[1];
    if (self.doSelectSex) {
        self.doSelectSex(@"0");
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)clickImg1
{//男
    self.img1.image = imgarr[0];
    self.img2.image = imgarr[1];
    if (self.doSelectSex) {
        self.doSelectSex(@"2");
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickImg2
{//女
    self.img1.image = imgarr[1];
    self.img2.image = imgarr[0];
    if (self.doSelectSex) {
        self.doSelectSex(@"1");
    }
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
