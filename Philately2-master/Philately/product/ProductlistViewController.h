


//ios界面 object-c 
#import <UIKit/UIKit.h>

#import "StampTranCall.h"
#import "PromptError.h"
#import "SysBaseInfo.h"
#import "SectionRowChirld.h"
#import "ProductListMenuViewController.h"



@interface ProductlistViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,StampTranCallDelegate,ChirldViewRespond>
{

    NSMutableArray *rows;
    NSMutableArray *productListData;
    
    NSMutableArray *merchTypeListData;
    
    ProductListMenuViewController *productListMenuViewController;
    
    NSMutableArray *upToLows;
    
    NSString *busiNo;
}
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIView *bottonView;

@property (strong,nonatomic) NSString *busiNo;
@property (weak, nonatomic) IBOutlet UIImageView *categateDownPic;
@property (weak, nonatomic) IBOutlet UIImageView *priceDownPic;
//list
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *cacheCells;
// NSMutableArray *sectionAZDicArray;
//back
@property (weak, nonatomic) IBOutlet UIButton *backButton;
//邮票
@property (weak, nonatomic) IBOutlet UILabel *titleTextView;
//car
@property (weak, nonatomic) IBOutlet UIImageView *carImageView;
//9
@property (weak, nonatomic) IBOutlet UILabel *carnumTextView;
//默认
@property (weak, nonatomic) IBOutlet UIButton *defaultTextView;
//价格
@property (weak, nonatomic) IBOutlet UILabel *priceTextView;
//down
@property (weak, nonatomic) IBOutlet UIImageView *downImageView;
//分类
@property (weak, nonatomic) IBOutlet UILabel *classTextView;
@end



