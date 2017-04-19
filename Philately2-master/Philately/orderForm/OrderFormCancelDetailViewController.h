


//ios界面 object-c 
#import <UIKit/UIKit.h>
@protocol OrderFormCancelDetailChirldViewCallBackDelegate;
@interface OrderFormCancelDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>

{
    NSMutableArray *chirldViewData;
    NSDictionary *dic;
}

@property (weak, nonatomic) IBOutlet UIView *otherView;

@property (weak, nonatomic) IBOutlet UIView *contain;
//请选择取消理由
@property (weak, nonatomic) IBOutlet UILabel *titleTextView;
//我不想买了
@property (weak, nonatomic) IBOutlet UILabel *row1TextView;
//选择1
@property (weak, nonatomic) IBOutlet UIButton *check1CheckBox;
//信息填写错误，重新拍
@property (weak, nonatomic) IBOutlet UILabel *row2TextView;
//选择2
@property (weak, nonatomic) IBOutlet UIButton *check2CheckBox;
//卖家缺货
@property (weak, nonatomic) IBOutlet UILabel *row3TextView;
//选择3
@property (weak, nonatomic) IBOutlet UIButton *check3CheckBox;
//其它原因
@property (weak, nonatomic) IBOutlet UILabel *rowOhterTextView;
//选择其它
@property (weak, nonatomic) IBOutlet UIButton *checkOtherCheckBox;
//xin
@property (weak, nonatomic) IBOutlet UIImageView *xinImageView;
//请输入取消原因
@property (weak, nonatomic) IBOutlet UITextField *inputDetailEditText;
//取消
@property (weak, nonatomic) IBOutlet UIButton *cacelButton;
//确定
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UIButton *check1;
@property (weak, nonatomic) IBOutlet UIButton *check2;
@property (weak, nonatomic) IBOutlet UIButton *check3;
@property (weak, nonatomic) IBOutlet UIButton *checkother;

@property (strong,nonatomic) id<OrderFormCancelDetailChirldViewCallBackDelegate> chirldViewCallBackDelegate;

-(void) setChirldViewValue:(NSMutableArray*)mdata  delegate:(id<OrderFormCancelDetailChirldViewCallBackDelegate>)parent;

@end


@protocol OrderFormCancelDetailChirldViewCallBackDelegate <NSObject>
-(void) chirldViewCallBack:(NSMutableArray*)mdata;
@end

//父亲ViewController实现接口  OrderFormCancelDetailChirldViewCallBackDelegate>
//1. OrderFormCancelDetailChirldViewCallBackDelegate
//-(void) chirldViewCallBack:(NSString*)mtype  data:(NSMutableArray*)mdata;
//2.在viewDidLoad中
//chirldViewController=[[OrderFormCancelDetailViewController alloc ] initWithNibName:@"OrderFormCancelDetailViewController" bundle:nil];
//chirldViewController.view.frame=CGRectMake(,,,);
//[ self.view addSubview:chirldViewController.view];

