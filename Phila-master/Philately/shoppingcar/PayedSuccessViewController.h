//
//  PayedSuccessViewController.h
//  Philately
//
//  Created by Mirror on 15/8/20.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuestYouLikeViewController.h"

#import "StampTranCall.h"
#import "PromptError.h"
#import "SysBaseInfo.h"


@interface PayedSuccessViewController : UIViewController<GuestYouLikeChirldViewCallBackDelegate,StampTranCallDelegate>
{
    
    NSString* money;
    
    NSMutableArray *orderForms;//RespondParam0038
    GuestYouLikeViewController *guestYouLikeViewController;
    
}
@property (nonatomic)NSString* money;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView2;
@property (strong,nonatomic)  NSMutableArray *orderForms;//RespondParam0038

@property (weak, nonatomic) IBOutlet UIButton *gotoMain;
//back
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (weak, nonatomic) IBOutlet UIView *guestYouLikeView;

//热门推荐
@property (weak, nonatomic) IBOutlet UILabel *hotTitleTextView;
//linehead2
@property (weak, nonatomic) IBOutlet UIImageView *linehead2ImageView;


@property (weak, nonatomic) IBOutlet UIView *headView;


@property (weak, nonatomic) IBOutlet UILabel *lbmoney;

@end
