//注入网络请求,响应,等待提示



#import "OrderFormListViewController.h"
#import "UIImageView+WebCache.h"
#import <Foundation/Foundation.h>
#import <PublicFramework/JSONKit.h>
#import "OrderFormListTableViewCell.h"
#import "RespondParam0040.h"

#import "SqlApp.h"
#import "OrderFormDetailViewController.h"
#import "MoreTableViewCell.h"
#import "ProductOrderForm.h"
#import "DateConvert.h"
#import "OrderFormListMenuViewController.h"
#import "Toast+UIView.h"
#import "OrderFormListBottomCell.h"
#import "OrderFormListTopCell.h"
#import "OrderFormListProductCell.h"
#import <objc/runtime.h>
#import "PayedSuccessViewController.h"

//注入table功能
NSString *OrderFormListCellIdentifier = @"OrderFormListTableViewCell";
@implementation OrderFormListViewController
@synthesize cacheCells;
//list
@synthesize tableView;
//back
@synthesize backImageView;
//新邮预订订单
@synthesize titleTextView;
//down
@synthesize downImageView;
//query
@synthesize queryImageView;
//近一月
@synthesize nearMonthTextView;
//一年
@synthesize yearTextView;
//全部
@synthesize allTextView;

int totalCount;
int currentCount;




@synthesize orderFormTypeName;

@synthesize orderFormTypeNo;


@synthesize waitPay;
@synthesize waitReceive;
@synthesize all;

NSMutableArray *oderFormListlistData;
NSString *queryOrderNo;
NSString *queryOrderStatus;
NSMutableArray *menulistData;

int page;
NSMutableArray *allindexpaths2;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    totalCount=0;
    currentCount=0;
    page=1;
    
     allindexpaths2=[[NSMutableArray alloc] init];
    //table
    [tableView setDelegate:self];//指定委托
    [tableView setDataSource:self];//指定数据委托
      self.tableView.tableFooterView=[[UIView alloc]init];//关键语句
    cacheCells = [NSMutableDictionary dictionary];
    
    //使用自定义的Cell,需要向UITableView进行注册
    UINib *cellNib = [UINib nibWithNibName:@"OrderFormListTableViewCell" bundle:nil];
    [tableView registerNib:cellNib forCellReuseIdentifier:OrderFormListCellIdentifier];
    
     //UITapGestureRecognizer *queryImageViewtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(queryImageViewhandTap)];
    //[self.queryImageView addGestureRecognizer:queryImageViewtap];
    
    UITapGestureRecognizer *queryImageViewtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(queryImageViewhandTap)];
    [self.queryLabel addGestureRecognizer:queryImageViewtap];
    
    
    oderFormListlistData=[[NSMutableArray alloc]init];
    
    orderFormListMenuViewController=nil;
    
    SqlApp *sqlApp=[[SqlApp alloc ]init ];
    NSString *cnbusinTyp=[sqlApp selectPM_ARRAYSERVICEByCode:@"BUSINESS" code:orderFormTypeNo ];
   [self.titleTextView setTitle:cnbusinTyp forState:UIControlStateNormal];
    
    
  //标题
    [self.titleTextView addTarget:self action:@selector(titleTextViewClicked:) forControlEvents:UIControlEventTouchUpInside];

   
 
    
    
    //近一月
    UITapGestureRecognizer *nearMonthTextViewtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nearMonthTextViewhandTap)];
    [self.nearMonthTextView addGestureRecognizer:nearMonthTextViewtap];
    uncheckColor=self.nearMonthTextView.textColor;

    
    //一年
    UITapGestureRecognizer *yearTextViewtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yearTextViewhandTap)];
    [self.yearTextView addGestureRecognizer:yearTextViewtap];
  
    
    //全部
    UITapGestureRecognizer *allTextViewtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(allTextViewhandTap)];
    [self.allTextView addGestureRecognizer:allTextViewtap];

    
    
    UITapGestureRecognizer *backImageViewtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backImageViewHandTap)];
    [self.backImageView addGestureRecognizer:backImageViewtap];
    
    checkColor= self.allTextView.textColor;
    
    startDate=@"";
    orderFormNum=@"";
    
    
    SqlApp *sql=[[SqlApp alloc] init];
    menulistData=[sql selectPM_ARRAYSERVICE:@"ORDERQUERYSTATUS"];
    
    NSString *statue=@"";
    if(self.waitPay)
    {
        statue=@"02";
    }
    else if(self.waitReceive)
    {
        statue=@"09";
    }
    else if(self.all)
    {
        statue=@"00";
        
    }else
    {
        statue=@"02";
    }
    queryOrderStatus=statue;
    
    for (DropDownRowForOrderForm *row in menulistData  ) {
        if([row.rowId isEqualToString:statue])
        {
            row.check=YES;
        }
    }

    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    
    [self request0040:NO];
    
    UITapGestureRecognizer* closeKeyboardtap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKeyboard)];
    [self.headView addGestureRecognizer:closeKeyboardtap];
    
    
    views=[[NSMutableArray alloc] init];
}

-(void)closeKeyboard
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

-(void) backImageViewHandTap
{
   [self dismissViewControllerAnimated:NO completion:^(){}];
    [self.navigationController popViewControllerAnimated:YES];

}

-(void) nearMonthTextViewhandTap
{
    orderFormListMenuViewController.view.hidden=YES;
    
    
    [self.queryLabelDown setImage:[UIImage imageNamed:@"down.png"]];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:[[NSDate alloc] init]];
    
    [components setHour:-[components hour]];
    [components setMinute:-[components minute]];
    [components setSecond:-[components second]];
    NSDate *today = [cal dateByAddingComponents:components toDate:[[NSDate alloc] init] options:0]; //This variable should now be pointing at a date object that is the start of today (midnight);
    
    components = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[[NSDate alloc] init]];
    
    [components setDay:([components day] - 30)];
    NSDate *nearMonth  = [cal dateFromComponents:components];
   
    NSDateFormatter *f=[[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy-MM-dd"];
    startDate=[f stringFromDate:nearMonth];
    
    self.nearMonthTextView.textColor=checkColor;
    self.yearTextView.textColor=uncheckColor;
    self.allTextView.textColor=uncheckColor;
    [self request0040:NO];
}

-(void) yearTextViewhandTap
{
    orderFormListMenuViewController.view.hidden=YES;
    
    
    [self.queryLabelDown setImage:[UIImage imageNamed:@"down.png"]];
    
    self.nearMonthTextView.textColor=uncheckColor;
    self.yearTextView.textColor=checkColor;
    self.allTextView.textColor=uncheckColor;
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:[[NSDate alloc] init]];
    
    [components setHour:-[components hour]];
    [components setMinute:-[components minute]];
    [components setSecond:-[components second]];
    NSDate *today = [cal dateByAddingComponents:components toDate:[[NSDate alloc] init] options:0]; //This variable should now be pointing at a date object that is the start of today (midnight);
    
    components = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[[NSDate alloc] init]];
    
    [components setDay:([components day] - 365)];
    NSDate *nearYear  = [cal dateFromComponents:components];
    
    
    NSDateFormatter *f=[[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy-MM-dd"];
    startDate=[f stringFromDate:nearYear];
    

    [self request0040:NO];
}


-(void) allTextViewhandTap
{
    orderFormListMenuViewController.view.hidden=YES;

        
        [self.queryLabelDown setImage:[UIImage imageNamed:@"down.png"]];
        
  
    self.nearMonthTextView.textColor=uncheckColor;
    self.yearTextView.textColor=uncheckColor;
    self.allTextView.textColor=checkColor;
    
    startDate=@"";
    
 
    [self request0040:NO];
    
}



//title
- (void)titleTextViewClicked:(UIButton*)btn {
    

    
    if(dropDown==nil )
    {
        dropDown = [[DropDownForOrderForm alloc] initWithNibName:@"DropDownViewController" bundle:nil];
    [dropDown setParentView:btn name:@"" delegate:self];
    
    SqlApp *sqlApp=[[SqlApp alloc ]init ];
        NSArray *arr=[sqlApp selectPM_ARRAYSERVICE:@"BUSINESS" ];
    
    
    dropDown.tableArray = arr;
    
    [self.view addSubview:dropDown.view];
   
    }else
    {
    
      if(!dropDown.view.hidden)
      {
          dropDown.view.hidden=YES;
     
      }else
      {
          dropDown.view.hidden=NO;
       
      }
    }
  
}


-(void) dropDownCallBack:(NSString*)code name:(NSString*)name selectWhich:(int)selectWhich
{

    orderFormTypeNo=code;
    
    [self request0040:NO];
}





-(void)edEditTextEditingChanged:(UITextField *)textField{
    UITextRange * selectedRange = [textField markedTextRange];
    if(selectedRange == nil || selectedRange.empty){
        orderFormNum=@"";
    }else
    {
        orderFormNum=textField.text;
    }

}


OrderFormListMenuViewController *orderFormListMenuViewController;

//menu tap
-(void)queryImageViewhandTap{
    //[self presentViewController:updatePwdViewController animated:NO completion:^{}];
    
    
    if (orderFormListMenuViewController==nil) {
         orderFormListMenuViewController=[[OrderFormListMenuViewController alloc] initWithNibName:@"OrderFormListMenuViewController" bundle:nil];
      
        [orderFormListMenuViewController.view setFrame:CGRectMake(0, self.headView.frame.origin.y+ self.headView.frame.size.height, self.headView.frame.size.width, self.view.frame.size.height-self.headView.frame.size.height)];
        [self.view addSubview:orderFormListMenuViewController.view];
          [orderFormListMenuViewController.view setHidden:NO];
        
        
        [orderFormListMenuViewController setUiValue:menulistData type:@"" delegate:self];
        
        
      
        
        

        
    }else if(orderFormListMenuViewController.view.hidden==YES)
        
    {
        [orderFormListMenuViewController.view setHidden:NO];
        //[self.queryLabelDown setImage:[UIImage imageNamed:@"up.png"]];
        
           [orderFormListMenuViewController.view setFrame:CGRectMake(0, self.headView.frame.origin.y+ self.headView.frame.size.height, self.headView.frame.size.width, self.view.frame.size.height-self.headView.frame.size.height)];
        
        
    }else if(orderFormListMenuViewController.view.hidden==NO)
    {
     [orderFormListMenuViewController.view setHidden:YES];
        //[self.queryLabelDown setImage:[UIImage imageNamed:@"down.png"]];
        
           [orderFormListMenuViewController.view setFrame:CGRectMake(0, self.head2.frame.origin.y+ self.head2.frame.size.height, self.headView.frame.size.width, self.view.frame.size.height-self.headView.frame.size.height)];
      
    }
    
    

    
    
//    if(self.menuView.hidden==true)
//    {
//      self.menuView.hidden=false;
//    }else
//    {
//        self.menuView.hidden=true;
//    }
//    
//        dropDown.view.hidden=YES;
    

}

//菜单返回
-(void) chirldViewRespond:(NSString*) type  data:(NSMutableArray*)data
{//type==orderNo
    
    if (orderFormListMenuViewController!=nil ) {
 
       [orderFormListMenuViewController.view setHidden:YES];
    }
    
    queryOrderNo=type;
  
    
    for(DropDownRowForOrderForm *droprow in data)
    {
      if(droprow.check)
      {
          queryOrderStatus=droprow.rowId;
      }
    
    }
    
    [self request0040:NO];
   

}




-(void) viewWillAppear:(BOOL)animated{
    //table
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
    
    ProductOrderForm *orderForm=[ProductOrderForm sharedInstance ];
   
    if (orderForm.deleteOrderForm==true) {
        [self request0040:NO];
        orderForm.deleteOrderForm=false;
    }
}



//指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;//返回标题数组中元素的个数来确定分区的个数
}

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
//    if ([oderFormListlistData count]==0) {
//        return 0;
//    }else
//    {
         return  [oderFormListlistData count]+1;
   // }
  
    
}


//绘制Cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([indexPath row] == ([oderFormListlistData count])  && [oderFormListlistData count]>0) {
        //创建loadMoreCell
        
        
        if( currentCount<totalCount)
        {
            [self request0040:YES];
        //if (oderFormListlistData!=nil && [oderFormListlistData count]>0) {
            MoreTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"MoreTableViewCell" owner:self options:nil] lastObject];
            return cell;
        }else
        {
        return [[UITableViewCell alloc] init ];
        }
       // }
        
    }
    
    else  if([indexPath row] == ([oderFormListlistData count]) && [oderFormListlistData count]==0)
    {
        return [[UITableViewCell alloc] init ];
    }
    else
    {

    
    OrderFormListTableViewCell *cell = (OrderFormListTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:OrderFormListCellIdentifier];
   // if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderFormListTableViewCell" owner:self options:nil] lastObject];
    }
    
   
    

        
        
        
        

        
        int height=0;
        int width=cell.frame.size.width;
        int x=0;
        int y=0;
        
        
        //Top
        OrderFormListTopCell *topLinearLayout = [[[NSBundle mainBundle] loadNibNamed:@"OrderFormListTopCell"  owner:self options:nil] lastObject];
        
        [topLinearLayout setFrame:CGRectMake(x, y+height, width, topLinearLayout.frame.size.height)];
        height+=topLinearLayout.frame.size.height;
        [cell addSubview:topLinearLayout];
        
        [views addObject:topLinearLayout];

     
        //订单号
        objc_setAssociatedObject(topLinearLayout.payButton, "orderNum", ((RespondParam0040*)[oderFormListlistData objectAtIndex:indexPath.row]).orderNo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//控件与数据绑定
        [topLinearLayout.payButton addTarget:self action:@selector(payButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        //订单状态
        NSString *status=  ((RespondParam0040*) [oderFormListlistData objectAtIndex:indexPath.row]).dealStatus;
        SqlApp  *sql=[[SqlApp alloc] init];
        NSString *cnstatus= [sql selectPM_ARRAYSERVICEByCode:@"ORDERSTATUS" code:status];
        
        //待付款
        [topLinearLayout.payStateTextView setText:cnstatus];
        
      
        
        if ([status isEqualToString:@"02"]) {//待付款
            [topLinearLayout.payButton setHidden:YES];
        }else
        {
            [topLinearLayout.payButton setHidden:YES];
        }
        
        //订单金额
        float money= ((RespondParam0040*)[oderFormListlistData objectAtIndex:indexPath.row]).orderAmt;
        
        [topLinearLayout.moneyValueTextView setText:[NSString stringWithFormat:@"¥%.2f",money]];
        
        
        topLinearLayout.orderFormButton.tag=  indexPath.row;
        
        
        [ topLinearLayout.orderFormButton addTarget:self action:@selector(productItemLinearLayoutHandTap:) forControlEvents:UIControlEventTouchUpInside];

        
      RespondParam0040 *orderForm=  ((RespondParam0040*)[oderFormListlistData objectAtIndex:indexPath.row]);

        //Prouct
        for (RespondParam0040 *product in orderForm.products) {
            
            
            OrderFormListProductCell *productItemLinearLayout = [[[NSBundle mainBundle] loadNibNamed:@"OrderFormListProductCell"  owner:self options:nil] lastObject];
            
           
                [productItemLinearLayout.productPicImageView setImageWithURL: [NSURL URLWithString:product.merchPicID] placeholderImage:[UIImage imageNamed:@"productpic.png"]];
            
            //数量
            [productItemLinearLayout.productNumTextView setText:[NSString stringWithFormat:@"%@%@",@"x", product.merchNumber ]];
            
            //规格
            [productItemLinearLayout.productStypeTextView setText:product.normsName];
            //价格
            [productItemLinearLayout.productPriceTextView setText:[NSString stringWithFormat:@"%@%.2f",@"￥", product.normsPrice ]];
            
            //产品名字
            [productItemLinearLayout.productNameTextView setText:product.merchName];
            
            //start换行高度
            [productItemLinearLayout.productNameTextView setNumberOfLines:0];
            productItemLinearLayout.productNameTextView.lineBreakMode = NSLineBreakByWordWrapping;
            CGSize   sizeproductNameTextView = [ productItemLinearLayout.productNameTextView  sizeThatFits:CGSizeMake(productItemLinearLayout.productNameTextView.frame.size.width, MAXFLOAT)];
            
            //名字
            [productItemLinearLayout.productNameTextView setFrame:CGRectMake(productItemLinearLayout.productNameTextView.frame.origin.x
                                                                             , productItemLinearLayout.productNameTextView.frame.origin.y, productItemLinearLayout.productNameTextView.frame.size.width, sizeproductNameTextView.height)];
            //end换行高度
            
            //规格
           [ productItemLinearLayout.productStypeTextView setFrame:CGRectMake(
                                                                              productItemLinearLayout.productNameTextView.frame.origin.x,
                                                                              productItemLinearLayout.productNameTextView.frame.origin.y+productItemLinearLayout.productNameTextView.frame.size.height+10,
                                                                              productItemLinearLayout.productStypeTextView.frame.size.width,
                                                                              productItemLinearLayout.productStypeTextView.frame.size.height)];
            
            //数量
            [ productItemLinearLayout.productNumTextView setFrame:CGRectMake(
                                                                               productItemLinearLayout.productNumTextView.frame.origin.x,
                                                                               productItemLinearLayout.productNameTextView.frame.origin.y+productItemLinearLayout.productNameTextView.frame.size.height+10,
                                                                               productItemLinearLayout.productNumTextView.frame.size.width,
                                                                               productItemLinearLayout.productNumTextView.frame.size.height)];
            
            //产品
            [productItemLinearLayout setFrame:CGRectMake(x, y+height, width, productItemLinearLayout.productNameTextView.frame.size.height+productItemLinearLayout.productStypeTextView.frame.size.height+40)];
            
            
            productItemLinearLayout.productBtn.tag=  indexPath.row;
         
            
             [productItemLinearLayout.productBtn addTarget:self action:@selector(productItemLinearLayoutHandTap:) forControlEvents:UIControlEventTouchUpInside];
            
            
            height+=productItemLinearLayout.frame.size.height;
            [cell addSubview:productItemLinearLayout];
            
            [views addObject:productItemLinearLayout];
            
        }
    
        
        
        OrderFormListBottomCell *partBottomLinearLayout = [[[NSBundle mainBundle] loadNibNamed:@"OrderFormListBottomCell"  owner:self options:nil] lastObject];

        [partBottomLinearLayout setFrame:CGRectMake(x, y+height, width, partBottomLinearLayout.frame.size.height)];
        height+=partBottomLinearLayout.frame.size.height;
        [cell addSubview:partBottomLinearLayout];
        
        [views addObject:partBottomLinearLayout];

        //时间
        [partBottomLinearLayout.orderFormTimeTextView setText:[DateConvert convertDateFromStringShort:orderForm.bookDate]];

        //广东邮政公司
        [partBottomLinearLayout.shopNameTextView setText:orderForm.sellerName];
        
     
        
      
        
        
        
        
    
    return cell;
    }
    
}


-(void)productItemLinearLayoutHandTap:(UIButton*)btn
{

    int row=btn.tag;
    

        
        OrderFormDetailViewController *orderFormDetailViewController=[[OrderFormDetailViewController alloc ] initWithNibName:@"OrderFormDetailViewController" bundle:nil];
        
        //ProductOrderForm *orderForm=[ProductOrderForm sharedInstance ];
        orderFormDetailViewController.orderNo=((RespondParam0040*)[oderFormListlistData objectAtIndex:row]).orderNo;
        
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:orderFormDetailViewController animated:YES];
        
   
    

    
}


-(void)payButtonClicked:(UIButton *)btn{
    id orderNum = objc_getAssociatedObject(btn, "orderNum");
    //取绑定数据int mId2 = btn.tag;
    //取绑定数据
    [self makePay:orderNum];
}


//关键方法，获取复用的Cell后模拟赋值，然后取得Cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSString *reuseIdentifier = OrderFormListCellIdentifier;
//    OrderFormListTableViewCell *cell= [self.cacheCells objectForKey:reuseIdentifier];
//    if (!cell) {
//        cell=[self.tableView dequeueReusableCellWithIdentifier:OrderFormListCellIdentifier];
//        [self.cacheCells setObject:cell forKey:reuseIdentifier];
//    }
    
    
    OrderFormListTableViewCell *cell ;
    // if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderFormListTableViewCell" owner:self options:nil] lastObject];
    }
    
    if([indexPath row] == ([oderFormListlistData count])  && [oderFormListlistData count]>0) {
        //创建loadMoreCell
        
        
        if( currentCount<totalCount)
        {
            return 0;
        }else
        {
            return 0;
        }
        
        
    }else  if([indexPath row] == ([oderFormListlistData count])  && [oderFormListlistData count]==0) {
        return 0;
    }
  
    
    
    
    
    
  
    
    int height=0;
    int width=cell.frame.size.width;
    int x=0;
    int y=0;
    
    
    //Top
    OrderFormListTopCell *topLinearLayout = [[[NSBundle mainBundle] loadNibNamed:@"OrderFormListTopCell"  owner:self options:nil] lastObject];
    
    [topLinearLayout setFrame:CGRectMake(x, y+height, width, topLinearLayout.frame.size.height)];
    height+=topLinearLayout.frame.size.height;
   
    
    
    //订单号
    objc_setAssociatedObject(topLinearLayout.payButton, "orderNum", ((RespondParam0040*)[oderFormListlistData objectAtIndex:indexPath.row]).orderNo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//控件与数据绑定
    [topLinearLayout.payButton addTarget:self action:@selector(payButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //订单状态
    NSString *status=  ((RespondParam0040*) [oderFormListlistData objectAtIndex:indexPath.row]).dealStatus;
    SqlApp  *sql=[[SqlApp alloc] init];
    NSString *cnstatus= [sql selectPM_ARRAYSERVICEByCode:@"ORDERSTATUS" code:status];
    
    //待付款
    [topLinearLayout.payStateTextView setText:cnstatus];
    
    //订单金额
    float money= ((RespondParam0040*)[oderFormListlistData objectAtIndex:indexPath.row]).orderAmt;
    
    [topLinearLayout.moneyValueTextView setText:[NSString stringWithFormat:@"¥%.2f",money]];
    
    
    RespondParam0040 *orderForm=  ((RespondParam0040*)[oderFormListlistData objectAtIndex:indexPath.row]);
    
    //Prouct
    for (RespondParam0040 *product in orderForm.products) {
        
        
        OrderFormListProductCell *productItemLinearLayout = [[[NSBundle mainBundle] loadNibNamed:@"OrderFormListProductCell"  owner:self options:nil] lastObject];
        
        
    
        
        
        //数量
        [productItemLinearLayout.productNumTextView setText:[NSString stringWithFormat:@"%@%@",@"x", product.merchNumber ]];
        
        //规格
        [productItemLinearLayout.productStypeTextView setText:product.normsName];
        //价格
        [productItemLinearLayout.productPriceTextView setText:[NSString stringWithFormat:@"%@%.2f",@"￥", product.normsPrice ]];
        
        //产品名字
        [productItemLinearLayout.productNameTextView setText:product.merchName];
        
        //start换行高度
        [productItemLinearLayout.productNameTextView setNumberOfLines:0];
        productItemLinearLayout.productNameTextView.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize   sizeproductNameTextView = [ productItemLinearLayout.productNameTextView  sizeThatFits:CGSizeMake(productItemLinearLayout.productNameTextView.frame.size.width, MAXFLOAT)];
        
        //名字
        [productItemLinearLayout.productNameTextView setFrame:CGRectMake(productItemLinearLayout.productNameTextView.frame.origin.x
                                                                         , productItemLinearLayout.productNameTextView.frame.origin.y, productItemLinearLayout.productNameTextView.frame.size.width, sizeproductNameTextView.height)];
        //end换行高度
        
        //规格
        [ productItemLinearLayout.productStypeTextView setFrame:CGRectMake(
                                                                           productItemLinearLayout.productNameTextView.frame.origin.x,
                                                                           productItemLinearLayout.productNameTextView.frame.origin.y+productItemLinearLayout.productNameTextView.frame.size.height+10,
                                                                           productItemLinearLayout.productStypeTextView.frame.size.width,
                                                                           productItemLinearLayout.productStypeTextView.frame.size.height)];
        
        //数量
        [ productItemLinearLayout.productNumTextView setFrame:CGRectMake(
                                                                         productItemLinearLayout.productNumTextView.frame.origin.x,
                                                                         productItemLinearLayout.productNameTextView.frame.origin.y+productItemLinearLayout.productNameTextView.frame.size.height+10,
                                                                         productItemLinearLayout.productNumTextView.frame.size.width,
                                                                         productItemLinearLayout.productNumTextView.frame.size.height)];
        
        //产品
        [productItemLinearLayout setFrame:CGRectMake(x, y+height, width, productItemLinearLayout.productNameTextView.frame.size.height+productItemLinearLayout.productStypeTextView.frame.size.height+40)];
        
        
        height+=productItemLinearLayout.frame.size.height;
        
        
    }
    
    
    
    OrderFormListBottomCell *partBottomLinearLayout = [[[NSBundle mainBundle] loadNibNamed:@"OrderFormListBottomCell"  owner:self options:nil] lastObject];
    
    [partBottomLinearLayout setFrame:CGRectMake(x, y+height, width, partBottomLinearLayout.frame.size.height)];
    height+=partBottomLinearLayout.frame.size.height;
   
    
    
    //时间
    [partBottomLinearLayout.orderFormTimeTextView setText:[DateConvert convertDateFromStringShort: ((RespondParam0040*)[oderFormListlistData objectAtIndex:indexPath.row]).bookDate]];
    
    //广东邮政公司
    [partBottomLinearLayout.shopNameTextView setText:orderForm.sellerName];
    
    

    
    return height+1;
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88;
}

//点击后，过段时间cell自动取消选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.05f];
    
    
    if (indexPath.row == [oderFormListlistData count]) {
  
    
        [self request0040:YES];
        return;
        
    }else
    {
    
    OrderFormDetailViewController *orderFormDetailViewController=[[OrderFormDetailViewController alloc ] initWithNibName:@"OrderFormDetailViewController" bundle:nil];
    
        //ProductOrderForm *orderForm=[ProductOrderForm sharedInstance ];
        orderFormDetailViewController.orderNo=((RespondParam0040*)[oderFormListlistData objectAtIndex:indexPath.row]).orderNo;
        
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:orderFormDetailViewController animated:YES];
        
//    [self presentViewController:orderFormDetailViewController animated:YES completion:^{
//        
//    }];
    }
}
- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

-(void)viewWillLayoutSubviews
{
    
    int h=self.head2.frame.origin.y+self.head2.frame.size.height;
    [self.tableView setFrame:CGRectMake(0, h , self.view.frame.size.width, self.view.frame.size.height-h)];

}


/*订单查询0040*/
NSString  *n0040=@"JY0040";
/*订单查询0040*/
bool moreRequest=false;
bool request0040more=false;

-(void) request0040:(BOOL)ismore{
    
      moreRequest=ismore;
    
    if(ismore)
    {
        if (request0040more==false) {
            request0040more=true;
        }else
        {
            return;
        }
      
        
    }else
    {
        request0040more=false;
        
        oderFormListlistData=[[NSMutableArray alloc] init];
        
       
        
        totalCount=0;
        currentCount=0;
        page=1;
        
        if(allindexpaths2!=nil && [allindexpaths2 count]>0)
        {
        [self.tableView deleteRowsAtIndexPaths:allindexpaths2 withRowAnimation:UITableViewRowAnimationFade];
        }
        
        allindexpaths2=[[NSMutableArray alloc] init];
        
    }
    
    //self.waitPayBtn.selected=FALSE;
    NSString *queryTypeFlag=@"";
    
    
    
  
    NSDateFormatter *f=[[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy-MM-dd"];
    NSString *endDate=@"";
    if ([startDate isEqualToString:@""]) {
        endDate=@"";
    }else
    {
       endDate=[f stringFromDate:[NSDate date]];
    }
    



    CstmMsg *cstmMsg=[CstmMsg sharedInstance];
    
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 会员编号 备注:必填*/
    [businessparam setValue:cstmMsg.cstmNo forKey:@"cstmNo"];
  
    /* 业务代号 备注:必填*/
    [businessparam setValue:orderFormTypeNo forKey:@"busiNo"];
    
    if (queryOrderNo==nil || [queryOrderNo isEqualToString:@""]) {
        
        /* 订单号 备注:必填*/
        [businessparam setValue:@"" forKey:@"orderNo"];
        
        /* 订单状态 备注:必填   01 等待摇号结果
         02 等待买家付款
         03 等待卖家同意
         04 卖家拒绝
         05 等待买家发货
         06 等待卖家确认货物
         07 等待卖家发货
         08 等待物流商发货
         09 等待买家确认收货
         10 退回等待重新上传图片
         11 待审核状态
         12 初审通过
         13 次审通过
         14 终审通过
         15 完成
         16 关闭
         */
        NSMutableArray *status=[[NSMutableArray alloc] init];
        if ([queryOrderStatus isEqualToString:@"00"] ) {
          
            [businessparam setValue:status forKey:@"orderStatus"];
            
            /* 订单状态数量 备注:必填 数量等于0忽略本条件 */
            [businessparam setValue:[NSString stringWithFormat:@"%d", 0]forKey:@"orderStatusNum"];
        }else
        {
            
           
            [status addObject:queryOrderStatus];
            [businessparam setValue:status forKey:@"orderStatus"];
            
            /* 订单状态数量 备注:必填 数量等于0忽略本条件 */
            [businessparam setValue:[NSString stringWithFormat:@"%d", [status count]]forKey:@"orderStatusNum"];
        
        }
      
     

        
    }else
    {
    /* 订单号 备注:必填*/
    [businessparam setValue:queryOrderNo forKey:@"orderNo"];

    /* 订单状态 备注:必填   01 等待摇号结果
     02 等待买家付款
     03 等待卖家同意
     04 卖家拒绝
     05 等待买家发货
     06 等待卖家确认货物
     07 等待卖家发货
     08 等待物流商发货
     09 等待买家确认收货
     10 退回等待重新上传图片
     11 待审核状态
     12 初审通过
     13 次审通过
     14 终审通过
     15 完成
     16 关闭
 */
    NSMutableArray *status=[[NSMutableArray alloc] init];
   
    [businessparam setValue:status forKey:@"orderStatus"];
    
    /* 订单状态数量 备注:必填 数量等于0忽略本条件 */
    [businessparam setValue:@"0" forKey:@"orderStatusNum"];
    }
    
    
    /* 开始日期 备注:必填*/
    [businessparam setValue:startDate forKey:@"startDate"];
    /* 结束日期 备注:必填*/
    [businessparam setValue:endDate forKey:@"endDate"];
    /* 渠道代号 备注:选填*/
    [businessparam setValue:@"" forKey:@"channelNo"];
    /* 支付方式 备注:选填*/
    [businessparam setValue:@"" forKey:@"payType"];
    /* 排序方式 备注:选填*/
    [businessparam setValue:@"" forKey:@"sortType"];
    /* 排序字段代号 备注:选填*/
    [businessparam setValue:@"" forKey:@"sortFieldID"];
    
    
    /* 查询订单类型标志 备注:选填  针对新邮预订订单取消
     默认为空
     1-换货（可以换货的和换货中的订单）
     2-退货
 */
    [businessparam setValue:queryTypeFlag forKey:@"queryTypeFlag"];
    
   /* 0-	查询退补款订单
    1-	查询退款订单
    2-	查询补款订单*/
        [businessparam setValue:@"" forKey:@"fundFlag"];
    
    /* 当前页码 备注:必填*/
//    int currentPage=0;
//    if(ismore)
//    {
//        currentPage=page+1;
//    
//    }else
//    {
//       
//        page=1;
//         currentPage=page;
//    }
    [businessparam setValue:[NSString stringWithFormat:@"%d",page ] forKey:@"pageCode"];
    /* 页码大小 备注:必填*/
    [businessparam setValue:@"10" forKey:@"pageNum"];
  
    
  
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:cstmMsg formName:n0040 business:businessparam delegate:self viewController:self];
    
    
    queryOrderNo=@"";
}

-(void) ReturnError:(MsgReturn*)msgReturn
{ if ([msgReturn.formName isEqualToString:n0040]){
    request0040more=false;
}
}


-(void) ReturnData:(MsgReturn*)msgReturn
{
    
    
    
    /*订单查询0040*/
    if ([msgReturn.formName isEqualToString:n0040]){
        request0040more=false;
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        
        
        /* 最大记录数 备注:*/
        int  totalNum=[[returnDataBody objectForKey:@"totalNum"] intValue];
        /* 返回的记录数 备注:循环域开始*/
        int recordNum=[[returnDataBody objectForKey:@"recordNum"] intValue];
        
        totalCount=totalNum;
       currentCount+=recordNum;
        
        if (recordNum>0) {
            if (currentCount<totalCount) {
                page++;
                moreRequest=NO;
            }
        }else if(recordNum==0)
        {
            [self.view makeToast:@"暂无数据"];
      
        }
        
        
        
        NSMutableArray *temprows=[[NSMutableArray alloc] init];
        
        for (int i=0; i<recordNum; i++) {
            
            RespondParam0040 *commonItem=[[RespondParam0040 alloc]init];
            
            /* 订单号 备注:*/
            commonItem.orderNo=[((NSArray*)[returnDataBody objectForKey:@"orderNo"]) objectAtIndex:i ];
            /* 业务代号 备注:*/
            commonItem.busiNo=[((NSArray*)[returnDataBody objectForKey:@"busiNo"]) objectAtIndex:i];
            /* 订单总金额 备注:*/
            commonItem.orderAmt=[[((NSArray*)[returnDataBody objectForKey:@"orderAmt"]) objectAtIndex:i] floatValue] ;
            /* 下单日期 备注:格式:yyyymmdd*/
            commonItem.bookDate=[((NSArray*)[returnDataBody objectForKey:@"bookDate"]) objectAtIndex:i];
            /* 支付状态 备注:*/
            commonItem.payStatus=[((NSArray*)[returnDataBody objectForKey:@"payStatus"]) objectAtIndex:i];
            /* 处理状态 备注:*/
            commonItem.dealStatus=[((NSArray*)[returnDataBody objectForKey:@"dealStatus"]) objectAtIndex:i];
            /* 渠道代号 备注:*/
            commonItem.channelNo=[((NSArray*)[returnDataBody objectForKey:@"channelNo"]) objectAtIndex:i];
           
            
            /* 自提码 备注:2015/11/10新增*/
            commonItem.toTheCode=[returnDataBody objectForKey:@"toTheCode"][i];
            /* 店铺名称 备注:2015/11/10新增*/
            commonItem.sellerName=[returnDataBody objectForKey:@"sellerName"][i];
             [temprows addObject:commonItem];
            [oderFormListlistData addObject:commonItem];
         
      
            
        }
        
        
        
     
  
        int merchRecordNum=[[returnDataBody objectForKey:@"merchRecordNum"] intValue];
        
  
        
        for (int i=0; i<merchRecordNum; i++) {
 
         RespondParam0040 *commonItem=[[RespondParam0040 alloc]init];
            
        /* 商品代号 备注:2015/11/10新增*/
        commonItem.merchID=[returnDataBody objectForKey:@"merchID"][i];
        /* 关联订单 备注:2015/11/10新增*/
        commonItem.linkOrderNo=[returnDataBody objectForKey:@"linkOrderNo"][i];
        /* 商品类别代号 备注:2015/11/10新增*/
        commonItem.merchType=[returnDataBody objectForKey:@"merchType"][i];
        /* 商品名称 备注:2015/11/10新增*/
        commonItem.merchName=[returnDataBody objectForKey:@"merchName"][i];
        /* 图片URL（小图） 备注:2015/11/10新增*/
        commonItem.merchPicID=[returnDataBody objectForKey:@"merchPicID"][i];
        /* 商品规格 备注:2015/11/10新增 如：单套、四方连 规格代号以接口下发为准*/
        commonItem.normsType=[returnDataBody objectForKey:@"normsType"][i];
        /* 商品规格名称 备注:2015/11/10新增*/
        commonItem.normsName=[returnDataBody objectForKey:@"normsName"][i];
         commonItem.gxhBiaozhi=  [ [returnDataBody objectForKey:@"gxhBiaozhi"][i]intValue];
            

            
            
           commonItem.merchNumber=[returnDataBody objectForKey:@"merchNumber"][i];
            
        /* 规格单价 备注:2015/11/10新增*/
        commonItem.normsPrice=[[returnDataBody objectForKey:@"normsPrice"][i] floatValue];
        
            for ( RespondParam0040 *orderForm in oderFormListlistData) {
                
                if ([orderForm.orderNo isEqualToString: commonItem.linkOrderNo]) {
                    
                    if(orderForm.products==nil)
                    {
                        orderForm.products=[[NSMutableArray alloc ] init ];
                    }
                    
                    if (commonItem.gxhBiaozhi==0) {
                        [orderForm.products addObject:commonItem];
                    }
                    
                }
            }
        
        }
        
        
        
        NSMutableArray *insertIndexPaths = [NSMutableArray arrayWithCapacity:10];
        for (int ind = 0; ind < [temprows count]; ind++) {
            NSIndexPath    *newPath =  [NSIndexPath indexPathForRow:[oderFormListlistData indexOfObject:[temprows objectAtIndex:ind]] inSection:0];
             [allindexpaths2 addObject:newPath];
            [insertIndexPaths addObject:newPath];
        }
        [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
 
        
       // [tableView reloadData];
        
    }
    
    
    
    
    
}



#pragma mark - 支付宝支付
-(void)makePay:(NSString*)orderNo
{
    
    
    
    CstmMsg *_cstmmsg = [CstmMsg sharedInstance];
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    [para setValue:_cstmmsg.cstmNo forKey:@"cstmNo"];
    
    NSString* payMode =@"01";
    [para setValue:payMode forKey:@"payMode"];
    
    NSString* paytype =@"61";
    [para setValue:paytype forKey:@"payType"];
    
    
    [para setValue:@"1" forKey:@"orderNoNum"];
    
    NSMutableArray  *orderlist=[[NSMutableArray alloc] init ];
    [orderlist addObject:orderNo];
    [para setValue:orderlist forKey:@"orderNo"];
    
    
    OrderPay0039* PayClass =[[OrderPay0039 alloc]init];
    [PayClass orderPay:para delegate:self];
    
    /*
     NSString* paySeq =@"total_fee=\"0.01\"&it_b_pay=\"30m\"&notify_url=\"http://211.156.193.101:8080/AliPayPhoneNoticeAction.do\"&payment_type=\"1\"&seller_id=\"2088501806719007\"&service=\"mobile.securitypay.pay\"&partner=\"2088501806719007\"&_input_charset=\"utf-8\"&out_trade_no=\"20150819095638106518\"&subject=\"集邮网厅商品\"&return_url=\"http://211.156.193.101:8080/AliPaySynchroAction.do\"&body=\"PREM201500060739-PREM201500060739-JYW-MOBILE\"&sign_type=\"RSA\"&sign=\"SUjN2JBPs44%2Bff6wQERjxyJgVb%2FqGhMa6KqfNsQ9Hr15h8uYqflVEt%2FIi5ExhuSvq5TfSfBOe%2BzpqComVrtpmITAHFe6C48RMLcxJgziUY4A82PDSU2Xt%2F7TS0budu2JWSG889V9hS8wwPBM5Mkgpgry5JOjTL6%2Fb2oJ02PcPpk%3D\"";
     
     
     //    NSString* paySeq = [self makePaystring];
     NSLog(@"paySeq[%@]",paySeq);
     NSString* appScheme=@"PhilatelyScheme";
     
     if (paySeq != nil) {
     [[AlipaySDK defaultService] payOrder:paySeq fromScheme:appScheme callback:^(NSDictionary *resultDic) {
     NSLog(@"reslut = %@",resultDic);
     NSString*status =[resultDic objectForKey:@"resultStatus"];
     if ([status isEqual:@"9000"]) {
     NSLog(@"支付宝支付成功");
     
     
     }
     else if ([status isEqual:@"6001"]) {
     NSLog(@"用户取消支付宝支付");
     }
     else
     {
     NSLog(@"支付宝支付失败");
     }
     }];
     }
     */
}


-(void)payResult:(NSDictionary *)resultDic
{
    NSLog(@"reslut = %@",resultDic);
    NSString*status =[resultDic objectForKey:@"resultStatus"];
    if ([status isEqual:@"9000"]) {
        NSLog(@"支付宝支付成功");
        
        NSString*strresult =[resultDic objectForKey:@"result"];
        NSLog(@"%@",strresult);
        NSArray* resultArr =[strresult componentsSeparatedByString:@"&"];
        NSMutableArray* keyArr =[[NSMutableArray alloc]init];
        NSMutableArray* valueArr =[[NSMutableArray alloc]init];
        
        for (int i =0; i<resultArr.count; i++) {
            NSArray* tmparr =[resultArr[i] componentsSeparatedByString:@"="];
            [keyArr addObject:tmparr[0]];
            [valueArr addObject:tmparr[1]];
        }
        
        NSDictionary *dicResult =[[NSDictionary alloc]initWithObjects:valueArr forKeys:keyArr];
        
        NSString* totalmoney =[[dicResult objectForKey:@"total_fee"] stringByReplacingOccurrencesOfString:@"\"" withString:@""] ;
        
        PayedSuccessViewController* paysuccessView =[[PayedSuccessViewController alloc]init];
        paysuccessView.money = totalmoney;
        [self.navigationController pushViewController:paysuccessView animated:YES];
    }
    else if ([status isEqual:@"6001"]) {
        NSLog(@"用户取消支付宝支付");
    }
    else
    {
        UIAlertView* alter =[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"支付宝支付失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        NSLog(@"支付宝支付失败");
    }
}



@end



