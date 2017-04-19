//ios界面 object-c
#import <UIKit/UIKit.h>

#import "StampTranCall.h"

#import "PromptError.h"
#import "SysBaseInfo.h"

@interface FindPwdViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,StampTranCallDelegate,UITextFieldDelegate>
//找回新密码
@property (weak, nonatomic) IBOutlet UIButton *findpwdButton;
//back
@property (weak, nonatomic) IBOutlet UIButton *backImageView;
//找回密码
@property (weak, nonatomic) IBOutlet UILabel *titleTextView;
//手机号码
@property (weak, nonatomic) IBOutlet UILabel *phoneTitleTextView;
//请输入手机号
@property (weak, nonatomic) IBOutlet UITextField *phoneValueEditText;
//获取验证码
@property (weak, nonatomic) IBOutlet UIButton *getcodeButton;
//验证码
@property (weak, nonatomic) IBOutlet UILabel *codeTitleTextView;
//请输入验证码
@property (weak, nonatomic) IBOutlet UITextField *codeValueEditText;
//新密码
@property (weak, nonatomic) IBOutlet UILabel *newpwdTitleTextView;
//请输入新密码
@property (weak, nonatomic) IBOutlet UITextField *newpwdValueEditText;
//确认新密码
@property (weak, nonatomic) IBOutlet UILabel *newpwd2TitleTextView;
//请再输入新密码
@property (weak, nonatomic) IBOutlet UITextField *newpwd2ValueEditText;
@end
