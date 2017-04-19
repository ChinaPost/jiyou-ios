//
//  RespondParam0049.h
//  Philately
//
//  Created by Mirror on 15/7/22.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RespondParam0049 : NSObject

@property (nonatomic)NSString* templateId;//模板Id
@property (nonatomic)NSString* templateName;//模板名称
@property (nonatomic)NSString* ypzt;//邮票主图
@property (nonatomic)NSString* ztmz;//邮票面值
@property (nonatomic)NSString* templateWidth;//模板宽度
@property (nonatomic)NSString* templateHeight;//模板高度
@property (nonatomic)NSString* templateSubType;//附图模式
@property (nonatomic)NSString* templateSubCount;//附图数量
@property (nonatomic)NSString* interPicURL;//模板背景图内部URL
@property (nonatomic)NSString* etPicURL;//模板背景图外部URL
@property (nonatomic)NSString* zoomRate;//缩放比例

@property (nonatomic)int contentIdNum;//附图类型数量
@property (nonatomic,retain)NSMutableArray* contentId;//内容ID
@property (nonatomic,retain)NSMutableArray* contentType;//内容类型
@property (nonatomic,retain)NSMutableArray* contentWidth;//图片宽度
@property (nonatomic,retain)NSMutableArray* contentHeight;//图片高度
@property (nonatomic,retain)NSMutableArray* contentNotice;//图片提示
@property (nonatomic,retain)NSMutableArray* contentDirName;//图片打包目录

@property (nonatomic)int itemNum;//内容位置明细数量
@property (nonatomic,retain)NSMutableArray* itemId;//明细记录ID
@property (nonatomic,retain)NSMutableArray* itemType;//明细类型
@property (nonatomic,retain)NSMutableArray* itemX;//左上角X位置
@property (nonatomic,retain)NSMutableArray* itemY;//左上角Y位置
@property (nonatomic,retain)NSMutableArray* linkcontenteId;//内容ID

@property (nonatomic)int ztdm;//主题代码
@property (nonatomic)NSString* cpgg;//成品规格
@property (nonatomic)int is_et;//是否有边饰
@property (nonatomic)NSString* xmbb;//版别名称
@property (nonatomic)int xmbbDm;//版别代码
@property (nonatomic)NSString* xmbt;//版图名称
@property (nonatomic)int xmbtDm;//版图代码
@property (nonatomic)NSString* zhuanti;//专题名称
@property (nonatomic)int zhuantiDm;//专题代码
@property (nonatomic)NSString* xmtc;//项目题材
@property (nonatomic)int xmtcDm;//题材代码
@property (nonatomic)NSString* ysgy;//印刷工艺
@property (nonatomic)int ysgyDm;//工艺代码

@property (nonatomic)float mainMerchPrice;//	主商品价格
@property (nonatomic)NSString* gxhSaleRule;//	配套商品销售规则

@property (nonatomic)int affMerchNum;//配套商品数量
@property (nonatomic,retain)NSMutableArray* affMerchID;//配套商品编号
@property (nonatomic,retain)NSMutableArray* affMerchPrice;//配套商品价格
@property (nonatomic,retain)NSMutableArray* affMerchName;//配套商品名称
@property (nonatomic,retain)NSMutableArray* gxhBiaozhi;//框/折类型
@property (nonatomic,retain)NSMutableArray* affInterPicURL;//配套商品图片内部URL
@property (nonatomic,retain)NSMutableArray* affMerchPic;//配套商品图片外部URL



@end
