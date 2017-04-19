#import <UIKit/UIKit.h>
@interface ConfirmOrderFormCell3 :UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *part1;
@property (weak, nonatomic) IBOutlet UIView *part2;

//开具发票
@property (weak, nonatomic) IBOutlet UILabel *invoiceTitleTextView;
//invoiceCheck
@property (weak, nonatomic) IBOutlet UIButton *invoiceCheckButton;
@property (weak, nonatomic) IBOutlet UIButton *invoiceCheckButtonCover;
//发票类型
@property (weak, nonatomic) IBOutlet UILabel *invoiceTypeTitleTextView;
//pesonCheck
@property (weak, nonatomic) IBOutlet UIButton *personCheckButton;
@property (weak, nonatomic) IBOutlet UIButton *personCheckButtonCover;
//个人
@property (weak, nonatomic) IBOutlet UILabel *personCheckTitleTextView;
//companyCheck
@property (weak, nonatomic) IBOutlet UIButton *companyCheckButton;
@property (weak, nonatomic) IBOutlet UIButton *companyCheckButtonCover;
//单位
@property (weak, nonatomic) IBOutlet UILabel *companyCheckTitleTextView;
//发票抬头
@property (weak, nonatomic) IBOutlet UILabel *invoiceHeadTitleTextView;
//请输入发票抬头
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UITextField *invoiceHeadValueEditText;
@end

