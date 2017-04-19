#import <UIKit/UIKit.h>
@interface ProductlistTableViewCell :UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *left;
@property (weak, nonatomic) IBOutlet UIView *right;
//productpicleft
@property (weak, nonatomic) IBOutlet UIButton *productpicleftImageView;
//productleftname
@property (weak, nonatomic) IBOutlet UILabel *productleftnameTextView;
//120
@property (weak, nonatomic) IBOutlet UILabel *productleftPriceTextView;
//productRigthPic
@property (weak, nonatomic) IBOutlet UIButton *productRightPicImageView;
//productRightName
@property (weak, nonatomic) IBOutlet UILabel *productRightNameTextView;
@property (weak, nonatomic) IBOutlet UIImageView *picrightstate;
//120
@property (weak, nonatomic) IBOutlet UIImageView *picleftstate;
@property (weak, nonatomic) IBOutlet UILabel *productRightPriceTextView;
@end

