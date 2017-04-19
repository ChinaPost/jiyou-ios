


#import <UIKit/UIKit.h>
#import   <ServiceInvoker.h>
@interface AboutViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,ServiceInvokerDelegate,UIAlertViewDelegate>
{
    ServiceInvoker *serviceInvoker;
       NSString *appUrl;
}
@property (weak, nonatomic) IBOutlet UIView *head;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
//产品图片
@property (weak, nonatomic) IBOutlet UIImageView *projectPicImageView;
//中国集邮
@property (weak, nonatomic) IBOutlet UILabel *projectNameTextView;
//当前版本：
@property (weak, nonatomic) IBOutlet UILabel *versionTitleTextView;
//2.9.1
@property (weak, nonatomic) IBOutlet UILabel *versionTextView;
//更新日期：
@property (weak, nonatomic) IBOutlet UILabel *updateTimeTextView;
//20150101
@property (weak, nonatomic) IBOutlet UILabel *updateTimeValueTextView;
//中共集邮
@property (weak, nonatomic) IBOutlet UILabel *detailTextView;
//二维码
@property (weak, nonatomic) IBOutlet UIImageView *twoLevevImageView;
//扫描二维码你的朋友也可下载中国集邮客户端
@property (weak, nonatomic) IBOutlet UILabel *shaoTextView;
//检测更新
@property (weak, nonatomic) IBOutlet UIButton *checkUpdateButton;
//Copyright@2015中国邮政集邮公司版权所有
@property (weak, nonatomic) IBOutlet UILabel *whosTextView;
//back
@property (weak, nonatomic) IBOutlet UIButton *backButton;
//关于我们
@property (weak, nonatomic) IBOutlet UILabel *titleTextView;
@end

