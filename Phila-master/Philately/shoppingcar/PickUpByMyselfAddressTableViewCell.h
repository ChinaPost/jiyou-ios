#import <UIKit/UIKit.h>
@interface PickUpByMyselfAddressTableViewCell :UITableViewCell
//check
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
//厚街网点
@property (weak, nonatomic) IBOutlet UILabel *networkTitleTextView;
//lineblack
@property (weak, nonatomic) IBOutlet UIImageView *lineblackImageView;
//phone
@property (weak, nonatomic) IBOutlet UILabel *phoneTextView;
//广东省
@property (weak, nonatomic) IBOutlet UILabel *addressTextView;
@end

