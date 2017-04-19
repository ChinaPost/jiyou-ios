#import <UIKit/UIKit.h>
@interface ProductListMenuTableViewCell :UITableViewCell
//价格从低到高
@property (weak, nonatomic) IBOutlet UILabel *priceLowToHightTextView;
//select
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@end


