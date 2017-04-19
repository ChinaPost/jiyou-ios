#import <UIKit/UIKit.h>
@interface OrderFormListProductCell :UITableViewCell
//图片名
@property (weak, nonatomic) IBOutlet UIImageView *productPicImageView;
//产品名字
@property (weak, nonatomic) IBOutlet UILabel *productNameTextView;
//价格
@property (weak, nonatomic) IBOutlet UILabel *productPriceTextView;
//规格
@property (weak, nonatomic) IBOutlet UILabel *productStypeTextView;
//数量
@property (weak, nonatomic) IBOutlet UILabel *productNumTextView;
@property (weak, nonatomic) IBOutlet UIView *productView;
@property (weak, nonatomic) IBOutlet UIButton *productBtn;
@end

