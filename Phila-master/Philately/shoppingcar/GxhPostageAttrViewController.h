//
//  GxhPostageAttrViewController.h
//  Philately
//
//  Created by Mirror on 15/7/23.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RespondParam0049.h"
#import "CSaleRuleInfo.h"
@interface GxhPostageAttrViewController : UIViewController
{
    RespondParam0049*Ety0049;
    CSaleRuleInfo* RuleInfo;
    NSMutableArray* selectedMercherID;
    NSString* gxhSaleRule;
    
    NSString* gxhBiaozhi;//产品形式
    NSString* isEt;//边饰
    NSString* xzNo;//星座
    NSString* sxNo;//生肖
 
    NSArray* imgarr;
    NSMutableArray* cellarr;
    NSMutableArray* singlearr; //单选数组
    NSMutableArray* mutiarr;//多选数组
    
}

@property(nonatomic,retain)RespondParam0049*Ety0049;
@property(nonatomic,retain)CSaleRuleInfo* RuleInfo;
@property(nonatomic,retain)NSMutableArray* selectedMercherID;
@property(nonatomic,retain)NSString* gxhSaleRule;

@property(nonatomic)NSString* isEt;//边饰
@property(nonatomic)NSString* xzNo;//星座
@property(nonatomic)NSString* sxNo;//生肖




@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIImageView *img4;
@property (weak, nonatomic) IBOutlet UILabel *lbsx;
@property (weak, nonatomic) IBOutlet UILabel *lbxz;
@property (weak, nonatomic) IBOutlet UILabel *lbtitle;
@property (weak, nonatomic) IBOutlet UIView *sxView;
@property (weak, nonatomic) IBOutlet UIView *xzView;
@property (weak, nonatomic) IBOutlet UIView *bsView;
@property (weak, nonatomic) IBOutlet UIView *etView;


@property (weak, nonatomic) IBOutlet UIView *bsview1;
@property (weak, nonatomic) IBOutlet UIView *bsview2;



@property (weak, nonatomic) IBOutlet UIView *saveView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *lbnothing;


@property(nonatomic,strong)void(^modifuBianshi)(NSMutableArray*merchid,NSString*iset,NSString*xzno,NSString*sxno);

@property (weak, nonatomic) IBOutlet UILabel *lbproducttype;






- (IBAction)doConfirm:(id)sender;
- (IBAction)goback:(id)sender;


@end
