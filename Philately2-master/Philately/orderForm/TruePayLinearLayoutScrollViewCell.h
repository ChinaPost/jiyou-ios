#import <UIKit/UIKit.h>
@interface TruePayLinearLayoutScrollViewCell :UITableViewCell
//实付款
@property (weak, nonatomic) IBOutlet UILabel *truePayTitleTextView;
//￥200
@property (weak, nonatomic) IBOutlet UILabel *truePayValueTextView;
//下单时间
@property (weak, nonatomic) IBOutlet UILabel *orderFormTimeTitleTextView;
//2015年08月
@property (weak, nonatomic) IBOutlet UILabel *orderFromTimeValueTextView;
@end

