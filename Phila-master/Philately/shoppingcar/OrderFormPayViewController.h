


//ios界面 object-c 
#import <UIKit/UIKit.h>
#import "GuestYouLikeViewController.h"

#import "StampTranCall.h"
#import "PromptError.h"
#import "SysBaseInfo.h"
#import "OrderPay0039.h"
@interface OrderFormPayViewController : UIViewController<GuestYouLikeChirldViewCallBackDelegate,StampTranCallDelegate,OrderPay0039Delegate>
{

    NSMutableArray *orderForms;//RespondParam0038
GuestYouLikeViewController *guestYouLikeViewController;
    
}
@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView2;

@property (weak, nonatomic) IBOutlet UIView *buttonView;

@property (weak, nonatomic) IBOutlet UIButton *goToPayBtn;
@property (strong,nonatomic)  NSMutableArray *orderForms;//RespondParam0038
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *gotoOrderList;

@property (weak, nonatomic) IBOutlet UILabel *tip;
@property (weak, nonatomic) IBOutlet UIButton *gotoMain;

@property (weak, nonatomic) IBOutlet UIView *guestYouLikeView;

//back
@property (weak, nonatomic) IBOutlet UIButton *backButton;
//购物车
@property (weak, nonatomic) IBOutlet UILabel *titleTextView;
//shoppingcar
@property (weak, nonatomic) IBOutlet UIImageView *shoppingcarImageView;
//您的购物车是空的
@property (weak, nonatomic) IBOutlet UILabel *emptyTitleTextView;
//linehead
@property (weak, nonatomic) IBOutlet UIImageView *lineheadImageView;
//热门推荐
@property (weak, nonatomic) IBOutlet UILabel *hotTitleTextView;
//linehead2
@property (weak, nonatomic) IBOutlet UIImageView *linehead2ImageView;
//list
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *cacheCells;
// NSMutableArray *sectionAZDicArray;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollContainer;
@end

