


//ios界面 object-c 
#import <UIKit/UIKit.h>
@interface OrderFormCancelDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

{

}
//请选择取消订单的理由
@property (weak, nonatomic) IBOutlet UILabel *titleTextView;
@property (weak, nonatomic) IBOutlet UIScrollView *bg1446108292981ScrollView;
//取消
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
//确定
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@end

