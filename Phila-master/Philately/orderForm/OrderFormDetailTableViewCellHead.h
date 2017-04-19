#import <UIKit/UIKit.h>
@interface OrderFormDetailTableViewCellHead :UITableViewCell
//名
@property (weak, nonatomic) IBOutlet UILabel *productNameTextView;
//2件
@property (weak, nonatomic) IBOutlet UILabel *productNumTextView;
//56
@property (weak, nonatomic) IBOutlet UILabel *productPriceTextView;
//right

//line
@property (weak, nonatomic) IBOutlet UIImageView *lineImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rihgtImageView;
@property (weak, nonatomic) IBOutlet UIView *partProduct;

@property (weak, nonatomic) IBOutlet UILabel *stype;



@end

