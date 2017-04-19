//注入网络请求,响应,等待提示



#import "ProductlistViewController.h"
#import "UIImageView+WebCache.h"
#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import "ProductlistTableViewCell.h"
#import "RespondParam0024.h"
#import "RespondParam0025.h"
#import "ProductOrderForm.h"
#import "ProductdetailViewController.h"
#import "MoreTableViewCell.h"
#import <objc/runtime.h>
#import "ProductSearchlistViewController.h"
#import "ProductOrderForm.h"
#import "ProductOrderForm.h"
#import "UIButton+WebCache.h"
#import "RespondParam0027.h"
#import "Device.h"
#import "Toast+UIView.h"

//注入table功能
NSString *ProductSearchlistIdentifier = @"ProductSearchlistTableViewCell";
@implementation ProductSearchlistViewController
@synthesize cacheCells;
//list
@synthesize tableView;
//back
@synthesize backButton;
//邮票
@synthesize titleTextView;





NSMutableArray *listData;
NSMutableArray  *allindexpaths3;
int page3;
int totalCount3;
int currentCount3;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    totalCount3=0;
    currentCount3=0;
    page3=1;
    
    allindexpaths3=[[NSMutableArray alloc]init ];
    
    //table
    [tableView setDelegate:self];//指定委托
    [tableView setDataSource:self];//指定数据委托
    cacheCells = [NSMutableDictionary dictionary];
    
    //使用自定义的Cell,需要向UITableView进行注册
    UINib *cellNib = [UINib nibWithNibName:@"ProductlistTableViewCell" bundle:nil];
    [tableView registerNib:cellNib forCellReuseIdentifier:ProductSearchlistIdentifier];
    
    
    productListMenuViewController=[[ProductListMenuViewController alloc ] initWithNibName:@"ProductListMenuViewController" bundle:nil];
    [productListMenuViewController.view setFrame:CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y
                                                            , tableView.frame.size.width, tableView.frame.size.height)];
    
    [self.view addSubview:productListMenuViewController.view];
    
    productListMenuViewController.view.hidden=YES;

    
    //UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handTap)];
    // [self.modifyPwdTextView addGestureRecognizer:tap];
    
    
   
    
    rows=[[NSMutableArray alloc] init ];
    
    merchTypeListData=[[NSMutableArray alloc]init];
    

    
    [self request0023:NO ];
    
    
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //购物车为空
    
    
    guestYouLikeViewController=[[GuestYouLikeViewController alloc] initWithNibName:@"GuestYouLikeViewController" bundle:nil];
    
    
    [self ui:nil];
   
    
    [self.emptyScrollView setHidden:YES];

  
    [self.tableView setHidden:NO];
    
    self.tableView.tableFooterView=[[UIView alloc]init];//关键语句
    
    ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
    
    
    self.searchInput.text= productOrderForm.searchName;
    
    self.emptyToast.text=[NSString stringWithFormat:@"%@\"%@\"",@"抱歉,未搜索到",productOrderForm.searchName] ;
    
    [self.searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.searchInput addTarget:self action:@selector(searchInputClick:) forControlEvents:UIControlEventEditingDidEndOnExit];
    self.searchInput.returnKeyType=UIReturnKeySearch;
    
    
    UITapGestureRecognizer* closeKeyboardtap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKeyboard)];
    [self.view addGestureRecognizer:closeKeyboardtap];
    
}

-(void)closeKeyboard
{
     [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}


-(void)searchInputClick:(UITextField*)txt
{
    [self.view becomeFirstResponder];
    
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
    
    
    
    rows=[[NSMutableArray alloc] init];
   
    if(self.searchInput.text==nil  ||[self.searchInput.text isEqualToString:@""])
    {
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        msgReturn.errorCode=@"-90001";//不能为空
        msgReturn.errorType=@"02";
        msgReturn.errorDesc=@"请输入搜索内容";
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){}];
        return;
    }
    
    
    self.emptyToast.text=[NSString stringWithFormat:@"%@\"%@\"",@"抱歉,未搜索到",self.searchInput.text] ;
    
    ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
    
    
    productOrderForm.searchName=self.searchInput.text;
    
    [self request0023:NO];

}



-(void)searchBtnClick:(UIButton*)btn
{   [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
    
    
    
    rows=[[NSMutableArray alloc] init];
    [btn becomeFirstResponder];
    if(self.searchInput.text==nil  ||[self.searchInput.text isEqualToString:@""])
    {
    MsgReturn *msgReturn=[[MsgReturn alloc]init];
    msgReturn.errorCode=@"-90001";//不能为空
    msgReturn.errorType=@"02";
    msgReturn.errorDesc=@"请输入搜索内容";
    [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){}];
        return;
    }
    
    
      self.emptyToast.text=[NSString stringWithFormat:@"%@\"%@\"",@"抱歉,未搜索到",self.searchInput.text] ;
    
    ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
    
    
productOrderForm.searchName=self.searchInput.text;
    
    [self request0023:NO];
    
}



-(void)backButtonClicked:(UIButton *)btn{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    [self.navigationController popViewControllerAnimated:NO];
}



//-(void)handTap{
//    [self presentViewController:updatePwdViewController animated:NO completion:^{}];
//[self dismissViewControllerAnimated:NO completion:^(){}];
//}

-(void) viewWillAppear:(BOOL)animated{
    //table
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}






//指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;//返回标题数组中元素的个数来确定分区的个数
}

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    

        int rowcount=[rows count];
        rowcount+=1;
        return  rowcount;
  
    
}

//绘制Cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([indexPath row] == ([rows count])  && [rows count]>0) {
        //创建loadMoreCell
        
        
        if( currentCount3<totalCount3)
        {
              [self request0023:YES];
            //if (oderFormListlistData!=nil && [oderFormListlistData count]>0) {
            MoreTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"MoreTableViewCell" owner:self options:nil] lastObject];
            return cell;
        }else
        {
            return [[UITableViewCell alloc] init ];
        }
        // }
        
    }
    
    else  if([indexPath row] == ([rows count]) && [rows count]==0)
    {
        return [[UITableViewCell alloc] init ];
    }
    else
    {

    
    ProductlistTableViewCell *cell = (ProductlistTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:ProductSearchlistIdentifier];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductlistTableViewCell" owner:self options:nil] lastObject];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    //right
    Row *row=(Row*)[rows objectAtIndex:indexPath.row];
    
    if ([row.rowChirlds count]>1) {
        Chirld *rightChirld=(Chirld *)row.rowChirlds[1];
        
        [self picstate:rightChirld.merchSaleType imageView:cell.picrightstate];
        //120
        cell.productRightPriceTextView.text= [NSString stringWithFormat:@"¥%@", rightChirld.picPrice];
        //productRightName
        cell.productRightNameTextView.text= rightChirld.picName;
        //productRigthPic
        // [cell.productRightPicImageView setImageWithURL:[NSURL URLWithString:((..*)[listData objectAtIndex:indexPath.row]).productRightPicImageView placeholderImage:[UIImage imageNamed:@"default.jpg"]];
        
        NSString *url=rightChirld.pic;
        if (url!=nil && ![url isKindOfClass:[NSNull class]])
        {
            [cell.productRightPicImageView setImageWithURL: [NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"productpic.png"]];
        }
        
        
        objc_setAssociatedObject(cell.productRightPicImageView, "productId", rightChirld.productId, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
         objc_setAssociatedObject(cell.productRightPicImageView, "busiNo", rightChirld.businNo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [cell.productRightPicImageView addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
        
    
        
        cell.right.hidden=NO;
    }else
    {
        cell.right.hidden=YES;
    }
   
    
  
    
    
     
     //left
    if ([row.rowChirlds count]>0) {
        Chirld *leftChirld=row.rowChirlds[0];
        
        
            [self picstate:leftChirld.merchSaleType imageView:cell.picleftstate];
        //120
        cell.productleftPriceTextView.text=[NSString stringWithFormat:@"¥%@", leftChirld.picPrice];
        //productleftname
        cell.productleftnameTextView.text= leftChirld.picName;
        //productpicleft
        //[cell.productpicleftImageView setImageWithURL:[NSURL URLWithString:((..*)[listData objectAtIndex:indexPath.row]).productpicleftImageView placeholderImage:[UIImage imageNamed:@"default.jpg"]];
        
        NSString *url=leftChirld.pic;
        if (url!=nil && ![url isKindOfClass:[NSNull class]])
        {
            [cell.productpicleftImageView setImageWithURL: [NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"productpic.png"]];
        }
        
        
        objc_setAssociatedObject(cell.productpicleftImageView, "productId", leftChirld.productId, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
         objc_setAssociatedObject(cell.productpicleftImageView, "busiNo", leftChirld.businNo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [cell.productpicleftImageView addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];

        cell.left.hidden=NO;
}else
{
    cell.left.hidden=YES;
}
         return cell;
    }
}



-(void) rightClick:(UIButton*) btn
{
    id productId = objc_getAssociatedObject(btn, "productId");
    id busiNo = objc_getAssociatedObject(btn, "busiNo");
    ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
    
    productOrderForm.productNo=productId;
    productOrderForm.businNo=busiNo;

    
    ProductdetailViewController *productdetailViewController=[[ProductdetailViewController alloc ] initWithNibName:@"ProductdetailViewController" bundle:nil];
    productdetailViewController.productId=productId;
   
       self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:productdetailViewController animated:YES];
//    [self presentViewController:productdetailViewController animated:NO completion:^{
//    
//    }];
    NSLog(@"%@",productId);
}

-(void)  leftClick:(UIButton*) btn
{
    id productId = objc_getAssociatedObject(btn, "productId");
    id busiNo = objc_getAssociatedObject(btn, "busiNo");
    ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
    
    productOrderForm.productNo=productId;
    productOrderForm.businNo=busiNo;
    
    
    
    ProductdetailViewController *productdetailViewController=[[ProductdetailViewController alloc ] initWithNibName:@"ProductdetailViewController" bundle:nil];
    
     productdetailViewController.productId=productId;
    
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:productdetailViewController animated:YES];
    
//       [self presentViewController:productdetailViewController animated:NO completion:^{
//        
//    }];
    NSLog(@"%@",productId);
}



//关键方法，获取复用的Cell后模拟赋值，然后取得Cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier = ProductSearchlistIdentifier;
    ProductlistTableViewCell *cell= [self.cacheCells objectForKey:reuseIdentifier];
    if (!cell) {
        cell=[self.tableView dequeueReusableCellWithIdentifier:ProductSearchlistIdentifier];
        [self.cacheCells setObject:cell forKey:reuseIdentifier];
    }
    
    if([indexPath row] == ([rows count])  && [rows count]>0) {
        //创建loadMoreCell
        
        
        if( currentCount3<totalCount3)
        {
            return 0;
        }else
        {
            return 0;
        }
        
        
    }else  if([indexPath row] == ([rows count])  && [rows count]==0) {
        return 0;
    }
 
    // CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];//autolayout有效 配合上边使用
    int height=cell.contentView.frame.size.height;//非动态高度(row1跟row2同样高)变化适用 不需配合上边使用
    return height+1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88;
}

//点击后，过段时间cell自动取消选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == [rows count]) {
        
        
        [self request0023:YES];
        return;
        
    }else
    {
        
        
    }
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.05f];
}
- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}


-(void) setUiValue{
    
}


//猜你喜欢ui
-(void)ui:(NSMutableArray*)data
{

    if(data==nil || [data count]<1)
    {
        //        int guestViewstart=self.headView.frame.origin.y+self.headView.frame.size.height+1;
        //        [self.guestYouLikeView setFrame:CGRectMake(0, guestViewstart, self.guestYouLikeView.frame.size.width, self.guestYouLikeView.frame.size.height)];
        
    }else
    {
        
        //猜你喜欢View
        UIView  *realGuestView=[guestYouLikeViewController setUiValue:data type:@"" delegate:self];
        
        
        int guestViewstart=self.emptyView.frame.origin.y+self.emptyView.frame.size.height+1;
        
        
        [self.guestYouLikeView setFrame:CGRectMake(0, guestViewstart, self.guestYouLikeView.frame.size.width, realGuestView.frame.size.height+self.hotTitleTextView.frame.size.height+5)];
        
        
        
        
        [realGuestView setFrame:CGRectMake(0, self.hotTitleTextView.frame.size.height+5, self.guestYouLikeView.frame.size.width, realGuestView.frame.size.height)];
        
        [self.guestYouLikeView addSubview:realGuestView];
        
        int tabH=[Device sharedInstance].tabHeight;
        
        [self.emptyScrollView setFrame:CGRectMake(0, self.headView.frame.size.height, self.headView.frame.size.width, self.view.frame.size.height-self.headView.frame.size.height-tabH)];
        
        self.emptyScrollView.contentSize=CGSizeMake(self.emptyScrollView.frame.size.width, self.guestYouLikeView.frame.origin.y+self.guestYouLikeView.frame.size.height) ;
        
        
        
    }
    
    
}





/*猜你喜欢0027*/
NSString  *nnnn0027=@"JY0027";
/*猜你喜欢0027*/
-(void) request0027{
    
    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 商品代号 备注:选填*/
    [businessparam setValue:[NSString stringWithFormat:@"%@",@""  ] forKey:@"merchID"];
    
    [businessparam setValue:@"" forKey:@"busiNo"];
    /* 当前页码 备注:必填*/
    [businessparam setValue:@"1" forKey:@"pageCode"];
    /* 页码大小 备注:必填*/
    [businessparam setValue:@"10" forKey:@"pageNum"];
    
    
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:nnnn0027 business:businessparam delegate:self viewController:self];
}





/*商品查询0023*/
NSString  *n0023=@"JY0023";
bool moreRequest3=false;
bool request0023more=false;
/*商品查询0023*/
-(void) request0023:(BOOL)ismore{
    
    
    moreRequest3=ismore;
    
    if(ismore)
    {
        if (request0023more==false) {
            request0023more=true;
            
        }else
        {
            return;
        }
        
    }else
    {
        request0023more=false;
        totalCount3=0;
        currentCount3=0;
        page3=1;
        
        rows=[[NSMutableArray alloc] init];
        if(allindexpaths3!=nil && [allindexpaths3 count]>0)
        {
        [self.tableView deleteRowsAtIndexPaths:allindexpaths3 withRowAnimation:UITableViewRowAnimationFade];
        }
        
        allindexpaths3=[[NSMutableArray alloc] init];
        
    }
     ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
    
    if (productOrderForm.searchName==nil ||[productOrderForm.searchName isEqualToString:@""]) {
        
        return;
    }
    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];

 
    [businessparam setValue:productOrderForm.searchName forKey:@"merchName"];
    /* 当前页码 备注:必填*/
    [businessparam setValue:[NSString stringWithFormat:@"%d",page3]  forKey:@"pageCode"];
    /* 页码大小 备注:必填*/
    [businessparam setValue:@"10" forKey:@"pageNum"];
    
    
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0023 business:businessparam delegate:self viewController:self];
    
}





-(void) ReturnError:(MsgReturn*)msgReturn
{
    if ([msgReturn.formName isEqualToString:n0023]){
        request0023more=false;
    }
}

-(void) ReturnData:(MsgReturn*)msgReturn
{
    
   
    
    /*商品搜索0023*/
    if ([msgReturn.formName isEqualToString:n0023]){
        request0023more=false;
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        RespondParam0025 *commonItem=[[RespondParam0025 alloc]init];
        
        /* 最大记录数 备注:*/
        commonItem.totalNum=[[returnDataBody objectForKey:@"totalNum"] intValue];
        
        /* 本次返回的记录数 备注:循环域开始*/
        commonItem.recordNum=[[returnDataBody objectForKey:@"recordNum"] intValue];
        
        totalCount3=commonItem.totalNum;
        currentCount3+=commonItem.recordNum;
        
        if (commonItem.recordNum>0) {
            if (currentCount3<totalCount3) {
                page3++;
                moreRequest3=NO;
            }
        }else if(commonItem.recordNum==0)
        {
            [self.view makeToast:@"暂无数据"];
        }

        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.tableView.backgroundColor = [UIColor whiteColor];
            if(commonItem.recordNum<1)
            {
                
                [self request0027];
                [self.emptyScrollView setHidden:NO];
                [self.tableView setHidden:YES];
              
            }else
            {
                [self.emptyScrollView setHidden:YES];
          
                [self.tableView setHidden:NO];
              
            }
            
            
        });
        

        
        productListData=[[NSMutableArray alloc] init];
        for (int i=0; i<commonItem.recordNum; i++) {
            
            RespondParam0025 *commonItem1=[[RespondParam0025 alloc]init];
            /* 商品代号 备注:*/
            id merchid=[returnDataBody objectForKey:@"merchID"][i];
            commonItem1.merchID=[NSString stringWithFormat:@"%@",merchid];
            /* 商品名称 备注:*/
            commonItem1.merchName=[returnDataBody objectForKey:@"merchName"][i];
            /* 商品类别代号 备注:*/
            commonItem1.merchType=[returnDataBody objectForKey:@"merchType"][i];
            /* 商品价格 备注:*/
            commonItem1.merchPrice=[[returnDataBody objectForKey:@"merchPrice"][i] floatValue];
            /* 图片ID 备注:*/
            commonItem1.merchPicID=[returnDataBody objectForKey:@"merchPicID"][i];
            commonItem1.merchSaleType=[returnDataBody objectForKey:@"merchSaleType"][i];
              commonItem1.busiNo=[returnDataBody objectForKey:@"busiNo"][i];
            
            /* 本次返回的记录数 备注:循环域结束*/
            //commonItem.recordNum=[returnDataBody objectForKey:@"recordNum"];
            [productListData addObject:commonItem1];
        }
        
        

       Row *sectionRow;
        NSMutableArray *temprows=[[NSMutableArray alloc] init];
        for (int i=0; i<[productListData count]; i++) {
             RespondParam0025 *commonItem2=productListData[i];
            
            
            if (i==0 || i%2==0) {
                sectionRow=[[Row alloc ] init];
                sectionRow.rowChirlds=[[NSMutableArray alloc]init];
                [temprows addObject:sectionRow];
                [rows addObject:sectionRow];
            }
            
            Chirld *rowChirld=[[Chirld alloc] init ];
            rowChirld.productId=commonItem2.merchID;
            rowChirld.pic=commonItem2.merchPicID;
            rowChirld.merchSaleType=commonItem2.merchSaleType;
            rowChirld.picName=commonItem2.merchName;
            rowChirld.picPrice=[NSString stringWithFormat:@"%.2f",commonItem2.merchPrice] ;
            rowChirld.businNo=commonItem2.busiNo;
            
            //chirld add
            [sectionRow.rowChirlds addObject:rowChirld];

            
        }
        
       
        
        NSMutableArray *insertIndexPaths = [NSMutableArray arrayWithCapacity:10];
        for (int ind = 0; ind < [temprows count]; ind++) {
            NSIndexPath    *newPath =  [NSIndexPath indexPathForRow:[rows indexOfObject:[temprows objectAtIndex:ind]] inSection:0];
             [allindexpaths3 addObject:newPath];
            [insertIndexPaths addObject:newPath];
        }
        [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
        
       // [tableView reloadData];
    }
    
    
    
    
    /*猜你喜欢0027*/
    if ([msgReturn.formName isEqualToString:nnnn0027]){
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        
        RespondParam0027 *commonItem1=[[RespondParam0027 alloc]init];
        /* 最大记录数 备注:*/
        commonItem1.totalNum=[[returnDataBody objectForKey:@"totalNum"] intValue];
        /* 本次返回的记录数 备注:循环域开始*/
        commonItem1.recordNum=[[returnDataBody objectForKey:@"recordNum"]intValue ];
        
        if (commonItem1.recordNum>6) {
            commonItem1.recordNum=6;
        }
        
        NSMutableArray *rows=[[NSMutableArray alloc] init ];
        for (int i=0; i<commonItem1.recordNum; i++) {
            RespondParam0027 *commonItem=[[RespondParam0027 alloc]init];
            /* 商品代号 备注:*/
            commonItem.merchID=[returnDataBody objectForKey:@"merchID"][i];
            /* 商品名称 备注:*/
            commonItem.merchName=[returnDataBody objectForKey:@"merchName"][i];
            /* 商品类别代号 备注:*/
            commonItem.merchType=[returnDataBody objectForKey:@"merchType"][i];
            /* 商品价格 备注:*/
            commonItem.merchPrice=[([returnDataBody objectForKey:@"merchPrice"][i]) floatValue];
            commonItem.merchPicID=[returnDataBody objectForKey:@"merchPicID"][i] ;
             commonItem.merchSaleType=[returnDataBody objectForKey:@"merchSaleType"][i] ;
            /* 图片ID 备注:*/
            commonItem.busiNo=[returnDataBody objectForKey:@"busiNo"][i];
            /* 本次返回的记录数 备注:循环域结束*/
            [rows addObject:commonItem];
        }
        
        
        Row *sectionRow;
        NSMutableArray *listdata=[[NSMutableArray alloc] init ];
        for (int i=0; i<[rows count]; i++) {
            RespondParam0027 *commonItem2=rows[i];
            
            
            if (i==0 || i%3==0) {
                sectionRow=[[Row alloc ] init];
                sectionRow.rowChirlds=[[NSMutableArray alloc]init];
                [listdata addObject:sectionRow];
                
                
            }
            
            Chirld *rowChirld=[[Chirld alloc] init ];
            rowChirld.businNo=commonItem2.busiNo;
            rowChirld.productId=commonItem2.merchID;
            rowChirld.pic=commonItem2.merchPicID;
            rowChirld.picName=commonItem2.merchName;
            rowChirld.merchSaleType=commonItem2.merchSaleType;
            rowChirld.picPrice=[NSString stringWithFormat:@"%.2f",commonItem2.merchPrice] ;
            
            //chirld add
            [sectionRow.rowChirlds addObject:rowChirld];
            
            
        }
        
        [self ui:listdata];
        
        
        
    }
    
    

    
}


-(void)viewWillLayoutSubviews
{
    [self.tableView setFrame:CGRectMake(0, self.headView.frame.size.height, self.headView.frame.size.width, self.view.frame.size.height-self.headView.frame.size.height)];
}
-(void) chirldViewRespond:(NSString*)type  data:(NSMutableArray*)data
{
    if ([type isEqualToString:@"price"]) {
        upToLows=data;
    }else if ([type isEqualToString:@"categate"])
    {
    
        merchTypeListData=data;
    }
   

    //[self request0025];
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








