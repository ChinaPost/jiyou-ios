


//ios界面 object-c 
#import <UIKit/UIKit.h>

#import "StampTranCall.h"
#import "PromptError.h"
#import "SysBaseInfo.h"

@interface ShoppingCarViewController : UIViewController<UITableViewDataSource,UITableViewDelegate ,StampTranCallDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate>//list

{
    int  mergeFlag;
    bool isUp;
    NSString * whereCome;
    
    int whichSection;
    int whichRow;
    int whichtype;
    int oldCheckNum;
    
}

@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (strong,nonatomic) NSString *whereCome;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIImageView *backimg;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *cacheCells;
// NSMutableArray *sectionAZDicArray;
//back
@property (weak, nonatomic) IBOutlet UIButton *backImageView;
//购物车
@property (weak, nonatomic) IBOutlet UILabel *titleTextView;
//合计
@property (weak, nonatomic) IBOutlet UILabel *totalTitleTextView;
//¥22.00
@property (weak, nonatomic) IBOutlet UILabel *totalValueTextView;
//提交订单
@property (weak, nonatomic) IBOutlet UIButton *commitOrderFormButton;

@property (weak, nonatomic) IBOutlet UIButton *checkall;

@property (weak, nonatomic) IBOutlet UIButton *checkallCover;





//为空时
@property (weak, nonatomic) IBOutlet UIView *emptyView;

@property (weak, nonatomic) IBOutlet UIScrollView *emptyScrollView;

@property (weak, nonatomic) IBOutlet UIView *guestYouLikeView;

//热门推荐
@property (weak, nonatomic) IBOutlet UILabel *hotTitleTextView;

@property (weak, nonatomic) IBOutlet UIButton *deleteAll;

@end

