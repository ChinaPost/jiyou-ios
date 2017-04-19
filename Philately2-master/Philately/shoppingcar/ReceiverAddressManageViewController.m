//注入网络请求,响应,等待提示



#import "ReceiverAddressManageViewController.h"
#import "UIImageView+WebCache.h"
#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import "ReceiverAddressManageTableViewCell.h"
#import "RespondParam0011.h"
#import "ConfirmOrderFormViewController.h"
#import "ProductOrderForm.h"
#import "SqlApp.h"
#import "NewAddressViewController.h"
#import "Toast+UIView.h"
#import "Device.h"

//注入table功能
NSString *ReceiverAddressManageIdentifier = @"ReceiverAddressManageTableViewCell";
@implementation ReceiverAddressManageViewController
@synthesize cacheCells;
//list
@synthesize tableView;
//back
@synthesize backButton;
//收货地址
@synthesize titleTextView;
//添加
@synthesize addButton;

@synthesize headView;
@synthesize whereCome;

NSMutableArray *listData;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //table
    [tableView setDelegate:self];//指定委托
    [tableView setDataSource:self];//指定数据委托
      self.tableView.tableFooterView=[[UIView alloc]init];//关键语句
    cacheCells = [NSMutableDictionary dictionary];
    
    //使用自定义的Cell,需要向UITableView进行注册
    UINib *cellNib = [UINib nibWithNibName:@"ReceiverAddressManageTableViewCell" bundle:nil];
    [tableView registerNib:cellNib forCellReuseIdentifier:ReceiverAddressManageIdentifier];
    
    listData=[[NSMutableArray alloc]init];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handTap)];
    [self.backButton addGestureRecognizer:tap];
    
    [addButton addTarget:self  action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
     self.title=@"ReceiverAddressManageViewController";
    ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
    [productOrderForm.viewControlls addObject:self];
   
    
    [tableView setHidden:YES];
    [self.emptyView setHidden:YES];
    
    [self request0011 ];
    
}


-(void) addButtonClick:(UIButton*)btn
{
    
     addnewflag=true;
    NewAddressViewController* newaddr = [[NewAddressViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newaddr animated:YES];
}

-(void)handTap{
    //[self presentViewController:updatePwdViewController animated:NO completion:^{}];
    [self dismissViewControllerAnimated:NO completion:^(){}];
    [self.navigationController popViewControllerAnimated:NO];
}
-(void) viewWillAppear:(BOOL)animated{
    //table
    //[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (addnewflag==true) {
             [self request0011 ];
            addnewflag=false;
        }
        
    });
    
}


-(void) viewDidLayoutSubviews
{
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
    

    [self.bottomView setFrame:CGRectMake(0, self.view.frame.size.height-self.bottomView.frame.size.height, self.bottomView.frame.size.width, self.bottomView.frame.size.height)];
    
        [tableView setFrame:CGRectMake(tableView.frame.origin.x, self.headView.frame.size.height                                       , tableView.frame.size.width, self.view.frame.size.height-headView.frame.size.height-self.bottomView.frame.size.height)];
    
           [self.emptyView setFrame:CGRectMake(self.emptyView.frame.origin.x, self.headView.frame.size.height                                       , self.emptyView.frame.size.width, self.view.frame.size.height-headView.frame.size.height-self.bottomView.frame.size.height)];
    
    
    
}



//指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;//返回标题数组中元素的个数来确定分区的个数
}

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  [listData count];;
    
}

//绘制Cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ReceiverAddressManageTableViewCell *cell = (ReceiverAddressManageTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:ReceiverAddressManageIdentifier];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ReceiverAddressManageTableViewCell" owner:self options:nil] lastObject];
    }
    
    RespondParam0011 *respondParam0011=listData[indexPath.row];
    
    //right
    //[cell.rightImageView setImageWithURL:[NSURL URLWithString:((..*)[listData objectAtIndex:indexPath.row]).rightImageView placeholderImage:[UIImage imageNamed:@"default.jpg"]];
    
    SqlApp *sql=[[SqlApp alloc ] init];
   NSString *proCn= [sql selectPM_REGION:respondParam0011.provCode];
     NSString *cityCn= [sql selectPM_REGION:respondParam0011.cityCode];
     NSString *stringCn= [sql selectPM_REGION:respondParam0011.countCode];
   // cell.provine.text=[NSString stringWithFormat:@"%@%@%@",proCn,cityCn,stringCn];
    
    //524000
    cell.postcodeTextView.text=respondParam0011.postCode;
    //广东省东莞
    cell.addressTextView.text= [NSString stringWithFormat:@"%@%@%@%@",proCn,cityCn,stringCn,respondParam0011.detailAddress];
    //13923
    cell.phoneTextView.text= respondParam0011.mobileNo;
    //大大白
    cell.receiverValueTextView.text= respondParam0011.recvName;
    //收货人:
    
    //删除
    
    cell.deleteButton.tag =  (indexPath.section)*1000+indexPath.row;
    
    [cell.deleteButton addTarget:self action:@selector(deleteButtonclicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //默认地址
    if ([respondParam0011.isDefaultAddress isEqualToString:@"0"]) {
        
        [cell.isDefaultView setText:@"默认地址"];
  
        [ cell.checkButton   setBackgroundImage:[UIImage imageNamed:@"shoppingcar_check.png"] forState:UIControlStateNormal];
       
          [ cell.checkButton   setBackgroundImage:[UIImage imageNamed:@"shoppingcar_check.png"] forState:UIControlStateSelected];
        
        [cell.isDefaultView setHidden:NO];
        [cell.checkButton setHidden:NO];
         
    }else
    {
        [cell.isDefaultView setText:@"选择该地址"];
         [ cell.checkButton   setBackgroundImage:[UIImage imageNamed:@"shoppingcar_uncheck.png"] forState:UIControlStateNormal];
          [ cell.checkButton   setBackgroundImage:[UIImage imageNamed:@"shoppingcar_uncheck.png"] forState:UIControlStateSelected];
        [cell.isDefaultView setHidden:NO];
          [cell.checkButton setHidden:NO];
    }
  
    //cell.defaultAddressTitleTextView.text= ((..*)[listData objectAtIndex:indexPath.row]).defaultAddressTitleTextView;
    
    
    //check
//    [cell.checkButton setBackgroundImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
//    [cell.checkButton setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateSelected];
//    cell.checkButton.tag =  (indexPath.section)*1000+indexPath.row;
//    [cell.checkButton addTarget:self action:@selector(checkButtonclicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    
    //位置
    
    [cell.addressTextView setNumberOfLines:0];
    cell.addressTextView.lineBreakMode = NSLineBreakByWordWrapping;
    
    
    CGSize size = [ cell.addressTextView sizeThatFits:CGSizeMake(cell.addressTextView .frame.size.width, MAXFLOAT)];
    
    
    [cell.addressTextView setFrame:CGRectMake(cell.addressTextView.frame.origin.x
                                              , cell.addressTextView.frame.origin.y
                                              , cell.addressTextView.frame.size.width
                                              ,size.height)];
    
    [cell.postcodeTextView setFrame:CGRectMake(cell.postcodeTextView.frame.origin.x
                                               , cell.addressTextView.frame.origin.y+cell.addressTextView.frame.size.height+5
                                               , cell.postcodeTextView.frame.size.width
                                               ,cell.postcodeTextView.frame.size.height)];
    
    return cell;
    
}

-(void)checkButtonclicked:(UIButton *)btn{
    int tab=btn.tag;
    int row= btn.tag%1000;
    int section=btn.tag/1000;
    btn.selected = !btn.selected;
    
    RespondParam0011 *respondParam0011=listData[row];
    
    ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
    [productOrderForm.shoppingCar setObject:respondParam0011.addressID forKey:@"addressID"];
    
     [productOrderForm.shoppingCar setObject:respondParam0011.cityCode forKey:@"cityCode"];
    
     [productOrderForm.shoppingCar setObject:respondParam0011.countCode forKey:@"streemCode"];
     [productOrderForm.shoppingCar setObject:respondParam0011.provCode forKey:@"proCode"];
    
   
  
     [productOrderForm.shoppingCar setObject:respondParam0011.postCode forKey:@"postCode"];
    
    
     [productOrderForm.shoppingCar setObject:respondParam0011.recvName forKey:@"receiverName"];
    
     [productOrderForm.shoppingCar setObject:respondParam0011.mobileNo forKey:@"receiverPhone"];
    
       [productOrderForm.shoppingCar setObject:respondParam0011.detailAddress forKey:@"receiverAddress"];
    

    
   if( [whereCome isEqualToString:@"ShoppingCarViewController"])
   {
    
    ConfirmOrderFormViewController *confirmOrderFormViewController=[[ConfirmOrderFormViewController alloc ] initWithNibName:@"ConfirmOrderFormViewController" bundle:nil];
    
//    [self presentViewController:confirmOrderFormViewController animated:NO completion:^{
//    
//    }];
     self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:confirmOrderFormViewController animated:NO];
   }else if ([whereCome isEqualToString:@"ConfirmOrderFormViewController"])
   {
           productOrderForm.selectAddresss=true;
    
    [self.navigationController popViewControllerAnimated:NO];
   }
    //用于butoon做checkBox控件
}



-(void)deleteButtonclicked:(UIButton *)btn{
    int tab=btn.tag;
    int row= btn.tag%1000;
    int section=btn.tag/1000;
    
    RespondParam0011 *respondParam0011=listData[row];
    
    [self request0013:respondParam0011.addressID];
    
    
    
    
    //btn.selected = !btn.selected;
    //用于butoon做checkBox控件
    
}

//关键方法，获取复用的Cell后模拟赋值，然后取得Cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier = ReceiverAddressManageIdentifier;
    ReceiverAddressManageTableViewCell *cell= [self.cacheCells objectForKey:reuseIdentifier];
    if (!cell) {
        cell=[self.tableView dequeueReusableCellWithIdentifier:ReceiverAddressManageIdentifier];
        
        
    }
    
    
    
    RespondParam0011 *respondParam0011=listData[indexPath.row];
    
    SqlApp *sql=[[SqlApp alloc ] init];
    NSString *proCn= [sql selectPM_REGION:respondParam0011.provCode];
    NSString *cityCn= [sql selectPM_REGION:respondParam0011.cityCode];
    NSString *stringCn= [sql selectPM_REGION:respondParam0011.countCode];
 
    //广东省东莞
    cell.addressTextView.text= [NSString stringWithFormat:@"%@%@%@%@",proCn,cityCn,stringCn,respondParam0011.detailAddress];
 

    
    
    
    [cell.addressTextView setNumberOfLines:0];
    cell.addressTextView.lineBreakMode = NSLineBreakByWordWrapping;
    
 
    CGSize size = [ cell.addressTextView sizeThatFits:CGSizeMake(cell.addressTextView .frame.size.width, MAXFLOAT)];
    
    
    [cell.addressTextView setFrame:CGRectMake(cell.addressTextView.frame.origin.x
                                              , cell.addressTextView.frame.origin.y
                                              , cell.addressTextView.frame.size.width
                                              ,size.height)];
    
    [cell.postcodeTextView setFrame:CGRectMake(cell.postcodeTextView.frame.origin.x
                                               , cell.addressTextView.frame.origin.y+cell.addressTextView.frame.size.height+5
                                               , cell.postcodeTextView.frame.size.width
                                               ,cell.postcodeTextView.frame.size.height)];
    
    
    
    return cell.postcodeTextView.frame.origin.y+cell.postcodeTextView.frame.size.height+10;
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88;
}

//点击后，过段时间cell自动取消选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.05f];
    
    RespondParam0011 *respondParam0011=listData[indexPath.row];
    
    ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
    [productOrderForm.shoppingCar setObject:respondParam0011.addressID forKey:@"addressID"];
    
    [productOrderForm.shoppingCar setObject:respondParam0011.cityCode forKey:@"cityCode"];
    
    [productOrderForm.shoppingCar setObject:respondParam0011.countCode forKey:@"streemCode"];
    [productOrderForm.shoppingCar setObject:respondParam0011.provCode forKey:@"proCode"];
    
    [productOrderForm.shoppingCar setObject:respondParam0011.postCode forKey:@"postCode"];
    
    
    [productOrderForm.shoppingCar setObject:respondParam0011.recvName forKey:@"receiverName"];
    
    [productOrderForm.shoppingCar setObject:respondParam0011.mobileNo forKey:@"receiverPhone"];
    
    [productOrderForm.shoppingCar setObject:respondParam0011.detailAddress forKey:@"receiverAddress"];
    
    
    
    if( [whereCome isEqualToString:@"ShoppingCarViewController"])
    {
        
        ConfirmOrderFormViewController *confirmOrderFormViewController=[[ConfirmOrderFormViewController alloc ] initWithNibName:@"ConfirmOrderFormViewController" bundle:nil];
        
        //    [self presentViewController:confirmOrderFormViewController animated:NO completion:^{
        //
        //    }];
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:confirmOrderFormViewController animated:NO];
    }else if ([whereCome isEqualToString:@"ConfirmOrderFormViewController"])
    {
        productOrderForm.selectAddresss=true;
        
        [self.navigationController popViewControllerAnimated:NO];
    }

}


- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}
-(void) setUiValue{
    
    //收货地址
    //[titleTextView setValue:]
}





/*收货地址查询0011*/
NSString  *n0011=@"JY0011";
/*收货地址查询0011*/
-(void) request0011{
    listData=[[NSMutableArray alloc] init] ;
    
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 会员编号 备注:必填*/
    [businessparam setValue:_cstmMsg.cstmNo forKey:@"cstmNo"];
    /* 默认地址查询标志 备注:选填* 0全部  1默认  2非默认*/
     [businessparam setValue:@"0" forKey:@"isDefaultAddress"];
     /* 当前页码 备注:必填*/
    [businessparam setValue:@"1" forKey:@"pageCode"];
    /* 页码大小 备注:必填*/
    [businessparam setValue:@"100" forKey:@"pageNum"];
    
    
    
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0011 business:businessparam delegate:self viewController:self];
}




/*收货地址删除0013*/
NSString  *n0013=@"JY0013";
/*收货地址删除0013*/
-(void) request0013:(NSString*) addressId{
    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    /* 会员编号 备注:必填*/
    [businessparam setValue:_cstmMsg.cstmNo forKey:@"cstmNo"];
    /* 收货地址编号 备注:必填*/
    [businessparam setValue:addressId forKey:@"addressID"];
    
    
    
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0013 business:businessparam delegate:self viewController:self];
}



-(void) ReturnError:(MsgReturn*)msgReturn
{
    
    /*收货地址查询0011*/
    if ([msgReturn.formName isEqualToString:n0011]){
            [tableView setHidden:YES];
            [self.emptyView setHidden:NO];
    }
    
}

-(void) ReturnData:(MsgReturn*)msgReturn
{
    
    
    
    /*收货地址查询0011*/
    if ([msgReturn.formName isEqualToString:n0011]){
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        RespondParam0011 *commonItem1=[[RespondParam0011 alloc]init];
        /* 最大记录数 备注:*/
        commonItem1.totalNum=[[returnDataBody objectForKey:@"totalNum"] intValue];
        /* 本次返回的记录数 备注:循环域开始*/
        commonItem1.recordNum=[[returnDataBody objectForKey:@"recordNum"] intValue];
        
        if (commonItem1.recordNum<1) {
            [tableView setHidden:YES];
            [self.emptyView setHidden:NO];
        }else
        {
           [tableView setHidden:NO];
           [self.emptyView setHidden:YES];
        }
        
        
        for (int i=0; i<commonItem1.recordNum ; i++) {
            
            RespondParam0011 *commonItem=[[RespondParam0011 alloc]init];
            /* 收货地址编号 备注:*/
            commonItem.addressID=[returnDataBody objectForKey:@"addressID"][i];
            /* 收货人姓名 备注:*/
            commonItem.recvName=[returnDataBody objectForKey:@"recvName"][i];
            /* 省份代号 备注:*/
            commonItem.provCode=[returnDataBody objectForKey:@"provCode"][i];
            /* 市代号 备注:*/
            commonItem.cityCode=[returnDataBody objectForKey:@"cityCode"][i];
            /* 县代号 备注:*/
            commonItem.countCode=[returnDataBody objectForKey:@"countCode"][i];
            /* 详细地址 备注:*/
            commonItem.detailAddress=[returnDataBody objectForKey:@"detailAddress"][i];
            /* 收件手机号码 备注:*/
            commonItem.mobileNo=[returnDataBody objectForKey:@"mobileNo"][i];
            /* 邮编 备注:*/
            commonItem.postCode=[returnDataBody objectForKey:@"postCode"][i];
            if (commonItem.postCode==nil || [commonItem.postCode isKindOfClass:[NSNull class]]) {
                commonItem.postCode=@"";
            }
            /* 是否默认地址 备注:0：是
             其它：否*/
            commonItem.isDefaultAddress=[returnDataBody objectForKey:@"isDefaultAddress"][i];
            /* 本次返回的记录数 备注:循环域结束*/
            [listData addObject:commonItem];
            
        }
        
//        if (listData!=nil && [listData count]<1) {
//             [self.view makeToast:@"请添加地址"];
//        }
       
        
        [tableView reloadData];
    }
    
    
    
    
    //NSMutableArray *listData=[[NSMutableArray alloc]init];
    /*收货地址删除0013*/
    if ([msgReturn.formName isEqualToString:n0013]){
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnBody=[returnData objectForKey:@"returnBody"];
         [self request0011 ];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            MsgReturn *msgReturn=[[MsgReturn alloc]init];
            
            
            msgReturn.errorCode=@"-14";//不能为空
            msgReturn.errorDesc=@"地址删除成功";
            msgReturn.errorType=@"02";
            [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){
                
                
                
                
            } ];
        });
       
            
        
       
      
    }
    
    
    
}

@end






