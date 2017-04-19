#import <UIKit/UIKit.h>
@interface CountMoneyLinearLayoutScrollViewCell :UITableViewCell
//商品总额
@property (weak, nonatomic) IBOutlet UILabel *productsMoneyTextView;
//￥143
@property (weak, nonatomic) IBOutlet UILabel *prodctsMoneyValueTextView;
//+运费
@property (weak, nonatomic) IBOutlet UILabel *deliverMoneyTitleTextView;
//￥12
@property (weak, nonatomic) IBOutlet UILabel *deliverMoneyValueTextView;
//扣除积分
@property (weak, nonatomic) IBOutlet UILabel *deleteIntegralTextView;
//20分
@property (weak, nonatomic) IBOutlet UILabel *deleteIntegralValueTextView;
//获取积分
@property (weak, nonatomic) IBOutlet UILabel *getIntegralTitleTextView;
//10分
@property (weak, nonatomic) IBOutlet UILabel *getIntegralValueTextView;
@end

