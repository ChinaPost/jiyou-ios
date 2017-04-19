//
//  ReplaceOrderApplicationCellViewController.m
//  Philately
//
//  Created by Mirror on 15/6/30.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "ReplaceOrderApplicationCellViewController.h"

@interface ReplaceOrderApplicationCellViewController ()

@end

@implementation ReplaceOrderApplicationCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    isSelected=NO;
    
    [self.btnadd setHidden:YES];
    [self.btncut setHidden:YES];
    
    [self.tfnum setEnabled:NO];
    [self.btnadd setEnabled:NO];
    [self.btncut setEnabled:NO];
    
    imgarr =@[[UIImage imageNamed:@"check1.png"],[UIImage imageNamed:@"uncheck1.png"]];    
    self.imgView.image = isSelected?imgarr[0]:imgarr[1];
    
    self.imgView.userInteractionEnabled =YES;
    UITapGestureRecognizer * tap1 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImg)];
    [self.imgView addGestureRecognizer: tap1];
    
}

-(void)initData:(ProductItem*)Ety
{
    productItem = Ety;
    self.lbname.text =Ety.merchName;
    self.tfnum.text = [NSString stringWithFormat:@"%@",Ety.merchNum];
    number = [Ety.merchNum intValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)clickImg
{
    self.tfnum.text = [NSString stringWithFormat:@"%d",number];
    productItem.merchNum =self.tfnum.text;
    
    isSelected =!isSelected;
    self.imgView.image = isSelected?imgarr[0]:imgarr[1];
    if (isSelected) {
        [self.btnadd setEnabled:NO];
        [self.btncut setEnabled:YES];
        productItem.isReplace=@"1";//换货
    }
    else
    {
        [self.btnadd setEnabled:NO];
        [self.btncut setEnabled:NO];
        productItem.isReplace=@"0";//不换货
    }
    if (self.addReplaceProduct) {
        self.addReplaceProduct(productItem);
    }
}

- (IBAction)addNum:(id)sender {
    int num = [self.tfnum.text intValue];
    num =num+1;
    self.tfnum.text = [NSString stringWithFormat:@"%d",num];
    
    [self setBtnEnable];
    productItem.merchNum =self.tfnum.text;
    if (self.delegate) {
        [self.delegate upNum:productItem];
    }
}

- (IBAction)cutNum:(id)sender {
    int num = [self.tfnum.text intValue];
    if (num>0) {
        num=num-1;
        self.tfnum.text = [NSString stringWithFormat:@"%d",num];
    }
    [self setBtnEnable];
    productItem.merchNum =self.tfnum.text;
    if (self.delegate) {
        [self.delegate downNum:productItem];
    }
}

-(void)setBtnEnable
{
    int num = [self.tfnum.text intValue];
    if (num>0) {
        [self.btncut setEnabled:YES];
    }
    else
    {
        [self.btncut setEnabled:NO];
    }
    
    if (num<number) {
        [self.btnadd setEnabled:YES];
    }
    else
    {
        [self.btnadd setEnabled:NO];
    }
}

@end
