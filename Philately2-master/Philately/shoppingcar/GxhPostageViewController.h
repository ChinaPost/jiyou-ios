//
//  GxhPostageViewController.h
//  Philately
//  个性化定制
//  Created by Mirror on 15/7/22.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//
#import<Foundation/Foundation.h> 
#import <UIKit/UIKit.h>
#import "StampTranCall.h"
#import "PromptError.h"
#import "SysBaseInfo.h"
#import "SVProgressHUD.h"

#import "RespondParam0049.h"
#import "RespondParam0052.h"
#import "RespondParam0050.h"
#import "RespondParam0063.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import "ELCImagePickerHeader.h"
#import <ServiceInvoker.h>
#import "JSONKit.h"

#import "CSaleRuleInfo.h"

#import "AddShopping.h"

#import "UploadFile.h"


#import "VPImageCropperViewController.h"

@interface PicClass : NSObject
{
    NSString* contentid;
    UIImage*img;
    NSString*original;
    CGFloat pwidth;
    CGFloat pheight;
    CGFloat px;
    CGFloat py;
    UIImageView* pimgView;
}
@property(nonatomic)NSString*contentid;
@property(nonatomic,retain)UIImage*img;
@property(nonatomic)NSString*original;
@property(nonatomic)CGFloat pwidth;
@property(nonatomic)CGFloat pheight;
@property(nonatomic)CGFloat px;
@property(nonatomic)CGFloat py;
@property(nonatomic)UIImageView* pimgView;
@end

@interface ContentClass:NSObject
{
    NSString*contentid;
    NSString*imageid;
    UIImage*img;
    NSString*original;
    NSString*contentnotice;
    NSString*type;
    CGFloat contentwidth;
    CGFloat contentheight;
}
@property(nonatomic)NSString*contentid;
@property(nonatomic)NSString*imageid;
@property(nonatomic,retain)UIImage*img;
@property(nonatomic)NSString*original;
@property(nonatomic)NSString*contentnotice;
@property(nonatomic)NSString*type;
@property(nonatomic)CGFloat contentwidth;
@property(nonatomic)CGFloat contentheight;

@end


@interface GxhPostageViewController : UIViewController<StampTranCallDelegate,UIImagePickerControllerDelegate,UINavigationBarDelegate,UIActionSheetDelegate,ELCImagePickerControllerDelegate,ServiceInvokerDelegate,AddShoppingDelegate,UploagFileDelegate,VPImageCropperDelegate>
{
    NSString* merchId;
    NSString* merchNum;
    float merchPrice;
    NSString* orderNo;
    NSString* isModify;//1,不允许修改，其他：允许修改
    NSString* fromflag;//1,购物车，2，订单详情，其他 表示首页商品
    
    
    RespondParam0049* Ety0049;
    RespondParam0052* Ety0052;
    RespondParam0063* Ety0063;
    NSString* flag;//操作标志，0定制，1修改

    NSString* isEt;//边饰
    NSString* xzNo;//星座
    NSString* sxNo;//生肖
    
    NSString*sxname;
    NSString*xzname;
    NSString*etname;

    
    
    NSArray* readImg;//存储 阅读 选择图片
    NSArray* authImg;//存储 授权 选择图片
    bool isread;
    bool isauth;
    
    UIImage* bjimg;//背景图
    
    NSMutableArray* mtarr;
    
    NSString* contentID;//附图内容ID
    NSMutableArray* contentList;//附图数组
    NSMutableArray* oldcontentList;//附图数组
    NSMutableArray*picList;//上传图片数组    

    ContentClass* currntContent;//当前选择相片的附图
    
    CSaleRuleInfo* SaleRuleInfo;
    NSMutableArray* selMerchID;
}

@property(nonatomic)NSString* merchId;
@property(nonatomic)NSString* merchNum;
@property(nonatomic)float merchPrice;
@property(nonatomic)NSString* orderNo;
@property(nonatomic)NSString* isModify;
@property(nonatomic)NSString* fromflag;


@property (weak, nonatomic) IBOutlet UIScrollView *bigScrollView;
@property (weak, nonatomic) IBOutlet UIView *bianShiView;
@property (strong, nonatomic) IBOutlet UIView *dingZhiView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIView *imglistlView;
@property (strong, nonatomic) IBOutlet UIView *AddView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImg;
@property (strong, nonatomic) IBOutlet UIView *basicView;




@property (weak, nonatomic) IBOutlet UILabel *lbtitle;
@property (weak, nonatomic) IBOutlet UILabel *lbmoBan;
@property (weak, nonatomic) IBOutlet UILabel *lbtotalMoney;
@property (weak, nonatomic) IBOutlet UILabel *lbproductType;
@property (weak, nonatomic) IBOutlet UILabel *lbbianShi;
@property (weak, nonatomic) IBOutlet UILabel *lbauthName;
@property (weak, nonatomic) IBOutlet UILabel *lbauthCertNo;
@property (weak, nonatomic) IBOutlet UIImageView *shouQuanImg;
@property (weak, nonatomic) IBOutlet UIImageView *xieYiImg;
@property (weak, nonatomic) IBOutlet UIButton *btnRead;
@property (weak, nonatomic) IBOutlet UIButton *btnAddShopCart;
@property (weak, nonatomic) IBOutlet UIButton *btnModify;




@property (weak, nonatomic) IBOutlet UIView *certnoView;
@property (weak, nonatomic) IBOutlet UIView *readView;

- (IBAction)goback:(id)sender;
- (IBAction)DoRead:(id)sender;
- (IBAction)DoAddShopCart:(id)sender;
- (IBAction)DoModify:(id)sender;

@end
