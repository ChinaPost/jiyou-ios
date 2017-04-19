


#import "OrderFormCancelDetailViewController.h"
#import "UIImageView+WebCache.h"
#import <Foundation/Foundation.h>
#import <PublicFramework/JSONKit.h>
#import <objc/runtime.h>
#import "WhyLinearLayoutScrollViewCell.h"
#import "SqlApp.h"
#import "DropDownViewController.h"

@implementation OrderFormCancelDetailViewController
{
    NSMutableArray *arr;
}
//请选择取消订单的理由
@synthesize titleTextView;
//取消
@synthesize cancelButton;
//确定
@synthesize sureButton;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    
    [self.cancelButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    [self.sureButton addTarget:self action:@selector(sureButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    SqlApp *sqlApp=[[SqlApp alloc ]init ];
    arr=[sqlApp selectPM_ARRAYSERVICE:@"CANCELREASON"];
    [self scrollUI];
}

-(void) viewWillAppear:(BOOL)animated{
}

-(void)cancelButtonClicked:(UIButton *)btn{
    id mId = objc_getAssociatedObject(btn, "mId");
    //取绑定数据int mId2 = btn.tag;
    //取绑定数据
}

-(void)sureButtonClicked:(UIButton *)btn{
    id mId = objc_getAssociatedObject(btn, "mId");
    //取绑定数据int mId2 = btn.tag;
    //取绑定数据
}


-(void) scrollUI{
    
    
    
    int height=0;
    int width=self.bg1446108292981ScrollView.frame.size.width;
    int x=0;
    int y=0;
    
    WhyLinearLayoutScrollViewCell *whyLinearLayout = [[[NSBundle mainBundle] loadNibNamed:@"WhyLinearLayoutScrollViewCell"  owner:self options:nil] lastObject];
    
    int i=0;
    for (DropDownRow *dropdownrow in arr) {
        
        
        [whyLinearLayout setFrame:CGRectMake(x, y+height, width, whyLinearLayout.frame.size.height)];
        height+=whyLinearLayout.frame.size.height;
        [self.bg1446108292981ScrollView addSubview:whyLinearLayout];
        
        whyLinearLayout.whyCheckCheckBox.tag=i;
        // objc_setAssociatedObject(whyLinearLayout.whyCheckCheckBox, "DropDownRow", dropdownrow, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//控件与数据绑定
        //
        [whyLinearLayout.whyCheckCheckBox addTarget:self action:@selector(whyCheckCheckBoxCheck:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //其它原因
        [whyLinearLayout.whyTitleTextView setText:dropdownrow.rowMsg];
        
        
        if ([dropdownrow.rowMsg2 isEqualToString:@"1"]) {//选中
            
            [whyLinearLayout.whyCheckCheckBoxCover setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
            
            
        }else
        {
            [whyLinearLayout.whyCheckCheckBoxCover setBackgroundImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        }
        
        i++;
        
    }
    
    //scrollView
    self.bg1446108292981ScrollView.contentSize=CGSizeMake(width, height);
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.bg1446108292981ScrollView.contentInset = contentInsets;
    self.bg1446108292981ScrollView.scrollIndicatorInsets = contentInsets;
    
    // [self.bg1446108292981ScrollView setFrame:CGRectMake(0, self.head.frame.size.height, self.bg1446108292981ScrollView.frame.size.width, self.view.frame.size.height-self.head.frame.size.height-self.bottom.frame.size.height)];
    
}


-(void)whyCheckCheckBoxCheck:(UIButton *)btn{
    //DropDownRow *dropDownRow = objc_getAssociatedObject(btn, "DropDownRow");
    int mId = btn.tag;
    //取绑定数据  btn.selected = !btn.selected ;//用与button做checkBox
    
    
    
    
    int i=0;
    for (DropDownRow *row in arr ) {
        
        if (i==mId) {
            row.rowMsg2=@"1";
        }else
        {
            row.rowMsg2=@"0";
        }
        i++;
    }
    
    [self scrollUI];
    
    
}




@end//end viewController

