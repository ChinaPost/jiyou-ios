#import <UIKit/UIKit.h>
@interface OrderFormListTopCell :UITableViewCell
//金额:
@property (weak, nonatomic) IBOutlet UILabel *moneyTitleTextView;
//243
@property (weak, nonatomic) IBOutlet UILabel *moneyValueTextView;
//待付款
@property (weak, nonatomic) IBOutlet UILabel *payStateTextView;
//支付
@property (weak, nonatomic) IBOutlet UIButton *payButton;


@property (weak, nonatomic) IBOutlet UIButton *orderFormButton;
@end

