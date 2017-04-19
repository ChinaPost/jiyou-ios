


//ios界面 object-c 
#import <UIKit/UIKit.h>
#import "StampTranCall.h"

#import "PromptError.h"
#import "SysBaseInfo.h"
#import "SectionRowChirld.h"
@interface FirstPageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,StampTranCallDelegate>
{
    NSTimer *timer;
}
//table
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *cacheCells;
// NSMutableArray *sectionAZDicArray;

//广告
@property (weak, nonatomic) IBOutlet UIView *guanggaoView;
@property (weak, nonatomic) IBOutlet UIScrollView *picScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *picPagecontrol;


@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UITextField *searchInput;

@property (weak, nonatomic) IBOutlet UIButton *leftMenu;


@end





