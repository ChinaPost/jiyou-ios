#import <UIKit/UIKit.h>
@interface ConfirmOrderFormCell4 :UITableViewCell
//配送方式:
@property (weak, nonatomic) IBOutlet UILabel *deliverWayTitleTextView;
//ems
@property (weak, nonatomic) IBOutlet UIButton *deliverWayValueTextView;
//寄递费
@property (weak, nonatomic) IBOutlet UILabel *deliverWayPriceTextView;
//10
@property (weak, nonatomic) IBOutlet UILabel *deliverWayPriceValueTextView;
//小计：
@property (weak, nonatomic) IBOutlet UILabel *minTotalTitleTextView;
//90
@property (weak, nonatomic) IBOutlet UILabel *minTotalValueTextView;
@property (weak, nonatomic) IBOutlet UIView *part1;
@property (weak, nonatomic) IBOutlet UIView *part2;
@property (weak, nonatomic) IBOutlet UIView *part3;


@property (weak, nonatomic) IBOutlet UIButton *pickupSelectBtn;
@property (weak, nonatomic) IBOutlet UILabel *pickupName;

@end

