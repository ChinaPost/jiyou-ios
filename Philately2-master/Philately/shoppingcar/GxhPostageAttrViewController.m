//
//  GxhPostageAttrViewController.m
//  Philately
//
//  Created by Mirror on 15/7/23.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "GxhPostageAttrViewController.h"
#import "GxhXZViewController.h"
#import "GxhSXViewController.h"

#import "GxhBianShiSingleViewController.h"
#import "GxhBianShiMutiViewController.h"


#import "ServiceEntity.h"
#import "SqlQueryService.h"


@interface GxhPostageAttrViewController ()

@end

@implementation GxhPostageAttrViewController
@synthesize  Ety0049;
@synthesize selectedMercherID;
@synthesize RuleInfo;
@synthesize  gxhSaleRule;//规则
@synthesize  isEt;//边饰
@synthesize  xzNo;//星座
@synthesize  sxNo;//生肖

static NSMutableArray* MercherID;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbtitle.text=@"个性化定制";
    self.lbsx.layer.borderWidth=1.0;
    self.lbxz.layer.borderWidth=1.0;
    
    self.lbsx.userInteractionEnabled=YES;
    UITapGestureRecognizer* tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickSX)];
    [self.lbsx addGestureRecognizer:tap1];
    
    self.lbxz.userInteractionEnabled=YES;
    UITapGestureRecognizer* tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickXZ)];
    [self.lbxz addGestureRecognizer:tap2];
    
    
    self.bsview1.userInteractionEnabled =YES;
    UITapGestureRecognizer* tap5=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickimg3)];
    [self.bsview1 addGestureRecognizer:tap5];
    
    self.bsview2.userInteractionEnabled =YES;
    UITapGestureRecognizer* tap6=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickimg4)];
    [self.bsview2 addGestureRecognizer:tap6];
    
    
    singlearr =[[NSMutableArray alloc]init];
    mutiarr =[[NSMutableArray alloc]init];
    cellarr =[[NSMutableArray alloc]init];
    
    MercherID = [[NSMutableArray alloc]init];
    for (int i =0; i<selectedMercherID.count; i++) {
        [MercherID addObject:selectedMercherID[i]];
    }
    
    [self initData];
}

-(void)initData
{
    imgarr =@[[UIImage imageNamed:@"check1.png"],[UIImage imageNamed:@"uncheck1.png"]];
    
    
    ServiceEntity* servEty=[[ServiceEntity alloc]init];
    SqlQueryService* service =[[SqlQueryService alloc]init];
    
    //初始化边饰
    if (Ety0049.is_et ==0) {//有边饰
        [self.bsview1 setHidden:NO];
        if ([isEt isEqualToString:@"0"]) {
            self.img3.image=imgarr[0];
            self.img4.image=imgarr[1];
            [self.xzView setHidden:NO];
            [self.sxView setHidden:NO];
        }
        else
        {
            self.img3.image=imgarr[1];
            self.img4.image=imgarr[0];
            [self.xzView setHidden:YES];
            [self.sxView setHidden:YES];
        }
    }
    else
    {
        [self.bsview1 setHidden:YES];
        self.img3.image=imgarr[1];
        self.img4.image=imgarr[0];
        [self.xzView setHidden:YES];
        [self.sxView setHidden:YES];
    }
    
    servEty =[service queryServiceWithKey:@"XZINFO" withcode:xzNo];
    self.lbxz.text = servEty.serviceName;
    
    servEty =[service queryServiceWithKey:@"SXINFO" withcode:sxNo];
    self.lbsx.text = servEty.serviceName;
    
    
    //初始化产品形式
    int affMerchNum =Ety0049.affMerchNum;
    if (affMerchNum==0) {
        [self.lbnothing setHidden:NO];//显示无
    }
    else
    {
        singlearr = RuleInfo.strReqMerchID;
        
        
        for (int i =0; i<affMerchNum; i++) {            
            int index =[Ety0049.gxhBiaozhi[i] intValue]-1;
            NSString* tmpstr = [gxhSaleRule substringWithRange:NSMakeRange(index, 1)];
            if ([tmpstr isEqual:@"1"]) {
                [mutiarr addObject:Ety0049.affMerchID[i]];
            }
        }
        
        [self initBianshi:selectedMercherID];
        
    }
    
}

-(void)initBianshi:(NSMutableArray*)merchidlist
{
    for (UIView* view in self.etView.subviews) {
        if (view!=self.lbproducttype && view!=self.lbnothing) {
            [view removeFromSuperview];
        }
    }
    [cellarr removeAllObjects];
    int affMerchNum =Ety0049.affMerchNum;
    for (int i=0; i<singlearr.count; i++) {
        GxhBianShiSingleViewController* singleView =[[GxhBianShiSingleViewController alloc]init];
        singleView.merchid =singlearr[i];
        for (int j = 0; j<affMerchNum; j++) {
            if ([singlearr[i] isEqual:Ety0049.affMerchID[j]]) {
                singleView.merchname = Ety0049.affMerchName[j];
            }
        }
        if (i==0) {
            singleView.view.frame =CGRectMake(0, 40, self.view.frame.size.width, 60);
        }
        else
        {
            singleView.view.frame =CGRectMake(0, 40+i*(60+1), self.view.frame.size.width, 60);
        }
        
        [cellarr addObject:singleView];
        [self.etView addSubview:singleView.view];
    }
    
    for (int i=0; i<mutiarr.count; i++) {
        GxhBianShiMutiViewController* mutiView =[[GxhBianShiMutiViewController alloc]init];
        mutiView.merchid =mutiarr[i];
        for (int j = 0; j<affMerchNum; j++) {
            if ([mutiarr[i] isEqual:Ety0049.affMerchID[j]]) {
                mutiView.merchname = Ety0049.affMerchName[j];
            }
        }
        
        if ([merchidlist containsObject:mutiarr[i]]) {
            mutiView.selected = true;
        }
        else
        {
            mutiView.selected =false;
        }
        
        if (i==0) {
            mutiView.view.frame =CGRectMake(0, 40+singlearr.count*(60+1), self.view.frame.size.width, 60);
        }
        else
        {
            mutiView.view.frame =CGRectMake(0, 40+singlearr.count*(60+1)+i*(60+1), self.view.frame.size.width, 60);
        }
 
        mutiView.mutiSelected =^(NSString* merchid,bool isSelected)
        {
            if ([MercherID containsObject:merchid]) {
                for (int k=0; k<mutiarr.count; k++) {
                    [MercherID removeObject:mutiarr[k]];
                }
            }
            else
            {
                for (int k=0; k<mutiarr.count; k++) {
                    [MercherID removeObject:mutiarr[k]];
                }
                [MercherID addObject:merchid];
            }
            [self initBianshi:MercherID];
        };
        
        [cellarr addObject:mutiView];
        [self.etView addSubview:mutiView.view];
    }
    
    [self initframe];
    
}

-(void)initframe
{
    int affMerchNum =Ety0049.affMerchNum;
    
    CGFloat height =affMerchNum *(60+1)+40;
    self.etView.frame= CGRectMake(0, 0, self.view.frame.size.width, height);
    [self.scrollView addSubview:self.etView];
    
    self.saveView.frame=CGRectMake(0, self.etView.frame.origin.y+self.etView.frame.size.height+10, self.view.frame.size.width, 300);
    [self.scrollView addSubview:self.saveView];
    
    self.scrollView.contentSize=CGSizeMake(self.view.frame.size.width, self.etView.frame.size.height+self.saveView.frame.size.height+10);
    self.scrollView.frame=CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60);
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
#pragma mark -单选事件
-(void)clickimg3
{//有边饰
    self.img3.image = imgarr[0];//选中
    self.img4.image = imgarr[1];//没选中
    isEt=@"0";
    xzNo=@"1";
    sxNo=@"1";
    [self.sxView setHidden:NO];
    [self.xzView setHidden:NO];
    
    ServiceEntity* servEty=[[ServiceEntity alloc]init];
    SqlQueryService* service =[[SqlQueryService alloc]init];
    
    servEty =[service queryServiceWithKey:@"XZINFO" withcode:xzNo];
    self.lbxz.text = servEty.serviceName;
    
    servEty =[service queryServiceWithKey:@"SXINFO" withcode:sxNo];
    self.lbsx.text = servEty.serviceName;
}

-(void)clickimg4
{//无边饰
    self.img4.image = imgarr[0];//选中
    self.img3.image = imgarr[1];//没选中
    isEt=@"1";
    xzNo=@"0";
    sxNo=@"0";
    self.lbsx.text=@"无";
    self.lbxz.text=@"无";
    [self.sxView setHidden:YES];
    [self.xzView setHidden:YES];
}

#pragma mark -选择生肖
-(void)clickSX
{
    GxhSXViewController* sxView =[[GxhSXViewController alloc]init];
    sxView.selectSX=^(NSString*sxno,NSString*sxname){
        sxNo =sxno;
        self.lbsx.text =sxname;
    };
    [self presentViewController:sxView animated:YES completion:^{}];
}
#pragma mark -选择星座
-(void)clickXZ
{
    GxhXZViewController* xzView =[[GxhXZViewController alloc]init];
    xzView.selectXZ=^(NSString*xzno,NSString*xzname){
        xzNo =xzno;
        self.lbxz.text =xzname;
    };
    [self presentViewController:xzView animated:YES completion:^{}];
}


#pragma mark -按钮点击事件
- (IBAction)doConfirm:(id)sender {
    if([isEt isEqualToString:@"0"])
    {
        if ([xzNo isEqualToString:@"0"]||[sxNo isEqualToString:@"0"]) {
            
            UIAlertView* alert =[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"生肖与星座必须选择" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
    }
    
    
    if (self.modifuBianshi) {
        self.modifuBianshi(MercherID,isEt,xzNo,sxNo);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}
@end
