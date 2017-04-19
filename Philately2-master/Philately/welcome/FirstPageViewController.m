


#import "FirstPageViewController.h"
#import "UIImageView+WebCache.h"
#import <Foundation/Foundation.h>
#import "JSONKit.h"

#import "FirstPageTableViewCell.h"
#import "RespondParam0055.h"
#import "Device.h"
#import "FirstHeadTableViewCell.h"
#import <objc/runtime.h>

#import "ProductOrderForm.h"
#import "ProductlistViewController.h"
#import "ProductdetailViewController.h"
#import "ProductSearchlistViewController.h"
#import "ProductOrderForm.h"
#import "SqlApp.h"
#import "UIButton+WebCache.h"
#import "DropDownViewController.h"
#import "UIImageView+WebCache.h"

#import "SqlQueryService.h"
#import "ServiceEntity.h"

#import "AppDelegate.h"

#import "SliderViewController.h"

@implementation FirstPageViewController
//table

//注入table功能
  static NSString *FirstPageCellIdentifier = @"FirstPageTableViewCell";
  static NSString *HeadIdentifier = @"FirstPageHeadView";

@synthesize tableView;

int kDeviceWidth=0;
int kDeviceHeight=0;
NSArray * imageArr;//图片路径字符串数组

NSMutableArray *FirstPagesections;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    
    [tableView setDelegate:self];//指定委托\n";
    [tableView setDataSource:self];//指定数据委托\n";
    self.cacheCells=[[NSMutableDictionary alloc]init ];
    
    //使用自定义的Cell,需要向UITableView进行注册
    UINib *cellNib = [UINib nibWithNibName:@"FirstPageTableViewCell" bundle:nil];
    [tableView registerNib:cellNib forCellReuseIdentifier:FirstPageCellIdentifier];
  
      //self.tableView.tableFooterView=[[UIView alloc]init];//关键语句
    
    //广告start
    kDeviceWidth=[UIScreen mainScreen].bounds.size.width;
    kDeviceHeight=[UIScreen mainScreen].bounds.size.height;
    [self initImgArr];
    [self initScrollView];
    [self initPageControl];
  
    
    self.picScrollView.showsHorizontalScrollIndicator=NO;
    
    self.picPagecontrol.pageIndicatorTintColor = [UIColor blackColor];//设置点的默认颜色，非选中的点
    
    self.picPagecontrol.currentPageIndicatorTintColor = [UIColor redColor];;//设置点的选中颜色
    
     //广告End
    
    

    
    [self.searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
        [self.leftMenu addTarget:self action:@selector(leftMenuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.searchInput addTarget:self action:@selector(searchInputClick:) forControlEvents:UIControlEventEditingDidEndOnExit];
    self.searchInput.returnKeyType=UIReturnKeySearch;
    
     FirstPagesections=[[NSMutableArray alloc] init];
    
  
  
    
    UITapGestureRecognizer* closeKeyboardtap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKeyboard)];
    [self.view addGestureRecognizer:closeKeyboardtap];
    
}

-(void)closeKeyboard
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}




-(void)leftMenuBtnClick:(UIButton*)btn
{
 [[SliderViewController sharedSliderController]   showLeftViewController];
}


-(void)searchInputClick:(UITextField*)txt
{
    [self.view becomeFirstResponder];
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
    if (self.searchInput.text==nil ||[self.searchInput.text isEqualToString:@""]) {
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        msgReturn.errorCode=@"-90001";//不能为空
        msgReturn.errorType=@"02";
        msgReturn.errorDesc=@"请输入搜索内容";
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){}];
        
        
        return;
    }
    
    ProductSearchlistViewController *productSearchlistViewController=[[ProductSearchlistViewController alloc] initWithNibName:@"ProductSearchlistViewController" bundle:nil];
    ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
    productOrderForm.searchName=self.searchInput.text;
    
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:productSearchlistViewController animated:NO];
    self.hidesBottomBarWhenPushed=NO;
}

-(void)searchBtnClick:(UIButton*)btn
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil]; 
    
    if (self.searchInput.text==nil ||[self.searchInput.text isEqualToString:@""]) {
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        msgReturn.errorCode=@"-90001";//不能为空
        msgReturn.errorType=@"02";
        msgReturn.errorDesc=@"请输入搜索内容";
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){}];
       
     
        return;
    }
    
    ProductSearchlistViewController *productSearchlistViewController=[[ProductSearchlistViewController alloc] initWithNibName:@"ProductSearchlistViewController" bundle:nil];
    ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
    productOrderForm.searchName=self.searchInput.text;
    
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:productSearchlistViewController animated:NO];
     self.hidesBottomBarWhenPushed=NO;

    self.searchInput.text=@"";
  //  [self presentViewController:productSearchlistViewController animated:NO completion:^{}];
    
    
}

//-(void)handTap{
//    [self presentViewController:updatePwdViewController animated:NO completion:^{}];
//[self dismissViewControllerAnimated:NO completion:^(){}]; 
//};


-(void) viewWillAppear:(BOOL)animated{
    AppDelegate *appDelegate1 = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if(appDelegate1.isMainpage==true)
    {
        FirstPagesections=[[NSMutableArray alloc]init];
        
        [tableView reloadData];
        [self request0055];
    }
    
      timer= [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(handleSchedule) userInfo:nil repeats:YES];
    
 
}

-(void)viewDidDisappear:(BOOL)animated
{
    //关闭定时器
    
    [timer invalidate];
    timer = nil;
    //[timer setFireDate:[NSDate distantFuture]];
}



//自定义SectionHeader
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    FirstHeadTableViewCell *cell = (FirstHeadTableViewCell*)[self.tableView  dequeueReusableHeaderFooterViewWithIdentifier:HeadIdentifier];
    
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FirstHeadTableViewCell" owner:self options:nil] lastObject];
    }
    

    objc_setAssociatedObject(cell.morebtn, "sectionId", ((Section*)[FirstPagesections objectAtIndex:section]).sectionId, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [cell.morebtn addTarget:self action:@selector(moreClick:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *busiNo=((Section*)[FirstPagesections objectAtIndex:section]).sectionId;
    SqlApp *sql=[[SqlApp alloc] init];
    
    NSString *busiNoCn=[sql selectPM_ARRAYSERVICEByCode:@"BUSINESS" code:busiNo];
    
    
    // UIFont *titleFont = [UIFont fontWithName:@"System Bold" size:6.0f];
     //[cell.title setFont:titleFont];
    [cell.title setText:busiNoCn];
    
    return cell;
    
}

-(void)moreClick:(UIButton*)btn
{
    AppDelegate *appDelegate1 = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    appDelegate1.isMainpage=false;

    
    id sectionId = objc_getAssociatedObject(btn, "sectionId");
    NSLog(@"%@",sectionId);
    
    ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
    productOrderForm.productType=sectionId;
   
    ProductlistViewController *productlistViewController=[[ProductlistViewController alloc]initWithNibName:@"ProductlistViewController" bundle:nil];
  
    
    productlistViewController.busiNo=sectionId;
    //[self presentViewController:productlistViewController animated:NO completion:^{}];
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:productlistViewController animated:NO];
    self.hidesBottomBarWhenPushed=NO;
    
}



//自定义SectionHeader高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    FirstHeadTableViewCell *cell = (FirstHeadTableViewCell*)[self.tableView  dequeueReusableHeaderFooterViewWithIdentifier:HeadIdentifier];
    
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FirstHeadTableViewCell" owner:self options:nil] lastObject];
    }
    int h= cell.contentView.frame.size.height;
    return  h ;
}

//指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [FirstPagesections count];
  
}

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    Section *s=(Section*)[FirstPagesections objectAtIndex:section] ;
    NSArray *rows=s.sectionRows;
    return [rows  count];
    
}

//绘制Cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FirstPageTableViewCell *cell = (FirstPageTableViewCell*)[self.tableView  dequeueReusableCellWithIdentifier:FirstPageCellIdentifier];
                                                             
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FirstPageTableViewCell" owner:self options:nil] lastObject];
    
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    Section *s=(Section*)[FirstPagesections objectAtIndex:indexPath.section] ;
    if (s.sectionRows!=nil && [s.sectionRows count]>0) {
     
    Row *row=[s.sectionRows objectAtIndex:0];
        
        [cell.pic1view setHidden:NO];
        [cell.pic2view setHidden:NO];
        [cell.pic3view setHidden:NO];
    
    if ([row.rowChirlds count]>0)
    {
        
        NSString *state= ((Chirld*)[row.rowChirlds objectAtIndex:0]).merchSaleType;
        [self picstate:state imageView:cell.pic1state];
        
    [ cell.pic1name setText:((Chirld*)[row.rowChirlds objectAtIndex:0]).picName];
    [ cell.pic1price setText:((Chirld*)[row.rowChirlds objectAtIndex:0]).picPrice];
        
        NSString *productId=((Chirld*)[row.rowChirlds objectAtIndex:0]).productId;
    
        NSString *busiNo=((Chirld*)[row.rowChirlds objectAtIndex:0]).businNo;
        objc_setAssociatedObject(cell.pic1, "busiNo", busiNo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
      objc_setAssociatedObject(cell.pic1, "productId", productId, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [cell.pic1 addTarget:self action:@selector(picClick:) forControlEvents:UIControlEventTouchUpInside];
        
        NSString *url=((Chirld*)[row.rowChirlds objectAtIndex:0]).pic;
        if (url!=nil && ![url isKindOfClass:[NSNull class]])
        {
        [cell.pic1 setImageWithURL: [NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"productpic.png"]];
        }
    }else
    {
        [cell.pic1view setHidden:YES];
        [cell.pic2view setHidden:YES];
        [cell.pic3view setHidden:YES];


    }
    
     if ([row.rowChirlds count]>1)
         
     {
         
         NSString *state= ((Chirld*)[row.rowChirlds objectAtIndex:1]).merchSaleType;
         [self picstate:state imageView:cell.pic2state];
         
         [ cell.pic2name setText:((Chirld*)[row.rowChirlds objectAtIndex:1]).picName];
         [ cell.pic2price setText:((Chirld*)[row.rowChirlds objectAtIndex:1]).picPrice];
         
         NSString *productId=((Chirld*)[row.rowChirlds objectAtIndex:1]).productId;
         
         NSString *busiNo=((Chirld*)[row.rowChirlds objectAtIndex:1]).businNo;
         objc_setAssociatedObject(cell.pic2, "busiNo", busiNo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
         
         objc_setAssociatedObject(cell.pic2, "productId", productId, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
         [cell.pic2 addTarget:self action:@selector(picClick:) forControlEvents:UIControlEventTouchUpInside];
         
         NSString *url=((Chirld*)[row.rowChirlds objectAtIndex:1]).pic;
         if (url!=nil && ![url isKindOfClass:[NSNull class]])
         {
         [cell.pic2 setImageWithURL: [NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"productpic.png"]];
         }
     }else
     {
        
         [cell.pic2view setHidden:YES];
         [cell.pic3view setHidden:YES];
     }
    
     if ([row.rowChirlds count]>2)
         
     {
        NSString *state= ((Chirld*)[row.rowChirlds objectAtIndex:2]).merchSaleType;
         [self picstate:state imageView:cell.pic3state];
         
         [ cell.pic3name setText:((Chirld*)[row.rowChirlds objectAtIndex:2]).picName];
         [ cell.pic3price setText:((Chirld*)[row.rowChirlds objectAtIndex:2]).picPrice];
         
         NSString *productId=((Chirld*)[row.rowChirlds objectAtIndex:2]).productId;
         
          NSString *busiNo=((Chirld*)[row.rowChirlds objectAtIndex:2]).businNo;
         objc_setAssociatedObject(cell.pic3, "busiNo", busiNo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
         
         objc_setAssociatedObject(cell.pic3, "productId", productId, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
         [cell.pic3 addTarget:self action:@selector(picClick:) forControlEvents:UIControlEventTouchUpInside];
         
          NSString *url=((Chirld*)[row.rowChirlds objectAtIndex:2]).pic;
         if (url!=nil && ![url isKindOfClass:[NSNull class]])
         {
         [cell.pic3 setImageWithURL: [NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"productpic.png"]];
         }
         
     }else
     {
        
         [cell.pic3view setHidden:YES];
     }
    }

    return cell ;
}


-(void) picClick:(UIButton*) btn
{
    
    AppDelegate *appDelegate1 = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    appDelegate1.isMainpage=false;
    
id productId = objc_getAssociatedObject(btn, "productId");

 id busiNo = objc_getAssociatedObject(btn, "busiNo");
    ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
    productOrderForm.businNo=(NSString*)busiNo;
    productOrderForm.productNo=productId;
    
    ProductdetailViewController *productdetailViewController=[[ProductdetailViewController alloc ] initWithNibName:@"ProductdetailViewController" bundle:nil];
    productdetailViewController.productId=productId;
 
    productdetailViewController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:productdetailViewController animated:YES];
//    [self presentViewController:productdetailViewController animated:NO completion:^{
//        
//    }];

    NSLog(@"%@",productId);
}


//关键方法，获取复用的Cell后模拟赋值，然后取得Cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    NSString *reuseIdentifier = FirstPageCellIdentifier;
    FirstPageTableViewCell *cell= [self.cacheCells objectForKey:reuseIdentifier];
    if (!cell) {
        cell=[self.tableView dequeueReusableCellWithIdentifier:FirstPageCellIdentifier];
          [self.cacheCells setObject:cell forKey:FirstPageCellIdentifier];
    }

    int height = cell.contentView.frame.size.height;
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88;
}

////点击后，过段时间cell自动取消选中
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    //消除cell选择痕迹
//    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.05f];
//    
//}
- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}
-(void) setUiValue{

}



-(void)viewWillLayoutSubviews
{
    int viewHeight=self.view.frame.size.height;
    int searchViewHeight=self.searchView.frame.size.height;
    
    
    SqlApp *sqlApp=[[SqlApp alloc ]init ];
    float picscale=[[sqlApp selectPM_SIGNSERVICE:@"HOMEPAGE_PIC_SCALE" ] floatValue];

    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    CGFloat width = size.width;
    CGFloat height = size.height;
    
    if(picscale==0)
    {
        picscale=0.2;
    }
    
    [self.guanggaoView setFrame:CGRectMake(self.guanggaoView.frame.origin.x,
                                          self.guanggaoView.frame.origin.y,
                                          self.guanggaoView.frame.size.width,
                                          picscale*height
                                           )];
    [self.picScrollView setFrame:CGRectMake(self.picScrollView.frame.origin.x,
                                            self.picScrollView.frame.origin.y,
                                            self.picScrollView.frame.size.width,
                                            picscale*height
                                            )];
    
    [self.picPagecontrol setFrame:CGRectMake(self.picPagecontrol.frame.origin.x,
                                             self.picScrollView.frame.size.height-30,
                                             self.picPagecontrol.frame.size.width,
                                             self.picPagecontrol.frame.size.height
                                             )];

    
   int guanggaoViewHeight= self.guanggaoView.frame.size.height;
    int guanggaoViewWidth=self.guanggaoView.frame.size.width;
    int tabH=[Device sharedInstance].tabHeight;
    
    
    
    
    [tableView setFrame:CGRectMake(0, searchViewHeight+guanggaoViewHeight, guanggaoViewWidth ,viewHeight-searchViewHeight-guanggaoViewHeight-tabH)];
    
}




//广告star

// 实现手动滚动效果：
-(void)initScrollView{
    
    // scrollView=[[UIScrollViewalloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth,kDeviceHeight/3*2)];
    
    self.picScrollView.contentSize=CGSizeMake(kDeviceWidth*imageArr.count,self.picScrollView.frame.size.height);
    
    self.picScrollView.delegate=self;
    
    self.picScrollView.scrollEnabled=YES;
    dispatch_async(dispatch_get_main_queue(), ^{
     
  
    
    for(int i=0;i<imageArr.count;i++){
        
        UIImageView * firstImg=[[UIImageView alloc]init];
     
       
        [firstImg setImageWithURL: [NSURL URLWithString:imageArr[i]] placeholderImage:[UIImage imageNamed:@"home_ad.png"]];
        
        firstImg.frame=CGRectMake(kDeviceWidth*i, 0, kDeviceWidth, self.picScrollView.frame.size.height);
        
        [ self.picScrollView addSubview:firstImg];
        
    }
          });
    
}

-(void)initImgArr{
    
    
    SqlApp *sql=[[SqlApp alloc] init];
   NSMutableArray *dropDownRows= [sql selectPM_ARRAYSERVICE:@"HOMEPAGEPIC"];//
    NSMutableArray *pics=[[NSMutableArray alloc] init];
    for (DropDownRow *row in  dropDownRows) {
        [pics addObject:row.rowMsg];
    }
    
    imageArr=pics;//@[@"home_ad.png",@"home_ad.png"];
    
}

// 2 加UIPageControl，做翻页效果，即产生白点
//方法实现如下：

-(void)initPageControl{
    
    // self.pagecontrol=[[UIPageControlalloc]initWithFrame:CGRectMake(kDeviceWidth/2-10, kDeviceHeight/3*2-20, 20, 20)];
    
    self.picPagecontrol.numberOfPages=imageArr.count;
    
    self.picPagecontrol.currentPage=0;
    
    [self.picPagecontrol addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
}

//可以不要下面这个方法，此方法是手动点击白点的时候跳转相应页面视图

//点击page控件时，即白点
-(void)changePage:(id)sender{
    int page=self.picPagecontrol.currentPage;
    [self.picScrollView setContentOffset:CGPointMake(kDeviceWidth*page, 0) animated:YES];
}

//并且记得在手动滚动的时候更改pageControl的页码

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int page=scrollView.contentOffset.x/kDeviceWidth;
    
    self.picPagecontrol.currentPage=page;
    
}


bool Tend=YES;

//3 定时任务方法调用：（注意计算好最后一页循环滚动）

-(void)handleSchedule{
    
    ++self.picPagecontrol.currentPage;
    
    if(Tend){
        
        [self.picScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        
        self.picPagecontrol.currentPage=0;
        
    }else{
        
        [self.picScrollView setContentOffset:CGPointMake(self.picPagecontrol.currentPage*kDeviceWidth, 0) animated:YES];
        
    }
    
    if (self.picPagecontrol.currentPage==self.picPagecontrol.numberOfPages-1) {
        
        Tend=YES;
        
    }else{
        
        Tend=NO;
        
    }
}


//广告End


/*应用首页商品列表查询0055*/
NSString  *n0055=@"JY0055";
/*应用首页商品列表查询0055*/
-(void) request0055{
   
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 业务代号数量 备注:必填*/
    [businessparam setValue:@"3" forKey:@"recordNum"];
    /* 业务代号 备注:必填*/
    NSMutableArray *array=[[NSMutableArray alloc] init];

    
    NSMutableArray* serviceArr=[NSMutableArray array];
    SqlQueryService* service =[[SqlQueryService alloc]init];
    serviceArr = [service queryServiceWithKey:@"HOMEPASEBUSI"];
    for (ServiceEntity* ety in serviceArr) {
        [array addObject:ety.serviceName];
    }
    
    [businessparam setValue:array forKey:@"busiNo"];
    /* 业务代号数量 备注:必填*/
    //[businessparam setValue:@"" forKey:@"recordNum"];
   


SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];

StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    
[stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0055 business:businessparam delegate:self viewController:self];

}


-(void) ReturnError:(MsgReturn*)msgReturn
{
}

    
-(void) ReturnData:(MsgReturn*)msgReturn
{

    

    /*应用首页商品列表查询0055*/
    if ([msgReturn.formName isEqualToString:n0055]){
        
       
       
        
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        
      
        
        /* 总返回的商品数量 备注:循环域开始*/
        int recordNum=[[returnDataBody objectForKey:@"recordNum"] intValue];
        
        
        NSMutableArray *allData=[[NSMutableArray alloc]init];
        for (int i=0; i<recordNum; i++) {
             RespondParam0055 *commonItem=[[RespondParam0055 alloc]init];
        /* 业务代号 备注:*/
        commonItem.busiNo= [((NSArray *)[returnDataBody objectForKey:@"busiNo"]) objectAtIndex:i];
            
        /* 商品代号 备注:*/
        commonItem.merchID=[((NSArray *)[returnDataBody objectForKey:@"merchID"]) objectAtIndex:i];
        /* 商品名称 备注:*/
        commonItem.merchName=[((NSArray *)[returnDataBody objectForKey:@"merchName"]) objectAtIndex:i];
        /* 商品价格 备注:*/
        commonItem.merchPrice=[[((NSArray *)[returnDataBody objectForKey:@"merchPrice"]) objectAtIndex:i] floatValue];
        /* 图片ID 备注:*/
        commonItem.merchPicID=[((NSArray *)[returnDataBody objectForKey:@"merchPicID"]) objectAtIndex:i];
            
//            merchSaleType	商品销售属性	字符	1	2015/8/19新增
//            0：预售
//            1：销售
//            2：不在销售期
//            3：无货
            
              commonItem.merchSaleType=[((NSArray *)[returnDataBody objectForKey:@"merchSaleType"]) objectAtIndex:i];
         
            [allData addObject:commonItem];
        }
        
        
        
        //多少个section
        NSString *oldbusiNo=@"";
      
        Row *sectionRow;
         for (int i=0; i<[allData count]; i++) {
             RespondParam0055 *commonItem=[allData objectAtIndex:i];
             
            if( [oldbusiNo isEqualToString:@""])
            {
                oldbusiNo=commonItem.busiNo;
                
                Section *section=[[Section alloc ] init ];
                section.sectionId=commonItem.busiNo;
                section.sectionRows=[[NSMutableArray alloc]init];
                
                //section add
                [FirstPagesections addObject:section];
                
                sectionRow=[[Row alloc ] init];
                sectionRow.rowChirlds=[[NSMutableArray alloc]init];
                
                Chirld *rowChirld=[[Chirld alloc] init ];
                 rowChirld.businNo=commonItem.busiNo;
                rowChirld.productId=commonItem.merchID;
                rowChirld.pic=commonItem.merchPicID;
                rowChirld.picName=commonItem.merchName;
                rowChirld.merchSaleType=commonItem.merchSaleType;
                rowChirld.picPrice=[NSString stringWithFormat:@"¥%.2f",commonItem.merchPrice] ;
                
                //chirld add
                [sectionRow.rowChirlds addObject:rowChirld];
                
                //row add
                [section.sectionRows addObject:sectionRow];
                
            }else if(![oldbusiNo isEqualToString:commonItem.busiNo])
            {
                oldbusiNo=commonItem.busiNo;
                
                Section *section=nil;
                for (Section *msection in FirstPagesections) {
                    if ([msection.sectionId isEqualToString:commonItem.busiNo]) {
                        section=msection;
                    }
                }
                
                if (section==nil) {
                     section=[[Section alloc ] init ];
                    section.sectionId=commonItem.busiNo;
                    section.sectionRows=[[NSMutableArray alloc]init];
                    
                    //section add
                    [FirstPagesections addObject:section];
                    
                    sectionRow=[[Row alloc ] init];
                    sectionRow.rowChirlds=[[NSMutableArray alloc]init];
                    
                    //row add
                    [section.sectionRows addObject:sectionRow];
                    
                }else
                {
                    sectionRow=section.sectionRows[0];
                    
                
                }
               
                
                
              
            
                
                Chirld *rowChirld=[[Chirld alloc] init ];
                rowChirld.businNo=commonItem.busiNo;
                rowChirld.productId=commonItem.merchID;
                rowChirld.pic=commonItem.merchPicID;
                rowChirld.picName=commonItem.merchName;
                rowChirld.merchSaleType=commonItem.merchSaleType;
                rowChirld.picPrice=[NSString stringWithFormat:@"¥%.2f",commonItem.merchPrice] ;
                
                //chirld add
                if ([sectionRow.rowChirlds count]<3) {
                [sectionRow.rowChirlds addObject:rowChirld];
                }
                
            
                
            }else
            {
                Chirld *rowChirld=[[Chirld alloc] init ];
                 rowChirld.businNo=commonItem.busiNo;
                rowChirld.productId=commonItem.merchID;
                rowChirld.pic=commonItem.merchPicID;
                rowChirld.merchSaleType=commonItem.merchSaleType;
                rowChirld.picName=commonItem.merchName;
                rowChirld.picPrice=[NSString stringWithFormat:@"¥%.2f",commonItem.merchPrice] ;
                
                
                for (Section *section in FirstPagesections ) {
                    
                    if([section.sectionId isEqualToString: commonItem.busiNo])
                    {
                        if (section.sectionRows!=nil && [section.sectionRows count]>0) {
                            Row *row=[section.sectionRows objectAtIndex:0];
                            
                            if ([row.rowChirlds count]<3) {
                                [row.rowChirlds addObject:rowChirld];
                            }
                           
                        }
                     
                        
                    }
                    
                }
               
                
              
                
            }
         }
        
        
        //每个section多少行
//        int many=0;
//        for (int i=0; i<[allData count]; i++) {
//            RespondParam0055 *commonItem=[allData objectAtIndex:i];
//            
//            //section中有个数组array 每行都加进去
//            NSMutableArray *rows=[sections objectForKey:commonItem.busiNo];
//            [rows addObject:commonItem];
//            
//        }
        

        
        // [self performSelectorOnMainThread:@selector(refresh) withObject:nil waitUntilDone:YES];
        
      
            [tableView reloadData];
        
      
       
    }


}

-(void) picstate:(NSString*)state  imageView:(UIImageView*)img
{
    //    0：预售
    //    1：销售
    //    2：不在销售期
    //    3：无货
    if ([state isEqualToString:@"0"]) {
        
        // [img setImage:[UIImage imageNamed:@"yushou.png"]];
        
        [img setImageWithURL: [NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"yushou.png"]];
        
    }else if ([state isEqualToString:@"1"]) {
        [img setImageWithURL: [NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@""]];
        
    }else if ([state isEqualToString:@"2"]) {
        
        //[img setImage:[UIImage imageNamed:@"buzaixiaoshouqi.png"]];
        
        [img setImageWithURL: [NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"buzaixiaoshouqi.png"]];
        
    }else if ([state isEqualToString:@"3"]) {
        
        //[img setImage:[UIImage imageNamed:@"wuhuo.png"]];
        
        [img setImageWithURL: [NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"wuhuo.png"]];
    }
}

@end








