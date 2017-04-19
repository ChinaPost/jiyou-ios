#import <UIKit/UIKit.h>
@interface ReceiverAddressManageTableViewCell :UITableViewCell
//check
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
//默认地址
@property (weak, nonatomic) IBOutlet UILabel *defaultAddressTitleTextView;
//删除
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
//lineblack
@property (weak, nonatomic) IBOutlet UIImageView *lineblackImageView;
//收货人:
@property (weak, nonatomic) IBOutlet UILabel *reciverTitleTextView;
//大大白
@property (weak, nonatomic) IBOutlet UILabel *receiverValueTextView;
//13923
@property (weak, nonatomic) IBOutlet UILabel *phoneTextView;
//广东省东莞
@property (weak, nonatomic) IBOutlet UILabel *addressTextView;
//524000
@property (weak, nonatomic) IBOutlet UILabel *postcodeTextView;

//right
@property (weak, nonatomic) IBOutlet UILabel *isDefaultView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@end

