


//ios界面 object-c 
#import <UIKit/UIKit.h>


@protocol ChirldViewRespond;



@interface OrderFormListMenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *listData;
    
    NSString *type;//价格price 分类categate
    
    
}
@property (weak, nonatomic) IBOutlet UIView *orderNumView;
@property (weak, nonatomic) IBOutlet UIView *part1;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UITextField *orderNoValue;
//list
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *cacheCells;
@property (strong,nonatomic) id<ChirldViewRespond> chirldViewRespondDelegate;

//确定
@property (weak, nonatomic) IBOutlet UIButton *okButton;


-(void) setUiValue:(NSMutableArray*)data type:(NSString*)atype delegate:(id<ChirldViewRespond>)delegate;


@end


@protocol ChirldViewRespond <NSObject>

-(void) chirldViewRespond:(NSString*) type  data:(NSMutableArray*)data;

@end

