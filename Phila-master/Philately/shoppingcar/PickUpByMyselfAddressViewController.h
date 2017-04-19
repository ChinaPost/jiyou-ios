


//ios界面 object-c 
#import <UIKit/UIKit.h>

#import "StampTranCall.h"
#import "PromptError.h"
#import "SysBaseInfo.h"
#import "DropDownViewController.h"
@protocol PickUpByMyselfAddressDelegate;

@interface PickUpByMyselfAddressViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,StampTranCallDelegate,DropDownDelegate>

{
    int  orderFormIndex;
    
    NSString *sinceProvComp;
    NSString *sinceCityComp;
    
    
    NSString *pickupId;
    NSString *pickupAddress;
    NSString *pickupName;
    
    
    NSString *proviendCode;
    NSString *cityCode;
    NSString *streemCode;
    
    
    int page;
    int totalRowCount;
    int currentRowCount;
    bool requestUnComplete;//发完一个请求再发下一个
    NSMutableArray *allIndexpaths;
 

}
@property (weak, nonatomic) IBOutlet UIView *head2View;
@property (weak, nonatomic) IBOutlet UIView *head1View;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic) int orderFormIndex;

@property (strong, nonatomic)  NSString *sinceProvComp;
@property (strong, nonatomic)  NSString *sinceCityComp;

//list
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *cacheCells;
// NSMutableArray *sectionAZDicArray;
//back
@property (weak, nonatomic) IBOutlet UIButton *backButton;
//选择自提点
@property (weak, nonatomic) IBOutlet UILabel *titleTextView;
//广东
@property (weak, nonatomic) IBOutlet UIButton *proviceTextView;
//down
@property (weak, nonatomic) IBOutlet UIImageView *downImageView;
//linevertical
@property (weak, nonatomic) IBOutlet UIImageView *lineverticalImageView;
//东莞市
@property (weak, nonatomic) IBOutlet UIButton *cityTextView;
//厚街
@property (weak, nonatomic) IBOutlet UIButton *streemTextView;
//query
@property (weak, nonatomic) IBOutlet UIButton *queryImageView;
//checkAgress
@property (weak, nonatomic) IBOutlet UIButton *checkAgressButton;
//我已阅读并同意自提协议
@property (weak, nonatomic) IBOutlet UILabel *agreemsgTextView;
//确定
@property (weak, nonatomic) IBOutlet UIButton *sureButton;

@property (strong,nonatomic) id<PickUpByMyselfAddressDelegate> mdelegate;

@property (nonatomic) int whichForm;

-(void)setProucts:(NSMutableArray*)products btn:(UIButton*)btn delegate:(id<PickUpByMyselfAddressDelegate>) delegate whichForm:(int)whichForm;

@end


@protocol PickUpByMyselfAddressDelegate <NSObject>

-(void) pickUpAddressCallBack:(int)whichForm addressId:(NSString*)addressId address:(NSString*)address name:(NSString*)name;

@end

