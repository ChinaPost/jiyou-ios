


//ios界面 object-c 
#import <UIKit/UIKit.h>

#import "StampTranCall.h"

#import "PromptError.h"
#import "SysBaseInfo.h"

@interface RegistViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,StampTranCallDelegate>
@property (weak, nonatomic) IBOutlet UIButton *checkUser;
//注册
@property (weak, nonatomic) IBOutlet UIButton *rigistButton;
//back
@property (weak, nonatomic) IBOutlet UIButton *backImageView;
//用户注册
@property (weak, nonatomic) IBOutlet UILabel *titleTextView;
//登录
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
//用户名:
@property (weak, nonatomic) IBOutlet UILabel *userNameTitleTextView;
//请输入用户名
@property (weak, nonatomic) IBOutlet UITextField *userNameValueEditText;
//手机号码:
@property (weak, nonatomic) IBOutlet UILabel *phoneTitleTextView;
//请输入手机号码
@property (weak, nonatomic) IBOutlet UITextField *phoneValueEditText;
//手机验证码:
@property (weak, nonatomic) IBOutlet UILabel *codeTitleTextView;
//请输入手机验证码
@property (weak, nonatomic) IBOutlet UITextField *codeValueEditText;
//重发验证码
@property (weak, nonatomic) IBOutlet UIButton *codepicButton;
//密码:
@property (weak, nonatomic) IBOutlet UILabel *pwdTitleTextView;
//请输入密码
@property (weak, nonatomic) IBOutlet UITextField *pwdValueEditText;
//重复密码
@property (weak, nonatomic) IBOutlet UILabel *pwd2TitleTextView;
//请输入密码
@property (weak, nonatomic) IBOutlet UITextField *pwd2ValueEditText;
@end

