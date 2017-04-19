#import <UIKit/UIKit.h>
@interface OrderFormListBottomCell :UITableViewCell
//店铺图标
@property (weak, nonatomic) IBOutlet UIImageView *shopPicImageView;
//广东邮政公司
@property (weak, nonatomic) IBOutlet UILabel *shopNameTextView;
//时间
@property (weak, nonatomic) IBOutlet UILabel *orderFormTimeTextView;
@end

