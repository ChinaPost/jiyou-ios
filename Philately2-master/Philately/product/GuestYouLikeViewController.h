


//ios界面 object-c 
#import <UIKit/UIKit.h>
@protocol GuestYouLikeChirldViewCallBackDelegate;
@interface GuestYouLikeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *listData;
    NSString *type;
     UIViewController *parent;
}

@property (strong,nonatomic) UIViewController *parent;
//猜你喜欢
@property (weak, nonatomic) IBOutlet UILabel *titleTextView;
//lineyellow
@property (weak, nonatomic) IBOutlet UIImageView *lineyellowImageView;
//list
@property (weak, nonatomic) IBOutlet UIView *tableView;
@property (strong, nonatomic) NSMutableDictionary *cacheCells;
@property (strong,nonatomic) id<GuestYouLikeChirldViewCallBackDelegate> chirldViewCallBackDelegate;
-(UIView*) setUiValue:(NSMutableArray*)mdata type:(NSString*)mtype delegate:(id<GuestYouLikeChirldViewCallBackDelegate>)parent;
@end
@protocol GuestYouLikeChirldViewCallBackDelegate <NSObject>
-(void) chirldViewCallBack:(NSString*)mtype  data:(NSMutableArray*)mdata;
@end

//父亲ViewController实现接口  GuestYouLikeChirldViewCallBackDelegate>
// GuestYouLikeChirldViewCallBackDelegate
//-(void) chirldViewCallBack:(NSString*)mtype  data:(NSMutableArray*)mdata;

