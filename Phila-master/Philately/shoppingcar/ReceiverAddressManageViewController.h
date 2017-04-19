


//ios界面 object-c 
#import <UIKit/UIKit.h>

#import "StampTranCall.h"
#import "PromptError.h"
#import "SysBaseInfo.h"


@interface ReceiverAddressManageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,StampTranCallDelegate>
{
    NSString *whereCome;
    bool addnewflag;
}
//list
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *cacheCells;
 //NSMutableArray *sectionAZDicArray;
//back
@property (weak, nonatomic) IBOutlet UIButton *backButton;
//收货地址
@property (weak, nonatomic) IBOutlet UILabel *titleTextView;
//添加
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (weak, nonatomic) IBOutlet UIView *headView;

@property (strong,nonatomic) NSString *whereCome;
@property (weak, nonatomic) IBOutlet UIView *emptyView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

