


//ios界面 object-c 
#import <UIKit/UIKit.h>

#import "StampTranCall.h"
#import "PromptError.h"
#import "SysBaseInfo.h"
#import "SectionRowChirld.h"
#import "ProductListMenuViewController.h"



@interface ProductSearchlistViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,StampTranCallDelegate,ChirldViewRespond>
{
GuestYouLikeViewController *guestYouLikeViewController;
    NSMutableArray *rows;
    NSMutableArray *productListData;
    
    NSMutableArray *merchTypeListData;
    
    ProductListMenuViewController *productListMenuViewController;
    
    NSMutableArray *upToLows;
}
@property (weak, nonatomic) IBOutlet UIView *headView;

//list
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *cacheCells;
// NSMutableArray *sectionAZDicArray;
//back
@property (weak, nonatomic) IBOutlet UIButton *backButton;
//邮票
@property (weak, nonatomic) IBOutlet UILabel *titleTextView;




@property (weak, nonatomic) IBOutlet UILabel *emptyToast;

//为空时
@property (weak, nonatomic) IBOutlet UIView *emptyView;

@property (weak, nonatomic) IBOutlet UIScrollView *emptyScrollView;

@property (weak, nonatomic) IBOutlet UIView *guestYouLikeView;

//热门推荐
@property (weak, nonatomic) IBOutlet UILabel *hotTitleTextView;


@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UITextField *searchInput;

@end



