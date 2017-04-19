#import <UIKit/UIKit.h>
@interface ConfirmOrderFormCell41 :UITableViewCell
//配送方式:
@property (weak, nonatomic) IBOutlet UILabel *deliverWayTitleTextView;
//ems
@property (weak, nonatomic) IBOutlet UILabel *deliverWayValueTextView;

//小计：
@property (weak, nonatomic) IBOutlet UILabel *minTotalTitleTextView;
//90
@property (weak, nonatomic) IBOutlet UILabel *minTotalValueTextView;
@property (weak, nonatomic) IBOutlet UIButton *pickupSelectBtn;

@end

