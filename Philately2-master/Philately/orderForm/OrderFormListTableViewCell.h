#import <UIKit/UIKit.h>
@interface OrderFormListTableViewCell :UITableViewCell
//订单号
@property (weak, nonatomic) IBOutlet UILabel *orderFormNumTitleTextView;
//7899898
@property (weak, nonatomic) IBOutlet UILabel *orderFormNumValueTextView;
//订单金额
@property (weak, nonatomic) IBOutlet UILabel *orderFormMoneyTitleTextView;
//money
@property (weak, nonatomic) IBOutlet UIImageView *moneyImageView;
//243
@property (weak, nonatomic) IBOutlet UILabel *orderFormMoneyValueTextView;
//下单时间
@property (weak, nonatomic) IBOutlet UILabel *orderFormTimeTitleTextView;
//23434343
@property (weak, nonatomic) IBOutlet UILabel *orderFormTimeTextView;
//订单状态
@property (weak, nonatomic) IBOutlet UILabel *orderFormStatteTitleTextView;
//等待支付
@property (weak, nonatomic) IBOutlet UILabel *orderFormStateValueTextView;
@end

