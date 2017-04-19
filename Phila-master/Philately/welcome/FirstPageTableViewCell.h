#import <UIKit/UIKit.h>
@interface FirstPageTableViewCell :UITableViewCell
//a
@property (weak, nonatomic) IBOutlet UILabel *pic1name;
@property (weak, nonatomic) IBOutlet UILabel *pic1price;
@property (weak, nonatomic) IBOutlet UIButton *pic1;

@property (weak, nonatomic) IBOutlet UILabel *pic2name;
@property (weak, nonatomic) IBOutlet UILabel *pic2price;
@property (weak, nonatomic) IBOutlet UIButton *pic2;

@property (weak, nonatomic) IBOutlet UILabel *pic3name;
@property (weak, nonatomic) IBOutlet UILabel *pic3price;
@property (weak, nonatomic) IBOutlet UIButton *pic3;
@property (weak, nonatomic) IBOutlet UIImageView *pic1state;
@property (weak, nonatomic) IBOutlet UIImageView *pic2state;
@property (weak, nonatomic) IBOutlet UIImageView *pic3state;
@property (weak, nonatomic) IBOutlet UIView *pic1view;
@property (weak, nonatomic) IBOutlet UIView *pic2view;
@property (weak, nonatomic) IBOutlet UIView *pic3view;

@end

