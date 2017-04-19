//注入网络请求,响应,等待提示



#import "PickUpByMyselfAddressViewController.h"
#import "UIImageView+WebCache.h"
#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import "PickUpByMyselfAddressTableViewCell.h"
#import "RespondParam0029.h"
#import "DropDownViewController.h"
#import "SqlApp.h"
#import "ConfirmOrderFormViewController.h"
#import "ProductOrderForm.h"
#import "Toast+UIView.h"
//注入table功能
 NSString *PickUpByMyselfAddressCellIdentifier = @"PickUpByMyselfAddressTableViewCell";

@implementation PickUpByMyselfAddressViewController



@synthesize orderFormIndex;
@synthesize cacheCells;
//list
@synthesize tableView;
//back
@synthesize backButton;
//选择自提点
@synthesize titleTextView;
//广东
@synthesize proviceTextView;
//down
@synthesize downImageView;
//linevertical
@synthesize lineverticalImageView;
//东莞市
@synthesize cityTextView;
//厚街
@synthesize streemTextView;
//query
@synthesize queryImageView;
//checkAgress
@synthesize checkAgressButton;
//我已阅读并同意自提协议
@synthesize agreemsgTextView;
//确定
@synthesize sureButton;

@synthesize mdelegate;

@synthesize whichForm;

@synthesize sinceProvComp;
@synthesize sinceCityComp;

NSMutableArray *pickuplistData;
NSMutableArray *mproducts;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
//table
    totalRowCount=0;
    currentRowCount=0;
    page=1;
    
    allIndexpaths=[[NSMutableArray alloc] init];
  
    [self.tableView setDelegate:self];//tableview委托
    [self.tableView setDataSource:self];//tableview数据委托
    //end table
    
      self.tableView.tableFooterView=[[UIView alloc]init];//关键语句
    
    cacheCells = [NSMutableDictionary dictionary];
    
    
    //使用自定义的Cell,需要向UITableView进行注册
    UINib *cellNib = [UINib nibWithNibName:@"PickUpByMyselfAddressTableViewCell" bundle:nil];
    [tableView registerNib:cellNib forCellReuseIdentifier:PickUpByMyselfAddressCellIdentifier];
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handTap)];
    [self.backButton addGestureRecognizer:tap];
    
    pickuplistData=[[NSMutableArray alloc]init];
    
    dropDown=nil;
    
    [self.proviceTextView addTarget:self action:@selector(provinceTextViewhandTap:) forControlEvents:UIControlEventTouchUpInside];

    
    [self.cityTextView addTarget:self action:@selector(cityTextViewhandTap:) forControlEvents:UIControlEventTouchUpInside];
    
    


    [self.streemTextView addTarget:self action:@selector(streemTextViewhandTap:) forControlEvents:UIControlEventTouchUpInside];
    
     [self.queryImageView addTarget:self action:@selector(queryImageViewhandTap:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.sureButton addTarget:self action:@selector(sureButtonhandTap:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
        [self.checkAgressButton addTarget:self action:@selector(checkAgressButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.checkAgressButton.selected=true;

[self.checkAgressButton setBackgroundImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
[self.checkAgressButton setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateSelected];

}



-(void) checkAgressButtonClick:(UIButton*)btn
{
    btn.selected=!btn.selected;
    


}


-(void) sureButtonhandTap:(UIButton*)btn
{
  
    
  
    bool check=false;
       for (RespondParam0029 *item in  pickuplistData) {
           if (item.check) {
               check=true;
           }
       }
    
    
    if (check==false) {
        
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        msgReturn.errorCode=@"-999";//不能为空
        msgReturn.errorDesc=@"请选择自提点";
        msgReturn.errorType=@"02";
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        return;

    }
    
    if(!self.checkAgressButton.selected)
    {
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        msgReturn.errorCode=@"-999";//不能为空
        msgReturn.errorDesc=@"请阅读并同意自提协议";
        msgReturn.errorType=@"02";
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        return;
    }
    
    [mdelegate pickUpAddressCallBack:whichForm addressId:pickupId address:pickupAddress name:pickupName];
    
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];

}


-(void)queryImageViewhandTap:(UIButton*)btn
{
    
    if(proviendCode==nil
       ||[proviendCode isEqualToString:@""])
    {
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        msgReturn.errorCode=@"0001";//不能为空
        [PromptError changeShowErrorMsg:msgReturn title:@"省份"  viewController:self block:^(BOOL OKCancel){}];
        return;
    }
    if(cityCode ==nil
       ||[cityCode isEqualToString:@""])
    {
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        msgReturn.errorCode=@"0001";//不能为空
        [PromptError changeShowErrorMsg:msgReturn title:@"城市"  viewController:self block:^(BOOL OKCancel){}];
        return;
    }
    streemCode=@"";
//    if(streemCode==nil
//       ||[streemCode isEqualToString:@""])
//    {
//        MsgReturn *msgReturn=[[MsgReturn alloc]init];
//        msgReturn.errorCode=@"0001";//不能为空
//        [PromptError changeShowErrorMsg:msgReturn title:@"区县"  viewController:self block:^(BOOL OKCancel){}];
//        return;
//    }


    [self request0029:NO];
}

-(void)handTap{
   // [self presentViewController:updatePwdViewController animated:NO completion:^{}];
[self dismissViewControllerAnimated:NO completion:^(){}]; 
}


-(void) viewWillAppear:(BOOL)animated{
//table
[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

-(void) viewDidLayoutSubviews
{
    
    [self.bottomView setFrame:CGRectMake(0, self.view.frame.size.height-self.bottomView.frame.size.height, self.bottomView.frame.size.width, self.bottomView.frame.size.height)];
   [self.tableView setFrame:CGRectMake(0
                                       , self.head2View.frame.origin.y+self.head2View.frame.size.height, self.head2View.frame.size.width, self.view.frame.size.height-self.head1View.frame.size.height-self.head2View.frame.size.height-self.bottomView.frame.size.height)];
    
}



//指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;//返回标题数组中元素的个数来确定分区的个数
}

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
     return  [pickuplistData count]+1;
    
}

//绘制Cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    
    if([indexPath row] == ([pickuplistData count])  && [pickuplistData count]>0) {
        if( currentRowCount<totalRowCount)
        {
            [self request0029:YES];
             return [[UITableViewCell alloc] init ];
        
        }else
        {
            return [[UITableViewCell alloc] init ];
        }
    }
    else  if([indexPath row] == ([pickuplistData count]) && [pickuplistData count]==0)
    {
        return [[UITableViewCell alloc] init ];
    }
    else
    {
    
    
 PickUpByMyselfAddressTableViewCell *cell = (PickUpByMyselfAddressTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:PickUpByMyselfAddressCellIdentifier];
    if (!cell)
    {
       cell = [[[NSBundle mainBundle] loadNibNamed:@"PickUpByMyselfAddressTableViewCell" owner:self options:nil] lastObject];
    }
    
    RespondParam0029 *row=pickuplistData[indexPath.row];
    
//广东省
    cell.addressTextView.text=row.brchAddress;
    
    //phone
cell.phoneTextView.text= row.brchTele;
    

//厚街网点
cell.networkTitleTextView.text= row.brchName;
    
//check
    if (row.check) {
        cell.checkButton.selected=true;
    }else
    {
        cell.checkButton.selected=false;
    }
[cell.checkButton setBackgroundImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
[cell.checkButton setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateSelected];
    
    
cell.checkButton.tag =  (indexPath.section)*1000+indexPath.row;
[cell.checkButton addTarget:self action:@selector(checkButtonclicked:) forControlEvents:UIControlEventTouchUpInside];

        cell.selectionStyle=UITableViewCellSelectionStyleNone;
return cell;
    }
    
}



-(void)checkButtonclicked:(UIButton *)btn{
    int tab=btn.tag;
    int row= btn.tag%1000;
    int section=btn.tag/1000;
    btn.selected = !btn.selected;
    //用于butoon做checkBox控件
    
    
    
    RespondParam0029 *item=pickuplistData[row];
    
    ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
    productOrderForm.pickupId=item.brchNo;
    productOrderForm.pickupName=item.brchName;
    productOrderForm.pickupAddress=item.brchAddress;
    productOrderForm.orderFormIndex=orderFormIndex;
    
    pickupId=item.brchNo;
    pickupAddress=item.brchAddress;
    pickupName=item.brchName;
    
    int i=0;
    for (RespondParam0029 *item in  pickuplistData) {
        if (i==row) {
            item.check=true;
        }else
        {
            item.check=false;
        }
        i++;
    }
    [tableView reloadData];
   
    [mdelegate pickUpAddressCallBack:whichForm addressId:pickupId address:pickupAddress name:pickupName];

    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
  

    

    
    
}

//关键方法，获取复用的Cell后模拟赋值，然后取得Cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

NSString *reuseIdentifier = PickUpByMyselfAddressCellIdentifier;
PickUpByMyselfAddressTableViewCell *cell= [self.cacheCells objectForKey:reuseIdentifier];
if (!cell) {
  cell=[self.tableView dequeueReusableCellWithIdentifier:PickUpByMyselfAddressCellIdentifier];
  [self.cacheCells setObject:cell forKey:reuseIdentifier];
}

    
    
    if([indexPath row] == ([pickuplistData count])  && [pickuplistData count]>0) {
        if( currentRowCount<totalRowCount)
        {//LoadMoreView
            return 0;
        }else
        {
            return 0;
        }
    }else  if([indexPath row] == ([pickuplistData count])  && [pickuplistData count]==0) {
        return 0;
    }
    else
    {
   int height=cell.contentView.frame.size.height;//非动态高度(row1跟row2同样高)变化适用 不需配合上边使用   
return height+1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88;
    
}

//点击后，过段时间cell自动取消选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.05f];
    
    
    
    RespondParam0029 *item=pickuplistData[indexPath.row];
    
    ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
    productOrderForm.pickupId=item.brchNo;
    productOrderForm.pickupName=item.brchName;
    productOrderForm.pickupAddress=item.brchAddress;
    productOrderForm.orderFormIndex=orderFormIndex;
    
    pickupId=item.brchNo;
    pickupAddress=item.brchAddress;
    pickupName=item.brchName;
    
    int i=0;
    for (RespondParam0029 *item in  pickuplistData) {
        if (i==indexPath.row) {
            item.check=true;
        }else
        {
            item.check=false;
        }
        i++;
    }
    [tableView reloadData];
    
    [mdelegate pickUpAddressCallBack:whichForm addressId:pickupId address:pickupAddress name:pickupName];
    
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
    
    
    

    
}
- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}
-(void) setUiValue{


}


-(void)setProucts:(NSMutableArray*)products btn:(UIButton*)btn delegate:(id<PickUpByMyselfAddressDelegate>) delegate whichForm:(int)whichForm
{

    mproducts=products;
    mdelegate=delegate;
    self.whichForm=whichForm;
    
    
}

// 下拉
DropDownViewController *dropDown ;

-(void)provinceTextViewhandTap:(UIButton*)btn{
  
    [self.cityTextView setTitle:@"市" forState:UIControlStateNormal];
    cityCode=nil;
    
    btn.selected=!btn.selected;
    wichBtn=btn;
   
        if(dropDown==nil )
        {
            dropDown = [[DropDownViewController alloc]initWithNibName:@"DropDownViewController" bundle:nil];
            
            [self.view addSubview:dropDown.view];
            dropDown.view.hidden=true;
            
        }
        
        [dropDown setParentView:btn name:@"pro" delegate:self];
        
        
    
     SqlApp *sqlApp=[[SqlApp alloc ]init ];
  
    NSMutableArray *arr;
    
    if (self.sinceProvComp==nil || [self.sinceProvComp  isEqualToString:@""]) {
        //        sinceProvComp 为空时查询，参照SQL：SELECT * from PM_REGION a where (a.REGIONCLASS= '2'  and a.regionid not in ('110000','120000','310000','500000'))
        //        or (a.regionid  in ('110100','120100','310100','500100'));
      arr=[sqlApp  selectPM_REGION3];
        
        [dropDown setUiValue:arr];
    }else
    {
//        
//        sinceProvComp 不为空时直接带传入条件，参照 SQL：SELECT * from PM_REGION a where  a.REGIONID in ('XXXX','XXXXX');
      arr=[sqlApp  selectPM_REGION4: self.sinceProvComp ];
        
        
         [dropDown setUiValue:arr];
    
    }
   
   
      
      if (dropDown.view.hidden) {
          if (arr==nil || [arr count]<1 ) {
              
               [self.view makeToast:@"暂无数据"];
              
          }else
          {
        dropDown.view.hidden=false;
          }
    }else
    {
        dropDown.view.hidden=true;
        
    }
}

-(void)cityTextViewhandTap:(UIButton*)btn{
    wichBtn=btn;
    btn.selected=!btn.selected;
    
   
        if(dropDown==nil )
        {
            dropDown = [[DropDownViewController alloc]initWithNibName:@"DropDownViewController" bundle:nil];
            
            [self.view addSubview:dropDown.view];
              dropDown.view.hidden=true;
        }
        
        [dropDown setParentView:btn name:@"city" delegate:self];
        
        SqlApp *sqlApp=[[SqlApp alloc ]init ];
    
     NSMutableArray *region2=[sqlApp selectPM_REGION2:proviendCode];
    
    int lev=3;
    if (region2!=nil && [region2 count]>0 ) {
      DropDownRow *row=  region2[0];
        lev=[row.rowMsg2 intValue]+1;
    }
   
    
    
    
    
    
    NSMutableArray *arr;
    if (self.sinceCityComp==nil || [self.sinceCityComp  isEqualToString:@""]) {
        
        arr=[sqlApp selectPM_REGION:proviendCode withLevel: [NSString stringWithFormat:@"%d", lev]];
        [dropDown setUiValue:arr];
        
    }else
    {
        //        sinceProvComp 不为空时直接带传入条件，参照 SQL：SELECT * from PM_REGION a where  a.REGIONID in ('XXXX','XXXXX');
        arr=[sqlApp  selectPM_REGION4: self.sinceCityComp ];
        
        
        [dropDown setUiValue:arr];
        
    }

    
    
    
     if ( dropDown.view.hidden) {
        if (arr==nil || [arr count]<1) {
            
            [self.view makeToast:@"暂无数据"];
        }else
        {
            dropDown.view.hidden=false;
        }
    }else
    {
        dropDown.view.hidden=true;
        
    }
}

UIButton *wichBtn;

-(void)streemTextViewhandTap:(UIButton*)btn{
    
    wichBtn=btn;
    
    btn.selected=!btn.selected;
    
    if (btn.selected) {
        if(dropDown==nil )
        {
            dropDown = [[DropDownViewController alloc]initWithNibName:@"DropDownViewController" bundle:nil];
        
            [self.view addSubview:dropDown.view];
        }
        
        [dropDown setParentView:btn name:@"streem" delegate:self];
        
        SqlApp *sqlApp=[[SqlApp alloc ]init ];
        NSMutableArray *arr=[sqlApp selectPM_REGION:cityCode withLevel:@"4"];
        
        [dropDown setUiValue:arr];
        
        if (arr==nil || [arr count]<0) {
            
        }else
        {
            dropDown.view.hidden=false;
        }
    }else
    {
        dropDown.view.hidden=true;
        
    }
    
}


-(void) dropDownCallBack:(NSString *)code  name:(NSString *)name selectWhich:(int)selectWhich
{
    
    if ([name isEqualToString:@"pro"]) {
        proviendCode=code;
        //wichBtn setTitle:codeCn forState:<#(UIControlState)#>
    }
    
    
    if ([name isEqualToString:@"city"]) {
        cityCode=code;
        
    }
    
    if ([name isEqualToString:@"streem"]) {
        streemCode=code;
        
    }
}




/*可选自提网点查询0029*/
NSString  *n0029=@"JY0029";
/*可选自提网点查询0029*/
-(void) request0029:(BOOL)ismore{
    if(ismore)
    {
        if (requestUnComplete==false) {
            requestUnComplete=true;
        }else
        {
            return;
        }
    }else
    {
        totalRowCount=0;
        currentRowCount=0;
        page=1;
        [pickuplistData removeAllObjects];
        if(allIndexpaths!=nil && [allIndexpaths count]>0)
        {
            [self.tableView deleteRowsAtIndexPaths:allIndexpaths withRowAnimation:UITableViewRowAnimationFade];
        }
        [ allIndexpaths  removeAllObjects];
        
    }
    



      CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
/* 会员编号 备注:必填*/
[businessparam setValue:_cstmMsg.cstmNo forKey:@"cstmNo"];
/* 省份代号 备注:必填*/
[businessparam setValue:proviendCode forKey:@"provCode"];
/* 市代号 备注:必填*/
[businessparam setValue:cityCode forKey:@"cityCode"];
/* 县代号 备注:必填*/
[businessparam setValue:streemCode forKey:@"countCode"];
/* 结算商品数量 备注:必填*/
    int count=[mproducts count];
[businessparam setValue:[NSString stringWithFormat:@"%d",count] forKey:@"recordNum"];
    
    NSMutableArray *busiNos=[[NSMutableArray alloc] init];
    NSMutableArray *merchIds=[[NSMutableArray alloc] init];
    NSMutableArray *norms=[[NSMutableArray alloc] init];
    
    for (int i=0; i<count ; i++) {
        Product *product=mproducts[i];
       
        [busiNos addObject:product.busiNo];
        [merchIds addObject:product.productId];
        [norms addObject:product.normsType];
        
    }
    
    /* 业务代号 备注:必填*/
    [businessparam setValue:busiNos forKey:@"busiNo"];
    /* 商品代号 备注:必填*/
    [businessparam setValue:merchIds forKey:@"merchID"];
    /* 商品规格 备注:必填*/
    [businessparam setValue:norms forKey:@"normsType"];


    
/* 当前页码 备注:必填*/
[businessparam setValue:[NSString stringWithFormat:@"%d",page] forKey:@"pageCode"];
/* 页码大小 备注:必填*/
[businessparam setValue:@"10" forKey:@"pageNum"];

    
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0029 business:businessparam delegate:self viewController:self];
    
}


-(void) ReturnError:(MsgReturn*)msgReturn
{
    
}

-(void) ReturnData:(MsgReturn*)msgReturn
{
    
    
    /*可选自提网点查询0029*/
    if ([msgReturn.formName isEqualToString:n0029]){
        requestUnComplete=false;//避免重复请求 一个发完下一个再发
        
    NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
    NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
    NSString *respDesc=[returnHead objectForKey:@"respDesc"];
    NSString *respCode=[returnHead objectForKey:@"respCode"];
    NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
    RespondParam0029 *commonItem1=[[RespondParam0029 alloc]init];
        
    /* 最大记录数 备注:*/
    commonItem1.totalNum=[[returnDataBody objectForKey:@"totalNum"] intValue];
    /* 本次返回的记录数 备注:循环域开始*/
    commonItem1.recordNum=[[returnDataBody objectForKey:@"recordNum"] intValue];
        
        
        NSMutableArray *thisPageRows=[[NSMutableArray alloc] init];
        for (int i=0; i<commonItem1.recordNum; i++) {
             RespondParam0029 *commonItem=[[RespondParam0029 alloc]init];
            
            /* 自提网点代号 备注:*/
            commonItem.brchNo=[returnDataBody objectForKey:@"brchNo"][i];
            /* 自提网点名称 备注:*/
            commonItem.brchName=[returnDataBody objectForKey:@"brchName"][i];
            /* 网点地址 备注:*/
            commonItem.brchAddress=[returnDataBody objectForKey:@"brchAddress"][i];
            /* 网点电话 备注:*/
            commonItem.brchTele=[returnDataBody objectForKey:@"brchTele"][i];
            
            [thisPageRows addObject:commonItem];
            [pickuplistData addObject:commonItem];
        }
        
      
        
        
        totalRowCount=commonItem1.totalNum;
        currentRowCount+=commonItem1.recordNum;
        if (commonItem1.recordNum>0) {
            if (currentRowCount< totalRowCount) {
                page++;
            }
        }else if(commonItem1.recordNum==0)
        {
            // 暂无数据
              [self.view makeToast:@"暂无数据"];
        }
        
        NSMutableArray *insertIndexPaths = [[NSMutableArray alloc]init];
        for (int ind = 0; ind < [thisPageRows count]; ind++) {
            NSIndexPath    *newPath =  [NSIndexPath indexPathForRow:[pickuplistData indexOfObject:[thisPageRows objectAtIndex:ind]] inSection:0];
            [allIndexpaths addObject:newPath];
            [insertIndexPaths addObject:newPath];
        }
        [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];

   
    /* 返回的记录数 备注:循环域结束*/
   // commonItem.recordNum=[returnDataBody objectForKey:@"recordNum"];
    }

    
}

@end







