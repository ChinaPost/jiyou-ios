#import <UIKit/UIKit.h>
@interface GuestYouLikeTableViewCell :UITableViewCell
//product1Pic
@property (weak, nonatomic) IBOutlet UIButton *product1PicButton;
//product1Name
@property (weak, nonatomic) IBOutlet UILabel *product1NameTextView;
//product1Price
@property (weak, nonatomic) IBOutlet UILabel *product1PriceTextView;
//product2Pic
@property (weak, nonatomic) IBOutlet UIButton *product2PicButton;
//product2Name
@property (weak, nonatomic) IBOutlet UILabel *product2NameTextView;
//product2Price
@property (weak, nonatomic) IBOutlet UILabel *product2PriceTextView;
@property (weak, nonatomic) IBOutlet UIImageView *pic3state;
//product3Pic
@property (weak, nonatomic) IBOutlet UIImageView *pic2state;
@property (weak, nonatomic) IBOutlet UIButton *product3PicButton;
//product3Name
@property (weak, nonatomic) IBOutlet UIImageView *pic1state;
@property (weak, nonatomic) IBOutlet UILabel *product3NameTextView;
//product3Price
@property (weak, nonatomic) IBOutlet UILabel *product3PriceTextView;
@property (weak, nonatomic) IBOutlet UIView *p1View;
@property (weak, nonatomic) IBOutlet UIView *p2View;
@property (weak, nonatomic) IBOutlet UIView *p3View;
@end

