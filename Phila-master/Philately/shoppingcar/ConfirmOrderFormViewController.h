


//ios界面 object-c 
#import <UIKit/UIKit.h>

#import "StampTranCall.h"
#import "PromptError.h"
#import "SysBaseInfo.h"
#import "PickUpByMyselfAddressViewController.h"
#import "DateConvert.h"
@interface ConfirmOrderFormViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,StampTranCallDelegate,PickUpByMyselfAddressDelegate>
{
    
    //营销员号
    NSString *salerNo;
    //手机验证码
    NSString *phoneVerifyNo;

}

@property (weak, nonatomic) IBOutlet UILabel *needFeng;

@property (weak, nonatomic) IBOutlet UIView *veridateView;
//productlist
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UIImageView *productlistImageView;
//商品列表
@property (weak, nonatomic) IBOutlet UILabel *productlistTitleTextView;
//back
@property (weak, nonatomic) IBOutlet UIButton *backImageView;
//确认订单
@property (weak, nonatomic) IBOutlet UILabel *titleTextView;




//寄递
@property (weak, nonatomic) IBOutlet UILabel *receiverWayTitleTextView;
//right
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
//营销员号:
//@property (weak, nonatomic) IBOutlet UILabel *salerNoTitleTextView;
//请输入营销员号
//@property (weak, nonatomic) IBOutlet UITextField *salerNoValueEditText;
//验证码:
//@property (weak, nonatomic) IBOutlet UILabel *codeTitleTextView;
//请输入验证码
//@property (weak, nonatomic) IBOutlet UITextField *codeValueEditText;
//获取验证码
//@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;
//合计:
@property (weak, nonatomic) IBOutlet UILabel *totalTitleTextView;
//¥170
@property (weak, nonatomic) IBOutlet UILabel *totalValueTextView;
//提交订单
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIView *buttom1;
@property (weak, nonatomic) IBOutlet UIView *bottom2;
@property (weak, nonatomic) IBOutlet UIView *head1;
@property (weak, nonatomic) IBOutlet UIView *head2;
@property (weak, nonatomic) IBOutlet UIButton *submitOrderFromTextView;
@end




@interface OrderForm : NSObject
@property (strong,nonatomic)  NSString *orderNo;
@property (strong,nonatomic)  NSString *busiNo;
@property (strong,nonatomic)  NSString *orderPrice;

@property (nonatomic)  float subtractionPoint;

@property (strong,nonatomic)  NSString *deliverType;
@property (strong,nonatomic)  NSMutableArray *deliverWay;
@property (strong,nonatomic)  NSMutableArray *deliverWayName;
@property (strong,nonatomic)  NSMutableArray *deliverWayPrice;
@property (nonatomic)  int deliverWayWhich;

@property (strong,nonatomic)  NSString *pickupId;
@property (strong,nonatomic)  NSString *pickupAddress;
@property (strong,nonatomic)  NSString *pickupName;

@property (strong,nonatomic)  NSString *invoiceCheck;
@property (strong,nonatomic)  NSString *invoiceType;
@property (strong,nonatomic)  NSString *invoiceMsg;

@property (strong,nonatomic)  NSString *receiverName;
@property (strong,nonatomic)  NSString *receiverAddress;
@property (strong,nonatomic)  NSString *receiverPhone;
@property (strong,nonatomic)  NSString *postCode;

@property (strong,nonatomic)  NSString *addressID;
@property (strong,nonatomic)  NSString *proCode;
@property (strong,nonatomic)  NSString *cityCode;
@property (strong,nonatomic)  NSString *streemCode;
@property (strong,nonatomic)  NSString *sinceProvComp;
@property (strong,nonatomic)  NSString *sinceCityComp;


@property (strong,nonatomic)  NSMutableArray *products;

@property (strong,nonatomic)  NSString *userMark;
@end

@interface Product  : NSObject

@property (strong,nonatomic)  NSString *shoppingCartID;
@property (strong,nonatomic)  NSString *name;
@property (strong,nonatomic)  NSString *price;
@property (strong,nonatomic)  NSString *buyprice;
@property (strong,nonatomic)  NSString *number;
@property (strong,nonatomic)  NSString *productId;
@property (strong,nonatomic)  NSString *busiNo;
@property (strong,nonatomic)  NSString *normsType;
@property (strong,nonatomic)  NSString *normsName;
@end



