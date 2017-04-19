//
//  PayedSuccessViewController.m
//  Philately
//
//  Created by Mirror on 15/8/20.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "PayedSuccessViewController.h"
#import "FirstPageViewController.h"
#import "ShoppingCarViewController.h"
#import "MenberMainViewController.h"

#import "AppDelegate.h"
#import "RespondParam0027.h"




@interface PayedSuccessViewController ()

@end

@implementation PayedSuccessViewController

@synthesize money;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.lbmoney.text=[NSString stringWithFormat:@"￥%@",money];
    
    guestYouLikeViewController=[[GuestYouLikeViewController alloc] initWithNibName:@"GuestYouLikeViewController" bundle:nil];
    
    [self.gotoMain addTarget:self action:@selector(gotoMainClick:) forControlEvents:UIControlEventTouchUpInside];
    [self ui:nil];
    [self request0027];
}

-(void)ui:(NSMutableArray*)data
{
    if(data==nil || [data count]<1)
    {
        int guestViewstart=250;
        [self.guestYouLikeView setFrame:CGRectMake(0, guestViewstart, self.guestYouLikeView.frame.size.width, self.guestYouLikeView.frame.size.height)];
        [self.view addSubview:self.guestYouLikeView];
    }else
    {
        //猜你喜欢View
        UIView  *realGuestView=[guestYouLikeViewController setUiValue:data type:@"" delegate:self];
        
        [realGuestView setFrame:CGRectMake(0, self.hotTitleTextView.frame.size.height+10, self.guestYouLikeView.frame.size.width, realGuestView.frame.size.height)];
        
        
        
        int guestViewstart=250;
        [self.guestYouLikeView setFrame:CGRectMake(0, guestViewstart, self.guestYouLikeView.frame.size.width, realGuestView.frame.size.height+self.hotTitleTextView.frame.size.height+10)];
        
        
        
        [self.guestYouLikeView addSubview:realGuestView];
        
        [self.view addSubview:self.guestYouLikeView];
//
//        [self.scrollContainer setFrame:CGRectMake(0, self.headView.frame.size.height, self.headView.frame.size.width, self.view.frame.size.height-self.headView.frame.size.height)];
//        
//        self.scrollContainer.contentSize=CGSizeMake(self.scrollContainer.frame.size.width, self.guestYouLikeView.frame.origin.y+self.guestYouLikeView.frame.size.height) ;
        
    }
}

-(void)gotoMainClick:(UIButton*)btn
{
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if (![controller isKindOfClass:[FirstPageViewController class]] && ![controller isKindOfClass:[ShoppingCarViewController class]]&& ![controller isKindOfClass:[MenberMainViewController class]]
            ) {
            //            FirstPageViewControllerNavi=true;
            //            [self.navigationController popToViewController:controller animated:YES];
            [controller removeFromParentViewController];
            
        }
    }
    
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.tabbar setSelectedIndex:0];
    
    
}


/*猜你喜欢0027*/
static NSString  *nn0027=@"JY0027";
/*猜你喜欢0027*/
-(void) request0027{
    
    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 商品代号 备注:选填*/
    [businessparam setValue:[NSString stringWithFormat:@"%@",@"16565"  ] forKey:@"merchID"];
    
    [businessparam setValue:@"67" forKey:@"busiNo"];
    /* 当前页码 备注:必填*/
    [businessparam setValue:@"1" forKey:@"pageCode"];
    /* 页码大小 备注:必填*/
    [businessparam setValue:@"10" forKey:@"pageNum"];
    
    
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:nn0027 business:businessparam delegate:self viewController:self];
}


-(void) ReturnError:(MsgReturn*)msgReturn
{
    
}

-(void) ReturnData:(MsgReturn*)msgReturn
{
    
    //NSMutableArray *listData=[[NSMutableArray alloc]init];
    /*猜你喜欢0027*/
    if ([msgReturn.formName isEqualToString:nn0027]){
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        
        RespondParam0027 *commonItem1=[[RespondParam0027 alloc]init];
        /* 最大记录数 备注:*/
        commonItem1.totalNum=[[returnDataBody objectForKey:@"totalNum"] intValue];
        /* 本次返回的记录数 备注:循环域开始*/
        commonItem1.recordNum=[[returnDataBody objectForKey:@"recordNum"]intValue ];
        
        if (commonItem1.recordNum>6) {
            commonItem1.recordNum=6;
        }
        
        NSMutableArray *rows=[[NSMutableArray alloc] init ];
        for (int i=0; i<commonItem1.recordNum; i++) {
            RespondParam0027 *commonItem=[[RespondParam0027 alloc]init];
            /* 商品代号 备注:*/
            commonItem.merchID=[returnDataBody objectForKey:@"merchID"][i];
            /* 商品名称 备注:*/
            commonItem.merchName=[returnDataBody objectForKey:@"merchName"][i];
            /* 商品类别代号 备注:*/
            commonItem.merchType=[returnDataBody objectForKey:@"merchType"][i];
            /* 商品价格 备注:*/
            commonItem.merchPrice=[([returnDataBody objectForKey:@"merchPrice"][i]) floatValue];
            commonItem.merchPicID=[returnDataBody objectForKey:@"merchPicID"][i] ;
             commonItem.merchSaleType=[returnDataBody objectForKey:@"merchSaleType"][i] ;
            /* 图片ID 备注:*/
            commonItem.busiNo=[returnDataBody objectForKey:@"busiNo"][i];
            /* 本次返回的记录数 备注:循环域结束*/
            [rows addObject:commonItem];
        }
        
        
        Row *sectionRow;
        NSMutableArray *listdata=[[NSMutableArray alloc] init ];
        for (int i=0; i<[rows count]; i++) {
            RespondParam0027 *commonItem2=rows[i];
            
            
            if (i==0 || i%3==0) {
                sectionRow=[[Row alloc ] init];
                sectionRow.rowChirlds=[[NSMutableArray alloc]init];
                [listdata addObject:sectionRow];
                
                
            }
            
            Chirld *rowChirld=[[Chirld alloc] init ];
            rowChirld.businNo=commonItem2.busiNo;
            rowChirld.productId=commonItem2.merchID;
            rowChirld.pic=commonItem2.merchPicID;
            rowChirld.merchSaleType=commonItem2.merchSaleType;
            rowChirld.picName=commonItem2.merchName;
            rowChirld.picPrice=[NSString stringWithFormat:@"%.2f",commonItem2.merchPrice] ;
            
            //chirld add
            [sectionRow.rowChirlds addObject:rowChirld];            
            
        }
        
        [self ui:listdata];
    }
}


-(void) chirldViewCallBack:(NSString*)mtype  data:(NSMutableArray*)mdata
{}


@end