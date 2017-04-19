//
//  RespondParam0049.m
//  Philately
//
//  Created by Mirror on 15/7/22.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "RespondParam0049.h"

@implementation RespondParam0049

@synthesize templateId;
@synthesize templateName;
@synthesize ypzt;
@synthesize ztmz;
@synthesize templateWidth;
@synthesize templateHeight;
@synthesize templateSubType;
@synthesize templateSubCount;
@synthesize interPicURL;
@synthesize etPicURL;
@synthesize zoomRate;

@synthesize contentIdNum;
@synthesize contentId;
@synthesize contentType;
@synthesize contentWidth;
@synthesize contentHeight;
@synthesize contentNotice;
@synthesize contentDirName;

@synthesize itemNum;
@synthesize itemId;
@synthesize itemType;
@synthesize itemX;
@synthesize itemY;
@synthesize linkcontenteId;

@synthesize ztdm;
@synthesize cpgg;
@synthesize is_et;
@synthesize xmbb;
@synthesize xmbbDm;
@synthesize xmbt;
@synthesize xmbtDm;
@synthesize zhuanti;
@synthesize zhuantiDm;
@synthesize xmtc;
@synthesize xmtcDm;
@synthesize ysgy;
@synthesize ysgyDm;
@synthesize mainMerchPrice;
@synthesize gxhSaleRule;


@synthesize affMerchNum;
@synthesize affMerchID;
@synthesize affMerchPrice;
@synthesize affMerchName;
@synthesize gxhBiaozhi;
@synthesize affInterPicURL;
@synthesize affMerchPic;


- (id) init
{
    if(self = [super init])
    {
        self.contentId = [NSMutableArray array];//内容ID
        self.contentType= [NSMutableArray array];//内容类型
        self.contentWidth= [NSMutableArray array];//图片宽度
        self.contentHeight= [NSMutableArray array];//图片高度
        self.contentNotice= [NSMutableArray array];//图片提示
        self.contentDirName= [NSMutableArray array];//图片打包目录
        
        self.itemId= [NSMutableArray array];//明细记录ID
        self.itemType= [NSMutableArray array];//明细类型
        self.itemX= [NSMutableArray array];//左上角X位置
        self.itemY= [NSMutableArray array];//左上角Y位置
        self.linkcontenteId= [NSMutableArray array];//内容ID
        
        self.affMerchID= [NSMutableArray array];//配套商品编号
        self.affMerchPrice= [NSMutableArray array];//配套商品价格
        self.affMerchName= [NSMutableArray array];//配套商品名称
        self.gxhBiaozhi= [NSMutableArray array];//框/折类型
        self.affInterPicURL= [NSMutableArray array];//配套商品图片内部URL
        self.affMerchPic= [NSMutableArray array];//配套商品图片外部URL
        
    }
    return self;
}

@end
