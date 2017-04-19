


//ios界面 object-c 
#import <UIKit/UIKit.h>
#import "DropDownViewController.h"

#import "CountyViewController.h"
#import "StampTranCall.h"
#import "ShipAddressEntity.h"


@interface AddAddressViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,DropDownDelegate,StampTranCallDelegate>
//back
@property (weak, nonatomic) IBOutlet UIButton *backButton;
//新建地址
@property (weak, nonatomic) IBOutlet UILabel *titleTextView;
//保存
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
//必填
@property (weak, nonatomic) IBOutlet UIImageView *mustinputImageView;
//姓名
@property (weak, nonatomic) IBOutlet UILabel *usernameTitleTextView;
//最少两个字
@property (weak, nonatomic) IBOutlet UITextField *usernameValueEditText;
//lineblack
@property (weak, nonatomic) IBOutlet UIImageView *lineblackImageView;
//手机
@property (weak, nonatomic) IBOutlet UILabel *phoneTitleTextView;
//请输入手机号码
@property (weak, nonatomic) IBOutlet UITextField *phoneValueTextView;
//地区
@property (weak, nonatomic) IBOutlet UILabel *areaTitleTextView;
//广东
@property (weak, nonatomic) IBOutlet UIButton *provinceTextView;
//down
@property (weak, nonatomic) IBOutlet UIImageView *downImageView;
//东莞
@property (weak, nonatomic) IBOutlet UIButton *cityTextView;
//虎门
@property (weak, nonatomic) IBOutlet UIButton *streemTextView;
//地址
@property (weak, nonatomic) IBOutlet UILabel *addressTitleTextView;
//最少五个字，精确到门牌号
@property (weak, nonatomic) IBOutlet UITextField *addressValueTextView;
//邮编:
@property (weak, nonatomic) IBOutlet UILabel *areacodeTitleTextView;
//6位邮政编码
@property (weak, nonatomic) IBOutlet UITextField *areacodeValueEditText;
//check
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
//设为默认地址
@property (weak, nonatomic) IBOutlet UILabel *defaultTextView;





@property (weak, nonatomic) IBOutlet UILabel *lbtitle;

@property (weak, nonatomic) IBOutlet UIButton *goback;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UITextField *tfname;
@property (weak, nonatomic) IBOutlet UITextField *tfmobile;
@property (weak, nonatomic) IBOutlet UILabel *lbprov;
@property (weak, nonatomic) IBOutlet UILabel *lbcity;
@property (weak, nonatomic) IBOutlet UILabel *lbcounty;
@property (weak, nonatomic) IBOutlet UITextField *tfaddr;

@property (weak, nonatomic) IBOutlet UITextField *tfpostcode;
@property (weak, nonatomic) IBOutlet UIControl *cityView;
@end

