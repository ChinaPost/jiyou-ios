//
//  GxhPostageFuTuViewController.m
//  Philately
//
//  Created by Mirror on 15/7/24.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "GxhPostageFuTuViewController.h"

@interface GxhPostageFuTuViewController ()

@end

@implementation GxhPostageFuTuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    self.img.frame=CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height-40);
//    NSLog(@"width:%.2F",self.img.frame.size.width);
//    NSLog(@"width:%.2F",self.img.frame.size.height);
    
   
}
//-(void)initDatawith:(NSString*)title withimg:(UIImage*)img withRect:(CGRect*) rect withcontentId:(NSString*)contentId
-(void)initDatawith:(ContentClass*)ety  withRect:(CGRect*) rect
{
    contentEty =ety;
    UIImage* initdefaultImg=[UIImage imageNamed:@"Camera1.png"];
    
    contentid = ety.contentid;
    cgrect =rect;
    
    self.lbtitle.text=ety.contentnotice;
    UIImageView* imgview =[[UIImageView alloc]init];
    imgview.frame = CGRectMake(0, 25, rect->size.width, rect->size.width)    ;
    if (ety.img==nil) {
        imgview.image = initdefaultImg;
    }
    else
    {
        imgview.image=ety.img;
    }
    
    [self.basicview addSubview:imgview];
    
//    UIImageView* imgview1 =[[UIImageView alloc]init];
//    imgview1.frame = CGRectMake(0, 25, rect->size.width, rect->size.width)    ;
//    [imgview1 setImage:[UIImage imageNamed:@"TTImagePickerBar_RoundCornerMask"]];
//    [self.basicview addSubview:imgview1];
    
    UITapGestureRecognizer* tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickimg)];
    [self.view addGestureRecognizer:tap];
    
    self.basicview.frame =CGRectMake(0, 0, cgrect->size.width, cgrect->size.width+25);
    [self.view addSubview:self.basicview];
    

//    NSLog(@"width:%.2F",imgview1.frame.size.width);
//    NSLog(@"width:%.2F",imgview1.frame.size.height);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
//    self.basicview.frame =CGRectMake(0, 0, cgrect->size.width, cgrect->size.width+25);
//    [self.view addSubview:self.basicview];
    
}
-(void)clickimg
{
    if (self.selectImg) {
        self.selectImg(contentEty);
    }
}



@end
