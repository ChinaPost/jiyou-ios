//注入网络请求,响应,等待提示



#import "ProductlistViewController.h"
#import "UIImageView+WebCache.h"
#import <Foundation/Foundation.h>
#import <PublicFramework/JSONKit.h>
#import "ProductlistTableViewCell.h"
#import "RespondParam0024.h"
#import "RespondParam0025.h"
#import "ProductOrderForm.h"
#import "ProductListMenuViewController.h"
#import <objc/runtime.h>
#import "ProductdetailViewController.h"
#import "ProductOrderForm.h"
#import "LoginViewController.h"
#import "ShoppingCarViewController.h"
#import "UIButton+WebCache.h"
#import "SqlApp.h"
#import "MoreTableViewCell.h"
#import "Toast+UIView.h"
//注入table功能
NSString *ProductlistIdentifier = @"ProductlistTableViewCell";
@implementation ProductlistViewController
@synthesize cacheCells;
//list
@synthesize tableView;
//back
@synthesize backButton;
//邮票
@synthesize titleTextView;
//car
@synthesize carImageView;
//9
@synthesize carnumTextView;
//默认
@synthesize defaultTextView;
//价格
@synthesize priceTextView;
//down
@synthesize downImageView;
//分类
@synthesize classTextView;


@synthesize  busiNo;

int page2;
int totalCount4;
int currentCount4;


NSMutableArray *allindexpaths;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    totalCount4=0;
    currentCount4=0;
    page2=1;
    
    
      allindexpaths=[[NSMutableArray alloc] init];
    
    //table
    [tableView setDelegate:self];//指定委托
    
    [tableView setDataSource:self];//指定数据委托
      self.tableView.tableFooterView=[[UIView alloc]init];//关键语句
    cacheCells = [NSMutableDictionary dictionary];
    
    ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
   
    
    SqlApp *sql=[[SqlApp alloc ] init ];
    NSString *cnBusin=[sql selectPM_ARRAYSERVICEByCode:@"BUSINESS" code: productOrderForm.productType];
    
    self.titleTextView.text=cnBusin;
    

    //使用自定义的Cell,需要向UITableView进行注册
    UINib *cellNib = [UINib nibWithNibName:@"ProductlistTableViewCell" bundle:nil];
    [tableView registerNib:cellNib forCellReuseIdentifier:ProductlistIdentifier];
    
    
    productListMenuViewController=[[ProductListMenuViewController alloc ] initWithNibName:@"ProductListMenuViewController" bundle:nil];
    [productListMenuViewController.view setFrame:CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y-8
                                                            , tableView.frame.size.width, tableView.frame.size.height)];
    
    [self.view addSubview:productListMenuViewController.view];
    
    productListMenuViewController.view.hidden=YES;


    
    
    
    rows=[[NSMutableArray alloc] init ];
    
    merchTypeListData=[[NSMutableArray alloc]init];
    
  
    
    
    UITapGestureRecognizer *carImageViewtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(carImageViewhandtap)];
    [self.carImageView addGestureRecognizer:carImageViewtap];
    
    //默认
   
    UITapGestureRecognizer *defaultTextViewtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(defaultTextViewhandTap)];
     [self.defaultTextView addGestureRecognizer:defaultTextViewtap];
    
    
    
    upToLows=[[NSMutableArray alloc] init ];
    
    //价格
  
    UITapGestureRecognizer *priceTextViewtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(priceTextViewhandTap)];
     [priceTextView addGestureRecognizer:priceTextViewtap];
 
    //分类
  
    UITapGestureRecognizer *classTextViewtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(classTextViewhandTap)];
     [classTextView addGestureRecognizer:classTextViewtap];
    
   [self request0024 ];
    
    
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)viewWillLayoutSubviews
{
    
    int bottony=self.headView.frame.origin.y+self.headView.frame.size.height;
    
    [self.bottonView setFrame:CGRectMake(0, bottony, self.bottonView.frame.size.width, self.bottonView.frame.size.height)];
    
    int y=self
    .bottonView.frame.origin.y+self.bottonView.frame.size.height;
    [self.tableView setFrame:CGRectMake(0, y, self.tableView.frame.size.width, self.view.frame.size.height-y )];
}

-(void)carImageViewhandtap
{
    
    if (![self isLogin]) {
        return;
    }
    
    
    //if ( [carnumTextView.text intValue]>0) {
        
        ShoppingCarViewController *shoppingCarViewController=[[ShoppingCarViewController alloc ] initWithNibName:@"ShoppingCarViewController" bundle:nil];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:shoppingCarViewController animated:YES];


    
    
    
}

-(BOOL)isLogin
{
    CstmMsg *cstmsg=[CstmMsg sharedInstance];
    if (cstmsg.cstmNo==nil) {
        
        LoginViewController *login=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        
        
        [self presentViewController:login animated:NO completion:^{
            
            
        }];
        
        return false;
    }
    return true;
}


-(void)backButtonClicked:(UIButton *)btn{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)defaultTextViewhandTap
{
   
    for (RespondParam0024 *updown in upToLows) {
        updown.priceLowToUpBool=false;
            }
    for (RespondParam0024 *updown in merchTypeListData) {
        updown.priceLowToUpBool=false;
    }



    [self request0025:NO];
}

-(void)priceTextViewhandTap
{
    if (upToLows==nil ||[upToLows count]==0) {
        
                RespondParam0024 *commonItem1=[[RespondParam0024 alloc]init];
                commonItem1.priceLowToUp=@"价格从低到高";
        commonItem1.merchType=@"01";
        
                RespondParam0024 *commonItem2=[[RespondParam0024 alloc]init];
                commonItem2.priceLowToUp=@"价格从高到低";
         commonItem2.merchType=@"02";
                [upToLows addObject:commonItem1];
                [upToLows addObject:commonItem2];
    
        
   
        
    }
    
     [productListMenuViewController setUiValue:upToLows type:@"price"  delegate:self];

   
    if (productListMenuViewController.view.hidden) {
        productListMenuViewController.view.hidden=NO;
         [self.priceDownPic setImage:[UIImage imageNamed:@"up.png"]];
        [self.categateDownPic setImage:[UIImage imageNamed:@"down.png"]];
    }else
    {
    productListMenuViewController.view.hidden=YES;
        [self.priceDownPic setImage:[UIImage imageNamed:@"down.png"]];
        [self.categateDownPic setImage:[UIImage imageNamed:@"down.png"]];
        
    }
    
  
}

-(void)classTextViewhandTap
{
        
        [productListMenuViewController setUiValue:merchTypeListData type:@"categate"  delegate:self];
    
    if (productListMenuViewController.view.hidden) {
        productListMenuViewController.view.hidden=NO;
        [self.categateDownPic setImage:[UIImage imageNamed:@"up.png"]];
        [self.priceDownPic setImage:[UIImage imageNamed:@"down.png"]];
    }else
    {
        productListMenuViewController.view.hidden=YES;
        [self.categateDownPic setImage:[UIImage imageNamed:@"down.png"]];
        [self.priceDownPic setImage:[UIImage imageNamed:@"down.png"]];
        
    }

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
    
    int row=indexPath.row;
    
    if([indexPath row] == ([rows count])  && [rows count]>0) {
        //创建loadMoreCell
        
        
        if( currentCount4<totalCount4)
        {
              [self request0025:YES];
         
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

    
    
    ProductlistTableViewCell *cell = (ProductlistTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:ProductlistIdentifier];
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
//         [cell.productpicleftImageView setBackgroundImage:<#(UIImage *)#> forState:<#(UIControlState)#>]
//          
//          setImageWithURL:[NSURL URLWithString:((..*)[listData objectAtIndex:indexPath.row]).productRightPicImageView placeholderImage:[UIImage imageNamed:@"default.jpg"]];
        
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
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:productdetailViewController animated:YES];

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
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:productdetailViewController animated:YES];

//    [self presentViewController:productdetailViewController animated:NO completion:^{
//        
//    }];
    NSLog(@"%@",productId);
}



//关键方法，获取复用的Cell后模拟赋值，然后取得Cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier = ProductlistIdentifier;
    ProductlistTableViewCell *cell= [self.cacheCells objectForKey:reuseIdentifier];
    if (!cell) {
        cell=[self.tableView dequeueReusableCellWithIdentifier:ProductlistIdentifier];
        [self.cacheCells setObject:cell forKey:reuseIdentifier];
    }
    
    if([indexPath row] == ([rows count])  && [rows count]>0) {
        //创建loadMoreCell
        
        
        if( currentCount4<totalCount4)
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
    //消除cell选择痕迹
    
    if (indexPath.row == [rows count]) {
        
        
        [self request0025:YES];
        return;
        
    }else
    {
    
    
    }
    
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.05f];
}
- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}


-(void) setUiValue{
    
   
}





/*商品分类查询0024*/
NSString  *n0024=@"JY0024";
/*商品分类查询0024*/
-(void) request0024{
    
     ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 业务代号 备注:必填*/
    [businessparam setValue:productOrderForm.productType forKey:@"busiNo"];
    /* 父类别代号 备注:选填*/
    [businessparam setValue:@"" forKey:@"parentNo"];
    /* 当前页码 备注:必填*/
    [businessparam setValue:@"1" forKey:@"pageCode"];
    /* 页码大小 备注:必填*/
    [businessparam setValue:@"100" forKey:@"pageNum"];
    
    
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
      _sysBaseInfo.isOpenLoading=true;
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0024 business:businessparam delegate:self viewController:self];
    
}




/*商品列表查询0025*/
NSString  *n0025=@"JY0025";
BOOL moreRequest2=YES;
bool request0025more=false;
/*商品列表查询0025*/
-(void) request0025:(BOOL)ismore{
    
   
    moreRequest2=ismore;
    
    if(ismore)
    {
        if (request0025more==false) {
            request0025more=true;
        }else
        {
            return;
        }
        
        
    }else
    {
        request0025more=false;
        
        totalCount4=0;
        currentCount4=0;
        page2=1;
     
        
        rows=[[NSMutableArray alloc] init];
        
        if(allindexpaths!=nil && [allindexpaths count]>0)
        {
         [self.tableView deleteRowsAtIndexPaths:allindexpaths withRowAnimation:UITableViewRowAnimationFade];
        }
      
          allindexpaths=[[NSMutableArray alloc] init];
    }

    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 业务代号 备注:必填*/
    [businessparam setValue:busiNo forKey:@"busiNo"];
    
    NSString *merchType=@"";
    for (RespondParam0024 *updown in merchTypeListData) {
        if(updown.priceLowToUpBool )
        {//价格低到高
          
            if ([updown.merchType isEqualToString:@"1000000"]) {
                merchType=@"";
            }else
            {
                merchType=updown.merchType;
            }
        }
        
    }
    /* 商品分类代号 备注:选填*/
    [businessparam setValue:merchType forKey:@"merchType"];
    /* 上架机构代号 备注:选填*/
    [businessparam setValue:@"" forKey:@"brchNo"];
    /* 排序方式 备注:选填 01：正序:
     02：反序 */
    
    NSString *sortType=@"";
    NSString *sortFieldID=@"";
    for (RespondParam0024 *updown in upToLows) {
        if(updown.priceLowToUpBool )
        {//价格低到高
        sortType=updown.merchType;
            sortFieldID=@"01";
        }
        
    }
    
    [businessparam setValue:sortType forKey:@"sortType"];
    /* 排序字段 备注:选填  01：价格
     02：销量
*/
    [businessparam setValue:sortFieldID forKey:@"sortFieldID"];
    /* 当前页码 备注:必填*/
    [businessparam setValue:[NSString stringWithFormat:@"%d",page2]  forKey:@"pageCode"];
    /* 页码大小 备注:必填*/
    [businessparam setValue:@"10" forKey:@"pageNum"];
    
    
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
      _sysBaseInfo.isOpenLoading=false;
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0025 business:businessparam delegate:self viewController:self];
    
}


-(void) ReturnError:(MsgReturn*)msgReturn
{
    if ([msgReturn.formName isEqualToString:n0025]){
        request0025more=false;
    }
}

-(void) ReturnData:(MsgReturn*)msgReturn
{
    
    /*商品分类查询0024*/
    if ([msgReturn.formName isEqualToString:n0024]){
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        RespondParam0024 *commonItem=[[RespondParam0024 alloc]init];
        /* 最大记录数 备注:*/
        commonItem.totalNum=[[returnDataBody objectForKey:@"totalNum"] intValue];
        /* 本次返回的记录数 备注:循环域开始*/
        commonItem.recordNum=[[returnDataBody objectForKey:@"recordNum"] intValue];
        
        for (int i=0; i<commonItem.recordNum; i++) {
            RespondParam0024 *commonItem1=[[RespondParam0024 alloc]init];
            
            /* 商品类别代号 备注:*/
            commonItem1.merchType=[returnDataBody objectForKey:@"merchType"][i];
            /* 商品类别名称 备注:*/
            commonItem1.merchTypeName=[returnDataBody objectForKey:@"merchTypeName"][i];
            
            commonItem1.priceLowToUp=commonItem1.merchTypeName;
            /* 本次返回的记录数 备注:循环域结束*/
            // commonItem.recordNum=[returnDataBody objectForKey:@"recordNum"];
            
            [merchTypeListData addObject:commonItem1];
        }
        
        RespondParam0024 *all=[[RespondParam0024 alloc]init];
        /* 商品类别代号 备注:*/
        all.merchType=@"1000000";
        /* 商品类别名称 备注:*/
        all.merchTypeName=@"全部";
        all.priceLowToUp=all.merchTypeName;
        [merchTypeListData addObject:all];
        
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self request0025:NO];
        });
        
    }
    
    
    
    /*商品列表查询0025*/
    if ([msgReturn.formName isEqualToString:n0025]){
        request0025more=false;
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
        
        totalCount4=commonItem.totalNum;
        currentCount4+=commonItem.recordNum;
        
        if (commonItem.recordNum>0) {
            if (currentCount4< totalCount4) {
                page2++;
                moreRequest2=NO;
            }
        }else if(commonItem.recordNum==0)
        {
           [self.view makeToast:@"暂无数据"];
        }
        
        
      NSMutableArray *  productListData=[[NSMutableArray alloc]init];
        for (int i=0; i<commonItem.recordNum; i++) {
            
            RespondParam0025 *commonItem1=[[RespondParam0025 alloc]init];
            /* 商品代号 备注:*/
            commonItem1.merchID=[returnDataBody objectForKey:@"merchID"][i];
            /* 商品名称 备注:*/
            commonItem1.merchName=[returnDataBody objectForKey:@"merchName"][i];
            /* 商品类别代号 备注:*/
            commonItem1.merchType=[returnDataBody objectForKey:@"merchType"][i];
            /* 商品价格 备注:*/
            commonItem1.merchPrice=[[returnDataBody objectForKey:@"merchPrice"][i] floatValue];
            /* 图片ID 备注:*/
            commonItem1.merchPicID=[returnDataBody objectForKey:@"merchPicID"][i];
            
//            merchSaleType	商品销售属性	字符	1	2015/8/19新增
//            0：预售
//            1：销售
//            2：不在销售期
//            3：无货
             commonItem1.merchSaleType=[returnDataBody objectForKey:@"merchSaleType"][i];
            
            commonItem1.busiNo=busiNo;
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
            rowChirld.businNo=commonItem2.busiNo;
            rowChirld.productId=commonItem2.merchID;
            rowChirld.pic=commonItem2.merchPicID;
            rowChirld.merchSaleType=commonItem2.merchSaleType;
            rowChirld.picName=commonItem2.merchName;
            rowChirld.picPrice=[NSString stringWithFormat:@"%.2f",commonItem2.merchPrice] ;
            
            //chirld add
            [sectionRow.rowChirlds addObject:rowChirld];

            
        }
        
      

        
        NSMutableArray *insertIndexPaths = [NSMutableArray arrayWithCapacity:10];
        for (int ind = 0; ind < [temprows count]; ind++) {
            NSIndexPath    *newPath =  [NSIndexPath indexPathForRow:[rows indexOfObject:[temprows objectAtIndex:ind]] inSection:0];
            [allindexpaths addObject:newPath];
            [insertIndexPaths addObject:newPath];
        }
        [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
     
   
    }
    
    
    
}


-(void) chirldViewRespond:(NSString*)type  data:(NSMutableArray*)data
{
    if ([type isEqualToString:@"price"]) {
        upToLows=data;
     
    }else if ([type isEqualToString:@"categate"])
    {
        merchTypeListData=data;
    }
   
    //[productListData removeAllObjects];
   // [rows removeAllObjects];

    [self request0025:NO];
    
    [self.priceDownPic setImage:[UIImage imageNamed:@"down.png"]];
    [self.categateDownPic setImage:[UIImage imageNamed:@"down.png"]];
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








