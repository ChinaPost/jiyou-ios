


#import "ProductListMenuViewController.h"
#import "UIImageView+WebCache.h"
#import <Foundation/Foundation.h>
#import <PublicFramework/JSONKit.h>
#import <objc/runtime.h>
#import "ProductListMenuTableViewCell.h"
#import "RespondParam0024.h"
//注入table功能
NSString *ProductListMenuCellIdentifier = @"ProductListMenuTableViewCell";
NSString *ProductListMenuCellHeadIdentifier = @"ProductListMenuTableViewCellHead";
@implementation ProductListMenuViewController
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
    UINib *cellNib = [UINib nibWithNibName:@"ProductListMenuTableViewCell" bundle:nil];
    [tableView registerNib:cellNib forCellReuseIdentifier:ProductListMenuCellIdentifier];
    


    
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handTap)];
    //    [self.modifyPwdTextView addGestureRecognizer:tap];
    //
    [self.okButton addTarget:self action:@selector(okButtonclicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)okButtonclicked:(UIButton *)btn{
    //objc_setAssociatedObject(btn, "productId", productId, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//控件与数据绑定
    id productId = objc_getAssociatedObject(btn, "productId");
    //取数据  //btn.selected = !btn.selected;
    //用于butoon做checkBox控件
    
    [self.chirldViewRespondDelegate chirldViewRespond:type data:listData];
    self.view.hidden=YES;
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
    
    ProductListMenuTableViewCell *cell = (ProductListMenuTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:ProductListMenuCellIdentifier];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductListMenuTableViewCell" owner:self options:nil] lastObject];
    }
    

    
   BOOL isSelect= ((RespondParam0024 *)[listData objectAtIndex:indexPath.row]).priceLowToUpBool;
    
    if (isSelect) {
        
        
      [cell.selectButton setBackgroundImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateNormal];
    }else
    {
       [cell.selectButton setBackgroundImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    }
    
    
    //价格从低到高
    cell.priceLowToHightTextView.text= ((RespondParam0024 *)[listData objectAtIndex:indexPath.row]).priceLowToUp;
    
    
    return cell;
    
}

//关键方法，获取复用的Cell后模拟赋值，然后取得Cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier = ProductListMenuCellIdentifier;
    ProductListMenuTableViewCell *cell= [self.cacheCells objectForKey:reuseIdentifier];
    if (!cell) {
        cell=[self.tableView dequeueReusableCellWithIdentifier:ProductListMenuCellIdentifier];
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
            ((RespondParam0024 *)[listData objectAtIndex:i ]).priceLowToUpBool=YES;
            
        }else
        {
         ((RespondParam0024 *)[listData objectAtIndex:i]).priceLowToUpBool=NO;
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
    type=atype;
    self.chirldViewRespondDelegate=delegate;
    
    listData=data;
   [tableView reloadData];
}


@end


