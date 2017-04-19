


//ios界面 object-c 
#import <UIKit/UIKit.h>
@interface RelateMobilePhoneViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    /*手机验证码发送0053*/
    NSString  *nnn0053;
    
    /*手机号码唯一校验0002*/
    NSString  *n0002;
    
    /*手机号码唯一校验0002*/
    NSString  *n0009;
    
    
    NSTimer *countDownTimer2 ;
    int secondsCountDown2 ;//60秒倒计时

}
//back
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
//back
@property (weak, nonatomic) IBOutlet UIButton *backButton;
//关联手机号
@property (weak, nonatomic) IBOutlet UILabel *titleTextView;
//手机号码：
@property (weak, nonatomic) IBOutlet UILabel *phoneTitleTextView;
//请输入新的手机号
@property (weak, nonatomic) IBOutlet UITextField *phoneValueEditText;
//验证码：
@property (weak, nonatomic) IBOutlet UILabel *validateTitleTextView;
//请输入验证码
@property (weak, nonatomic) IBOutlet UITextField *validateValueEditText;
//获取验证码
@property (weak, nonatomic) IBOutlet UIButton *getValidateButton;
//关联
@property (weak, nonatomic) IBOutlet UIButton *relateButton;
@end

