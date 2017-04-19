


//ios界面 object-c 
#import <UIKit/UIKit.h>
#import "StampTranCall.h"
#import "PromptError.h"
#import "SysBaseInfo.h"
@interface UpdatePwdViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,StampTranCallDelegate>
//确定
@property (weak, nonatomic) IBOutlet UIButton *okButton;
//back
@property (weak, nonatomic) IBOutlet UIButton *backImageView;
//修改密码
@property (weak, nonatomic) IBOutlet UILabel *titleTextView;
//旧密码
@property (weak, nonatomic) IBOutlet UILabel *oldPwdTitleTextView;
//请输入旧密码
@property (weak, nonatomic) IBOutlet UITextField *oldPwdValueEditText;
//新密码

@property (weak, nonatomic) IBOutlet UITextField *pwd;
//请输入新密码

//确认密码

@property (weak, nonatomic) IBOutlet UITextField *pwd2;
//请再输入新密码

@end

