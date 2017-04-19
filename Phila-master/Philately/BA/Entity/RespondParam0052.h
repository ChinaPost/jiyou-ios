//
//  RespondParam0052.h
//  Philately
//
//  Created by Mirror on 15/7/22.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RespondParam0052 : NSObject


@property (nonatomic)NSString* cstmNo;//	会员编号
@property (nonatomic)NSString* merchID;//	商品代号
@property (nonatomic)NSString* templateId;//	模板Id

@property (nonatomic)int  recordNum;//	上传的图片数量
@property (nonatomic,retain)NSMutableArray* imageID	;//图片唯一标识
@property (nonatomic,retain)NSMutableArray* contentId;//	附图id
@property (nonatomic,retain)NSMutableArray* interPicURL1;//	内部图片URL
@property (nonatomic,retain)NSMutableArray* original;//	外部图片URL
@property (nonatomic,retain)NSMutableArray* type;//	图片类型

@property (nonatomic)int selAffMerchNum;//	选择的配套商品数量
@property (nonatomic,retain)NSMutableArray*affMerchID;//	配套商品编号
@property (nonatomic,retain)NSMutableArray*affMerchName;//	配套商品名称
@property (nonatomic,retain)NSMutableArray*gxhBiaozhi;//	框/折类型


@property (nonatomic)NSString* isEt	;//是否有边饰
@property (nonatomic)NSString* etId	;//边式id
@property (nonatomic)NSString* etNo	;//边式编号
@property (nonatomic)NSString* etSxNo	;//生肖编号
@property (nonatomic)NSString* etSxMc	;//生肖名称
@property (nonatomic)NSString* etXzNo	;//星座编号
@property (nonatomic)NSString* etXzMc	;//星座名称
@property (nonatomic)NSString* interPicURL	;//边饰背景图片内部URL
@property (nonatomic)NSString* etPicURL	;//边饰背景图片外部URL地址





@end
