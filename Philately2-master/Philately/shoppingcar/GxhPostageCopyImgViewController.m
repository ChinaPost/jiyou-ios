//
//  GxhPostageCopyImgViewController.m
//  Philately
//
//  Created by gdpost on 15/9/17.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "GxhPostageCopyImgViewController.h"

@interface GxhPostageCopyImgViewController ()

@end

@implementation GxhPostageCopyImgViewController

@synthesize contentList;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mutarr =[NSMutableArray array];
    [self initdata];
}

-(void)initdata
{
    for (int i = 0;i<contentList.count;i++)
    {
        GxhPostageCopyImgCellViewController * cell =[[GxhPostageCopyImgCellViewController alloc]init];
        
        cell.view.frame =CGRectMake(0, i*(95+2), self.view.bounds.size.width, 95);
        cell.clickimg=^(NSString* contentid)
        {
            selectedContentid =contentid;
            for (int j =0; j<mutarr.count; j++) {
                if ([((GxhPostageCopyImgCellViewController *)mutarr[j]).contentid isEqual:contentid])
                {
                    [((GxhPostageCopyImgCellViewController *)mutarr[j]) setSelected:true];
                }
                else
                {
                    [((GxhPostageCopyImgCellViewController *)mutarr[j]) setSelected:false];
                }
            }
        };
        [cell initdata:contentList[i]];
        [mutarr addObject:cell];
        
        [self.scorllview addSubview:cell.view];
        
    }
    
    [self initframe];
}

-(void)initframe
{
    self.scorllview.frame=CGRectMake(0, 60, self.view.bounds.size.width, self.view.frame.size.height-60-60);
    [self.view addSubview:self.scorllview];
    
    self.basicview.frame = CGRectMake(0, self.view.frame.size.height-60, self.view.bounds.size.width, 60);
    [self.view addSubview:self.basicview];
    
    self.scorllview.contentSize= CGSizeMake(self.view.bounds.size.width, mutarr.count*(95+2));
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self initframe];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)docancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)dosure:(id)sender {
    if (selectedContentid==nil||[selectedContentid isEqual:@""]) {
        UIAlertView* alter =[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请选择需要复制的图片" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
    
    if (self.copyImgWithContentId) {
        self.copyImgWithContentId(selectedContentid);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
