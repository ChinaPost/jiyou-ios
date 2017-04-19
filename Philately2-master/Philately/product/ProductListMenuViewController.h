


//ios界面 object-c 
#import <UIKit/UIKit.h>


@protocol ChirldViewRespond;



@interface ProductListMenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *listData;
    
    NSString *type;//价格price 分类categate
    
    
}
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

