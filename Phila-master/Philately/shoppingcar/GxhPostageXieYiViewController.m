//
//  GxhPostageXieYiViewController.m
//  Philately
//
//  Created by Mirror on 15/7/23.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "GxhPostageXieYiViewController.h"

@interface GxhPostageXieYiViewController ()

@end

@implementation GxhPostageXieYiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UITapGestureRecognizer* tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
    [self.view addGestureRecognizer:tap];
    
}

-(void)click
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
