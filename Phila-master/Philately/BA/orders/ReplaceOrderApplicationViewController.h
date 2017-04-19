//
//  ReplaceOrderApplicationViewController.h
//  Philately
//
//  Created by Mirror on 15/6/30.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReplaceOrderApplicationCellViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "ELCImagePickerHeader.h"
#import "TTImagePickerItem.h"
#import "Request0041.h"

#import "StampTranCall.h"
#import "PromptError.h"
#import "SysBaseInfo.h"
#import "SVProgressHUD.h"


#import "VPImageCropperViewController.h"

@interface ReplaceOrderApplicationViewController : UIViewController<ReplaceOrderApplicationCellDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationBarDelegate,UIActionSheetDelegate,ELCImagePickerControllerDelegate,TTImagePickerItemDelegate,Request0041Delegate,StampTranCallDelegate,ServiceInvokerDelegate,VPImageCropperDelegate>
{
    NSMutableArray * mtarr;
    NSMutableArray * dataList;//已购买订单商品
    NSMutableArray* imgarr;//换货上传的图片
    NSString* orderNo;
    int picMaxNum;//最大上传图片数量
    int picMinNum;//最小上传图片数量
    NSMutableArray* replaceList;//换货商品
    NSDictionary*resultData;
    NSMutableArray* picurllist;
}
@property (weak, nonatomic) IBOutlet UILabel *lborderNo;
@property (weak, nonatomic) IBOutlet UITextView *tfreason;
@property (weak, nonatomic) IBOutlet UIImageView *addImgview;
@property (weak, nonatomic) IBOutlet UIImageView *imgView1;
@property (weak, nonatomic) IBOutlet UILabel *lbtitle;
@property (weak, nonatomic) IBOutlet UIView *saveView;
@property (weak, nonatomic) IBOutlet UIScrollView *imgScrollView;
@property (weak, nonatomic) IBOutlet UILabel *lbcontent;

@property (weak, nonatomic) IBOutlet UIScrollView *bigScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *smallScrollView;

@property(nonatomic)NSString* orderNo;
@property(nonatomic,retain)NSDictionary*resultData;




- (IBAction)goback:(id)sender;

- (IBAction)save:(id)sender;




@end
