


//ios界面 object-c 
#import <UIKit/UIKit.h>
#import "StampTranCall.h"
#import "PromptError.h"
#import "SysBaseInfo.h"
#import "DropDownForOrderForm.h"
#import "OrderFormListMenuViewController.h"
#import "OrderPay0039.h"
@interface OrderFormListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,StampTranCallDelegate,DropDownDelegate,ChirldViewRespond,OrderPay0039Delegate>
{
 DropDownForOrderForm *dropDown;
    
    NSString *startDate;
    NSString *orderFormNum;
    
    //订单类型
    NSString *orderFormTypeName;
    NSString *orderFormTypeNo;
    
    //全部color
    UIColor *checkColor;
    UIColor *uncheckColor;
    
    
    bool waitPay;
    bool waitReceive;
    bool all;
    
    NSMutableArray *views;
}
@property (weak, nonatomic) IBOutlet UIImageView *queryLabelDown;

@property (weak, nonatomic) IBOutlet UILabel *queryLabel;

@property (weak, nonatomic) IBOutlet UIView *head2;
@property (strong, nonatomic) NSString *orderFormTypeName;
@property (strong, nonatomic) NSString *orderFormTypeNo;



@property ( nonatomic) bool waitPay;
@property ( nonatomic) bool waitReceive;
@property ( nonatomic) bool all;


//list
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *cacheCells;
 //NSMutableArray *sectionAZDicArray;
//back
@property (weak, nonatomic) IBOutlet UIButton *backImageView;
//新邮预订订单
@property (weak, nonatomic) IBOutlet UIButton *titleTextView;
//down
@property (weak, nonatomic) IBOutlet UIImageView *downImageView;
//query
@property (weak, nonatomic) IBOutlet UIButton *queryImageView;
//近一月
@property (weak, nonatomic) IBOutlet UILabel *nearMonthTextView;
//一年
@property (weak, nonatomic) IBOutlet UILabel *yearTextView;
//全部

@property (weak, nonatomic) IBOutlet UILabel *allTextView;



@property (weak, nonatomic) IBOutlet UIView *headView;


////menu
//@property (weak, nonatomic) IBOutlet UIButton *waitPayBtn;
//@property ( nonatomic) BOOL waitPayBool;
//
//@property (weak, nonatomic) IBOutlet UIButton *alreadyDeleteBtn;
//@property ( nonatomic) BOOL alreadyDeleteBool;
//
//@property (weak, nonatomic) IBOutlet UIButton *allBtn;
//@property ( nonatomic) BOOL allBool;
//
//@property (weak, nonatomic) IBOutlet UIButton *waitReceiveBtn;
//@property ( nonatomic) BOOL waitReceiveBool;
//
//@property (weak, nonatomic) IBOutlet UIButton *dealOkBtn;
//@property ( nonatomic) BOOL dealOkBool;
//
//@property (weak, nonatomic) IBOutlet UITextField *inputOrderNumEdit;
//
//@property (weak, nonatomic) IBOutlet UIButton *queryNowBtn;
//@property ( nonatomic) BOOL queryNowBool;
//


@end

