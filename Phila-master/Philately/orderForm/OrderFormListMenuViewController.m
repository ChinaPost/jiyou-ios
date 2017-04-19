


#import "OrderFormListMenuViewController.h"
#import "UIImageView+WebCache.h"
#import <Foundation/Foundation.h>
#import <PublicFramework/JSONKit.h>
#import <objc/runtime.h>
#import "OrderFormListMenuTableViewCell.h"
#import "RespondParam0024.h"
#import "SqlApp.h"
#import "DropDownViewController.h"

//注入table功能
NSString *OrderFromListMenuCellIdentifier = @"ProductListMenuTableViewCell";

@implementation OrderFormListMenuViewController
@synthesize cacheCells;
//list
@synthesize tableView;
//确定
@synthesize okButton;


- (void)viewDidLoad
{
    [super viewDidLoad];
    //table
    [tableView setDelegate:self];//指定委托
    [tableView setDataSource:self];//指定数据委托
    cacheCells = [NSMutableDictionary dictionary];
    
    //使用自定义的Cell,需要向UITableView进行注册
    UINib *cellNib = [UINib nibWithNibName:@"OrderFormListMenuTableViewCell" bundle:nil];
    [tableView registerNib:cellNib forCellReuseIdentifier:OrderFromListMenuCellIdentifier];
    

    
   [self.orderNoValue addTarget:self
                         action:@selector(orderNoValueClick:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    self.orderNoValue.returnKeyType=UIReturnKeyDone;
    self.orderNoValue.keyboardType=UIKeyboardTypeNumberPad;

    [self.okButton addTarget:self action:@selector(okButtonclicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UITapGestureRecognizer* closeKeyboardtap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKeyboard)];
    [self.backgroundView addGestureRecognizer:closeKeyboardtap];
    
    
    UITapGestureRecognizer* closeKeyboardtap2 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKeyboard2)];
      [self.orderNumView addGestureRecognizer:closeKeyboardtap2];
}

-(void)closeKeyboard
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

-(void)closeKeyboard2
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

-(void)orderNoValueClick:(UITextField*)txt
{
    [self.view becomeFirstResponder];
}

-(void)okButtonclicked:(UIButton *)btn{
    [self.view becomeFirstResponder];
     [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    //objc_setAssociatedObject(btn, "productId", productId, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//控件与数据绑定
  
    
    [self.chirldViewRespondDelegate chirldViewRespond:self.orderNoValue.text data:listData];
    
      self.orderNoValue.text=@"";
  
}

//-(void)handTap{
//    [self presentViewController:updatePwdViewController animated:NO completion:^{}];
//[self dismissViewControllerAnimated:NO completion:^(){}];
//}


-(void) viewWillAppear:(BOOL)animated{
    //table
//    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}




//指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;//返回标题数组中元素的个数来确定分区的个数   return [sections count];
}

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  [listData count];
    
}

//绘制Cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderFormListMenuTableViewCell *cell = (OrderFormListMenuTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:OrderFromListMenuCellIdentifier];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductListMenuTableViewCell" owner:self options:nil] lastObject];
    }
    

    
   BOOL isSelect= ((DropDownRow *)[listData objectAtIndex:indexPath.row]).check;
    
    if (isSelect) {
        
        
      [cell.selectButton setBackgroundImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateNormal];
    }else
    {
       [cell.selectButton setBackgroundImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    }
    
    
    //价格从低到高
    cell.priceLowToHightTextView.text= ((DropDownRow *)[listData objectAtIndex:indexPath.row]).rowMsg;
    
    
    return cell;
    
}

//关键方法，获取复用的Cell后模拟赋值，然后取得Cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier = OrderFromListMenuCellIdentifier;
    OrderFormListMenuTableViewCell *cell= [self.cacheCells objectForKey:reuseIdentifier];
    if (!cell) {
        cell=[self.tableView dequeueReusableCellWithIdentifier:OrderFromListMenuCellIdentifier];
        [self.cacheCells setObject:cell forKey:reuseIdentifier];
        
  
    }
    
    // CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];//autolayout有效 配合上边使用
    int height=cell.contentView.frame.size.height;//非动态高度(row1跟row2同样高)变化适用 不需配合上边使用
    return height;
}

-(void)viewDidLayoutSubviews
{//table被挡住时用
    // int viewHeight=self.view.frame.size.height;
    //int i=okButton.frame.origin.y;
    
 //   [tableView setFrame:CGRectMake(0, 0, okButton.frame.size
                                //   .width,okButton.frame.origin.y
                                  // )];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88;
}

//点击后，过段时间cell自动取消选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.05f];
    
    for (int i=0; i<[listData count]; i++) {
        if(i==indexPath.row)
        {
            ((DropDownRow *)[listData objectAtIndex:i ]).check=YES;
            
        }else
        {
         ((DropDownRow *)[listData objectAtIndex:i]).check=NO;
        }
    }
    
     [self.tableView reloadData];
    
    
}

- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

//RespondParam0024
-(void) setUiValue:(NSMutableArray*)data type:(NSString*)atype delegate:(id<ChirldViewRespond>)delegate{
   
    self.chirldViewRespondDelegate=delegate;
    
    listData=data;
   [tableView reloadData];
}


@end


