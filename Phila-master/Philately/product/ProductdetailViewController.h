


//ios界面 object-c 
#import <UIKit/UIKit.h>

#import "StampTranCall.h"
#import "PromptError.h"
#import "SysBaseInfo.h"
#import "SectionRowChirld.h"
#import "GuestYouLikeViewController.h"
#import "RespondParam0026.h"
#import "AddShopping.h"

@interface ProductdetailViewController : UIViewController<StampTranCallDelegate,GuestYouLikeChirldViewCallBackDelegate,UIScrollViewDelegate,AddShoppingDelegate,UIWebViewDelegate,UIGestureRecognizerDelegate>

{
 

//    NSMutableArray *typeProducts;
//    RespondParam0026 *oneInfo;//单套信息
//    RespondParam0026 *fourInfo;//四方套信息
    
    
    float touchy;
    int  movelength;
    int keyboardHeight;
    
    
    int shoppingcarpicW;
    int shoppingcarpicH;
    int shoppingcarpicWEmpty;
    int shoppingcarpicHEmpty;
    NSMutableArray *imagearr;
    NSTimer *myTimer;
  
    
}
@property (weak, nonatomic) IBOutlet UILabel *saleTimeValueEndTextView;
@property (weak, nonatomic) IBOutlet UIImageView *shoppingcarpic;
@property (weak, nonatomic) IBOutlet UIView *moreTimeView;
@property (weak, nonatomic) IBOutlet UILabel *moreTimeTitleTextView;
@property (weak, nonatomic) IBOutlet UILabel *moreTimeValueTextView;
@property (weak, nonatomic) IBOutlet UILabel *moreTimeValueEndTextView;
@property (weak, nonatomic) IBOutlet UIPageControl *picPagecontrol;
//
//@property (strong,nonatomic) NSMutableArray *typeProducts;
//@property (strong,nonatomic) RespondParam0026 *oneInfo;//单套信息
//@property (strong,nonatomic) RespondParam0026 *fourInfo;//四方套信息
@property (weak, nonatomic) IBOutlet UIView *headView;

@property (weak, nonatomic) IBOutlet UIButton *diyBtn;


@property (weak, nonatomic) IBOutlet UILabel *guestTitle;
@property (weak, nonatomic) IBOutlet UIView *otherInfoView;
@property (weak, nonatomic) IBOutlet UIView *productDescView;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *productPicView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;


//产品图片

@property (weak, nonatomic) IBOutlet UIButton *sellall;
//back
@property (weak, nonatomic) IBOutlet UIButton *backButton;
//产品详情
@property (weak, nonatomic) IBOutlet UILabel *titleTextView;
//car
@property (weak, nonatomic) IBOutlet UIButton *carImageView;
//购物车数量
@property (weak, nonatomic) IBOutlet UILabel *carnumTextView;
@property (weak, nonatomic) IBOutlet UILabel *needFenTitleTextView;
//0
@property (weak, nonatomic) IBOutlet UILabel *needFenValueTextView;
//获得积分:
@property (weak, nonatomic) IBOutlet UILabel *getFenTitleTextView;
//3
@property (weak, nonatomic) IBOutlet UILabel *getFenValueTextView;
//扣除积分:
@property (weak, nonatomic) IBOutlet UILabel *deleteFenTextView;
//0
@property (weak, nonatomic) IBOutlet UILabel *deleteFenValueTextView;
//所属机构:
@property (weak, nonatomic) IBOutlet UILabel *belongTitleTextView;
//中国邮政网上
@property (weak, nonatomic) IBOutlet UILabel *belongValueTextView;
//发行时间:
@property (weak, nonatomic) IBOutlet UILabel *timeTextView;
//2015
@property (weak, nonatomic) IBOutlet UILabel *timeValueTextView;
//销售时间
@property (weak, nonatomic) IBOutlet UILabel *saletimeTextView;
//2015
@property (weak, nonatomic) IBOutlet UILabel *saletimeValueTextView;
//开始
@property (weak, nonatomic) IBOutlet UILabel *startTextView;
//简要描述
@property (weak, nonatomic) IBOutlet UILabel *detailTitleTextView;
//作者
@property (weak, nonatomic) IBOutlet UIWebView *detailValueTextView;
//猜你喜欢
//list
@property (weak, nonatomic) IBOutlet UIView *guestView;

// NSMutableArray *sectionAZDicArray;
//立即购买
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
//放进购物车
@property (weak, nonatomic) IBOutlet UIButton *addbuycarButton;

@property (strong,nonatomic) NSString * busiNo;
@property (strong,nonatomic) NSString *productId;



@property (weak, nonatomic) IBOutlet UIScrollView *picScrollView;



@end

