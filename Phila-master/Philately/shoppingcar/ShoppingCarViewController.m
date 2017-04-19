//注入网络请求,响应,等待提示



#import "ShoppingCarViewController.h"
#import "UIImageView+WebCache.h"
#import <Foundation/Foundation.h>
#import <PublicFramework/JSONKit.h>
#import "ShoppingCarTableViewCell.h"
#import "RespondParam0032.h"
#import <UIKit/NSStringDrawing.h>
#import <objc/runtime.h>
#import "SectionRowChirld.h"
#import "Device.h"
#import "RespondParam0034.h"
#import "RespondParam0035.h"
#import "ReceiverAddressManageViewController.h"
#import "ProductOrderForm.h"
#import "SqlApp.h"
#import "GxhPostageViewController.h"
#import "ProductdetailViewController.h"
#import "ShipAddressEntity.h"
#import "RespondParam0011.h"
#import "ConfirmOrderFormViewController.h"

#import "RespondParam0027.h"
#import "GuestYouLikeViewController.h"
#import "ShoppingCarStypeTableViewCell.h"
#import "ShoppingCarStype2TableViewCell.h"
#import "AppDelegate.h"
#import "ShoppingcarParentItemTableViewHeadCell.h"
//注入table功能
NSString *ShoppingCarIdentifier = @"ShoppingCarTableViewCell";
@implementation ShoppingCarViewController

@synthesize whereCome;

@synthesize cacheCells;
//list
@synthesize tableView;
//back
@synthesize backImageView;
//购物车
@synthesize titleTextView;
//合计
@synthesize totalTitleTextView;
//¥22.00
@synthesize totalValueTextView;
//提交订单
@synthesize commitOrderFormButton;

NSMutableDictionary *listData;

NSMutableArray *sections;

NSString *businNo;



GuestYouLikeViewController *guestYouLikeViewController;

float touchy;
int  movelength;
int keyboardHeight=0;
- (void)viewDidLoad
{
    [super viewDidLoad];

}

-(void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBarHidden=YES;
    //table
    [tableView setDelegate:self];//指定委托
    [tableView setDataSource:self];//指定数据委托
    cacheCells = [NSMutableDictionary dictionary];
    
    //使用自定义的Cell,需要向UITableView进行注册
    UINib *cellNib = [UINib nibWithNibName:@"ShoppingCarTableViewCell" bundle:nil];
    [tableView registerNib:cellNib forCellReuseIdentifier:ShoppingCarIdentifier];
    
    
    UITapGestureRecognizer *backImageViewtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backImageViewhandTap)];
    
    [self.backImageView addGestureRecognizer:backImageViewtap];
    
    
    UITapGestureRecognizer *deleteAllImageViewtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteAllImageViewhandTap)];
    
    [self.deleteAll addGestureRecognizer:deleteAllImageViewtap];
    
    
    if ([self.whereCome isEqualToString:@"MainPage"]) {
        [self.backImageView setHidden:YES];
        [self.backimg setHidden:YES];
    }
    
    
    
    
    
    
    
    [self.commitOrderFormButton addTarget:self action:@selector(commitOrderFormButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.emptyScrollView setHidden:YES];
    [self.bottomView setHidden:YES];
    //[self.emptyView setHidden:YES];
    [self.tableView setHidden:YES];
    
    
    
    
    
    
    //购物车为空
    
    
    guestYouLikeViewController=[[GuestYouLikeViewController alloc] initWithNibName:@"GuestYouLikeViewController" bundle:nil];
    
    self.tableView.tableFooterView=[[UIView alloc]init];//关键语句
    [self ui:nil];
    //[self request0027];
    
    
    UITapGestureRecognizer *viewtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapHandle:)];
    
    [self.view addGestureRecognizer:viewtap];
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
    isUp=false;
    touchy=0;
    movelength=0;
   

    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    
    
    
    self.checkall.selected=true;
    
    if(self.checkall.selected==true)
    {
        self.checkallCover.selected=true;
    }else
    {
        self.checkallCover.selected=false;
    
    }
    [self.checkallCover  setBackgroundImage:[UIImage imageNamed:@"shoppingcar_uncheck.png"] forState:UIControlStateNormal];
    [self.checkallCover  setBackgroundImage:[UIImage imageNamed:@"shoppingcar_check.png"] forState:UIControlStateSelected];
    
   
    [self.checkall addTarget:self action:@selector(checkallBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self request0032];
    });
    
}




-(void)checkallBtn:(UIButton*)btn
{
    btn.selected = !btn.selected ;
    
    if(self.checkall.selected==true)
    {
        self.checkallCover.selected=true;
    }else
    {
        self.checkallCover.selected=false;
        
    }


    
    
    if (btn.selected) {
      
        
        
        for (Section *section in sections ) {
            for ( RespondParam0032 *row in section.sectionRows)
            {
                  row.isProductCheck=true;
                
                for (ProductType *type in row.types ) {
                    type.isCheck=true;
                }
                
            }
            
        }
    }else
    {
        
        
        for (Section *section in sections ) {
            for ( RespondParam0032 *row in section.sectionRows)
            {
                row.isProductCheck=false;
                for (ProductType *type in row.types ) {
                    type.isCheck=false;
                }
                
            }
            
        }
        
    }
    
    
    
    [self countTotalPrice];
    
    [self.tableView reloadData];
  
//    int index=0;
//      for (Section *section in sections ) {
//          
//    [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:index] withRowAnimation:nil];
//          index++;
//      }
  
   
}


-(void)viewDidDisappear:(BOOL)animated
{

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];

}




- (void)keyboardWillShow:(NSNotification *)notification {
    
    

    /*
     Reduce the size of the text view so that it's not obscured by the keyboard.
     Animate the resize so that it's in sync with the appearance of the keyboard.
     */
    
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    float keyboardTop = keyboardRect.origin.y;
    
    
    
    
  

    
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
//
//    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];

    
    
    if(keyboardHeight==0)
    {
        
         keyboardHeight=keyboardTop;
        
        if(touchy>keyboardHeight)
        {
            movelength=touchy-keyboardHeight;
            [self MoveView:(-movelength)];
        }else
        {
            movelength=0;
            [self MoveView:(-movelength)];
        }}
  
    
    [UIView commitAnimations];
    
 
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary* userInfo = [notification userInfo];
    
    
    
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the disappearance of the keyboard.
     */
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    
    
        [self MoveView:(movelength)];

    
    [UIView commitAnimations];
}


//键盘消失
-(void)viewTapHandle:(UITapGestureRecognizer *)sender

{

  [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

-(void) cutApart
{
  int count=0;
    for (Section *section in sections)
    {
        NSMutableArray *rows= section.sectionRows;
        
        for (RespondParam0032 *row in rows) {
            
            if (row.isProductCheck) {
                
             
                
                    count++;
                    
              
            }}}
    
    if (count>1) {
    
        [self request0064:sections];
    }else
    {
        [self commitShopping];
    }
        

}

-(void) commitShopping

    {
        
        float total=0;
        bool isSelect=false;
        bool isDIYCountMore1=false;
        bool isNeedVerification=false;
        bool isCanPost=false;
        
        NSMutableArray *shoppingCartIDs=[[NSMutableArray alloc] init];
        NSMutableArray *linkBusiNos=[[NSMutableArray alloc] init];
        NSMutableArray *merchIDs=[[NSMutableArray alloc] init];
        NSMutableArray *merchNames=[[NSMutableArray alloc] init];
        NSMutableArray *normsTypes=[[NSMutableArray alloc] init];
        NSMutableArray *buyPrices=[[NSMutableArray alloc] init];
        NSMutableArray *buyNums=[[NSMutableArray alloc] init];
        
        int diycount=0;
        for (Section *section in sections)
        {
            NSMutableArray *rows= section.sectionRows;
            
            for (RespondParam0032 *row in rows) {
                
                if (row.isProductCheck) {
                    
                    if([row.needVerification  isEqualToString:@"0"])
                    {//是否手机验证码
                        isNeedVerification=true;
                    }
                    
                    
                    if([row.canPost  isEqualToString:@"0"])
                    {//是否手机验证码
                        isCanPost=true;
                    }
                    
                    if([row.busiNo isEqualToString:@"71"])
                    {
                        diycount++;
                        
                        if(diycount>1)
                            isDIYCountMore1=true;
                    }
                    
                    
                    for (ProductType  *productType in row.types)
                    {
                        if (productType.isCheck) {
                            total+= productType.buyPrice*productType.checkNum;
                            isSelect=true;
                            
                            
                            
                            [shoppingCartIDs addObject:productType.shoppingCartID];
                            [merchIDs addObject:row.merchID];
                            [merchNames addObject:row.merchName];
                            [normsTypes addObject:productType.normsType];
                            
                            [buyPrices addObject:[NSString stringWithFormat:@"%.2f", productType.buyPrice]];
                            
                            [buyNums addObject:[NSString stringWithFormat:@"%d", productType.checkNum]];
                            
                        }
                        
                    }
                }
                
            }
        }
        
        
        
        
        
        
        
        
        
        
        
        
        if (isSelect) {
            
            if (isDIYCountMore1) {
                MsgReturn *msg=[[MsgReturn alloc] init];
                msg.errorCode=@"0055";
                msg.errorDesc=@"个性化定制业务暂只支持单个商品结算";
                msg.errorType=@"02";
                
                [PromptError changeShowErrorMsg:msg title:@"" viewController:self block:nil];
                
            }else
            {
                
                
                NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
                /* 会员编号 备注:必填*/
                CstmMsg *cstmMsg=[CstmMsg sharedInstance];
                [businessparam setValue:cstmMsg.cstmNo forKey:@"cstmNo"];
                /* 业务代号 备注:必填*/
                [businessparam setValue:businNo forKey:@"busiNo"];
                
                /* 渠道代号 备注:必填*/
                [businessparam setValue:@"" forKey:@"channelNo"];
                /* 默认地址编号 备注:必填*/
                [businessparam setValue:@"" forKey:@"addressID"];
                /* 区域代号 备注:必填*/
                [businessparam setValue:@"" forKey:@"cityCode"];
                
                
                if(isNeedVerification)
                {
                    [businessparam setValue:@"1" forKey:@"needVerification"];
                    
                }else
                {
                    [businessparam setValue:@"0" forKey:@"needVerification"];
                }
                
                
                if (isCanPost) {
                    [businessparam setValue:@"1" forKey:@"canPost"];
                    
                }else
                {
                    [businessparam setValue:@"0" forKey:@"canPost"];
                }
                
                
                
                
                /* 结算商品数量 备注:必填*/
                [businessparam setValue:[NSString stringWithFormat:@"%lu",(unsigned long)[shoppingCartIDs count]] forKey:@"recordNum"];
                
                /* 购物车代号 备注:必填*/
                [businessparam setValue:shoppingCartIDs forKey:@"shoppingCartID"];
                /* 关联业务代号 备注:必填*/
                [businessparam setValue:linkBusiNos forKey:@"linkBusiNo"];
                /* 商品代号 备注:必填*/
                [businessparam setValue:merchIDs forKey:@"merchID"];
                /* 商品名称 备注:必填*/
                [businessparam setValue:merchNames forKey:@"merchName"];
                /* 商品规格 备注:必填*/
                [businessparam setValue:normsTypes forKey:@"normsType"];
                /* 购买价格 备注:必填*/
                [businessparam setValue:buyPrices forKey:@"buyPrice"];
                
                [businessparam setValue:buyNums forKey:@"buyNum"];
                
                ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
                productOrderForm.shoppingCar=businessparam;
                
                [productOrderForm.viewControlls removeAllObjects];
                productOrderForm.viewControlls=[[NSMutableArray alloc]init ];
                
                
                [self request0011];
                
                
            }
            
        }else
        {
            MsgReturn *msg=[[MsgReturn alloc] init];
            msg.errorCode=@"0019";
            msg.errorDesc=@"尚未选择要结算的商品,请先选择商品.";
            msg.errorType=@"02";
            
            [PromptError changeShowErrorMsg:msg title:@"" viewController:self block:nil];
            
            
        }
        
        
    }



-(void)commitOrderFormButtonClicked:(UIButton *)btn
{
    [self cutApart];

}



-(void)backImageViewhandTap{
    [self.navigationController popViewControllerAnimated:YES];
};



-(void)viewDidLayoutSubviews
{
    
//    int height=self.view.frame.size.height-self.headView.frame.size.height-self.bottomView.frame.size.height;
    
    int headheight=self.headView.frame.size.height;
    int bottomheight=self.bottomView.frame.size.height;
    int viewH=self.view.frame.size.height;

     int tabH=0;
    if ([self.whereCome isEqualToString:@"MainPage"]) {
         tabH=[Device sharedInstance].tabHeight;
        
    }else
    {
    
    }

   
 
    
    
    [self.tableView setFrame:CGRectMake(self.headView.frame.origin.x
                                        , self.headView.frame.size.height
                                        , self.headView.frame.size.width
                                        , viewH-headheight-bottomheight-tabH)];
    
    [self.bottomView setFrame:CGRectMake(self.bottomView.frame.origin.x,
                                         headheight+self.tableView.frame.size.height, self.bottomView.frame.size.width
                                         , self.bottomView.frame.size.height)];
    
}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
////    
////  //  NSString *busiNo=((Section *)sections[section]).sectionId;
//////    SqlApp  *sql=[[SqlApp alloc] init];
//////    NSString *cn=[sql selectPM_ARRAYSERVICEByCode:@"BUSINESS" code:busiNo];
////
//////
////     NSString *sellerName=((Section *)sections[section]).sectionId;
//    return @"";
//}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    
     ShoppingcarParentItemTableViewHeadCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"ShoppingcarParentItemTableViewHeadCell" owner:self options:nil] lastObject];
    
    NSString *sellerName=((Section *)sections[section]).sectionId;
    cell.sellerNameValueTextView.text=sellerName;
    return cell;

}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
     ShoppingcarParentItemTableViewHeadCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"ShoppingcarParentItemTableViewHeadCell" owner:self options:nil] lastObject];
    
    return cell.frame.size.height;
}


//指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [sections count];//[sectionAZDicArray count];//返回标题数组中元素的个数来确定分区的个数
}

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return  [((Section *)sections[section]).sectionRows count];
    
}

//绘制Cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShoppingCarTableViewCell *cell = (ShoppingCarTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:ShoppingCarIdentifier];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ShoppingCarTableViewCell" owner:self options:nil] lastObject];
        
        
    }

 
    /* 给购物车图片添加 点击事件 begin */
    [cell setImgEventClick:indexPath];
    cell.clickimg =^(NSIndexPath* rowindexPath){
        
        [self clickimg:rowindexPath];
    };
    /* end  */
    
     RespondParam0032 *row=((Section *)sections[indexPath.section]).sectionRows[indexPath.row];
    
    
    


    
    //check start
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    
    for (UIView *view in cell.onePriceContainer.subviews) {
        [view removeFromSuperview];
    }
    
    for (UIView *view in cell.oneContainer.subviews) {
        [view removeFromSuperview];
    }
    
    
    
    int j=0;
    for (ProductType *producttype in row.types)
    {
    
        ShoppingCarStype2TableViewCell *shoppingCarStype2TableViewCell = [[[NSBundle mainBundle] loadNibNamed:@"ShoppingCarStype2TableViewCell" owner:self options:nil] lastObject];
        
        [shoppingCarStype2TableViewCell setFrame:CGRectMake(0, j*shoppingCarStype2TableViewCell.frame.size.height , cell.onePriceContainer.frame.size.width, shoppingCarStype2TableViewCell.frame.size.height)];
        
        [cell.onePriceContainer addSubview:shoppingCarStype2TableViewCell];
        [cell.onePriceContainer setFrame:CGRectMake(cell.onePriceContainer.frame.origin.x, cell.onePriceContainer.frame.origin.y, cell.onePriceContainer.frame.size.width, (j+1)*shoppingCarStype2TableViewCell.frame.size.height)];
    
        
          ProductType *productType=row.types[j];
        
        
        //36.00
                float price= productType.buyPrice;
                shoppingCarStype2TableViewCell.onePriceTextView.text= [NSString stringWithFormat:@"¥%.2f",price];
        //四方红
            shoppingCarStype2TableViewCell.oneTextView.text= productType.normsName;
        

        j++;
    }
    
    
    
    
  
    
   // [cell.productPicImageView  setFrame:CGRectMake(  cell.productPicImageView.frame.origin.x,   cell.productPicImageView.frame.origin.y,   cell.productPicImageView.frame.size.width,   cell.onePriceContainer.frame.size.width)];
    
    int y=0;
    if(cell.productPicImageView.frame.origin.y+cell.productPicImageView.frame.size.height>cell.onePriceContainer.frame.origin.y+cell.onePriceContainer.frame.size.height)
    {
        y=cell.productPicImageView.frame.origin.y+cell.productPicImageView.frame.size.height;
    }else
    {
        y= cell.onePriceContainer.frame.origin.y+cell.onePriceContainer.frame.size.height;
    }
    
 
    int i=0;
        for (ProductType *producttype in row.types)
        {
  
        
        
         ShoppingCarStypeTableViewCell *shoppingCarStypeTableViewCell = [[[NSBundle mainBundle] loadNibNamed:@"ShoppingCarStypeTableViewCell" owner:self options:nil] lastObject];
        
        [shoppingCarStypeTableViewCell setFrame:CGRectMake(0, i*shoppingCarStypeTableViewCell.frame.size.height , cell.oneContainer.frame.size.width, shoppingCarStypeTableViewCell.frame.size.height)];
            
            
            
        [cell.oneContainer addSubview:shoppingCarStypeTableViewCell];
            [cell.oneContainer setFrame:CGRectMake(cell.oneContainer.frame.origin.x, y, cell.oneContainer.frame.size.width, (i+1)*shoppingCarStypeTableViewCell.frame.size.height)];
            
        
            
            //checkOneButton
        objc_setAssociatedObject(shoppingCarStypeTableViewCell.checkOneButton, "NSIndexPath",indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
            shoppingCarStypeTableViewCell.checkOneButton.tag=i;
            
        [shoppingCarStypeTableViewCell.checkOneButton addTarget:self action:@selector(checkOneButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
         shoppingCarStypeTableViewCell.checkOneButton.selected=producttype.isCheck;
            
            if (shoppingCarStypeTableViewCell.checkOneButton.selected==true) {
                shoppingCarStypeTableViewCell.checkOneButtonCover.selected=true;
            }else
            {
                shoppingCarStypeTableViewCell.checkOneButtonCover.selected=false;
            }
               
                [shoppingCarStypeTableViewCell.checkOneButtonCover  setBackgroundImage:[UIImage imageNamed:@"shoppingcar_stype_check.png"] forState:UIControlStateSelected];
          
            
                [shoppingCarStypeTableViewCell.checkOneButtonCover setBackgroundImage:[UIImage imageNamed:@"shoppingcar_stype_uncheck.png"] forState:UIControlStateNormal];
           
      
            if ([row.merchSaleType isEqualToString:@"2"]||[row.merchSaleType isEqualToString:@"3"]) {//不在销售期 无货
                [shoppingCarStypeTableViewCell.checkOneButton setHidden:YES];
                 [shoppingCarStypeTableViewCell.checkOneButtonCover setHidden:YES];
            }else
            {
             [shoppingCarStypeTableViewCell.checkOneButton setHidden:NO];
                 [shoppingCarStypeTableViewCell.checkOneButtonCover setHidden:NO];
            }
            
            
      
        
      
            
         //add
        objc_setAssociatedObject(shoppingCarStypeTableViewCell.oneAddImageView, "edit", shoppingCarStypeTableViewCell.oneNumEditText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        objc_setAssociatedObject(shoppingCarStypeTableViewCell.oneAddImageView, "NSIndexPath",indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
              shoppingCarStypeTableViewCell.oneAddImageView.tag=i;
       [ shoppingCarStypeTableViewCell.oneAddImageView addTarget:self action:@selector(oneAddImageViewClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            
            if ([row.merchSaleType isEqualToString:@"2"]||[row.merchSaleType isEqualToString:@"3"]) {//不在销售期 无货
                [shoppingCarStypeTableViewCell.oneAddImageView setEnabled:NO];
            }else
            {
                [shoppingCarStypeTableViewCell.oneAddImageView setEnabled:YES];
            }
        
        //reduce
        objc_setAssociatedObject(shoppingCarStypeTableViewCell.reduceImageView, "edit", shoppingCarStypeTableViewCell.oneNumEditText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(shoppingCarStypeTableViewCell.reduceImageView, "NSIndexPath",indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                 shoppingCarStypeTableViewCell.reduceImageView.tag=i;
        [ shoppingCarStypeTableViewCell.reduceImageView addTarget:self action:@selector(oneReduceImageViewClicked:) forControlEvents:UIControlEventTouchUpInside];
        
            if ([row.merchSaleType isEqualToString:@"2"]||[row.merchSaleType isEqualToString:@"3"]) {//不在销售期 无货
                [shoppingCarStypeTableViewCell.reduceImageView setEnabled:NO];
            }else
            {
                [shoppingCarStypeTableViewCell.reduceImageView setEnabled:YES];
            }
        
            
            
        ProductType *productType=row.types[i];


            
            //checkOneTitle
        shoppingCarStypeTableViewCell.checkOneTitleTextView.text=productType.normsName;
            
        //edit
        int carfourNum=productType.checkNum;
        shoppingCarStypeTableViewCell.oneNumEditText.text=[NSString  stringWithFormat:@"%d",carfourNum];
           
            
            shoppingCarStypeTableViewCell.oneNumEditText.tag=i;
                 objc_setAssociatedObject(shoppingCarStypeTableViewCell.oneNumEditText, "NSIndexPath",indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [shoppingCarStypeTableViewCell.oneNumEditText addTarget:self action:@selector(oneNumEditTextEditTextDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
            
                 [shoppingCarStypeTableViewCell.oneNumEditText addTarget:self action:@selector(oneNumEditTextEditTextDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
            
            if ([row.merchSaleType isEqualToString:@"2"]||[row.merchSaleType isEqualToString:@"3"]) {//不在销售期 无货
                [shoppingCarStypeTableViewCell.oneNumEditText setEnabled:NO];
            }else
            {
                [shoppingCarStypeTableViewCell.oneNumEditText setEnabled:YES];
            }
            
            
            UITapGestureRecognizer *onenumguest=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneNumEditTextTapHandle:)];
       
            onenumguest.delegate = self;
            onenumguest.cancelsTouchesInView = NO;
            
            [shoppingCarStypeTableViewCell.oneNumEditText  addGestureRecognizer:onenumguest];
       
            
            shoppingCarStypeTableViewCell.oneNumEditText.keyboardType=UIKeyboardTypeNumberPad;
            
           //limitTextView
         shoppingCarStypeTableViewCell.oneLimitTextView.text=[NSString  stringWithFormat:@"限购%d套",productType.limitBuy];
//        
        
            
            
      
        
            i++;
    }
    
    
    
    //产品名字
    cell.productNameTextView.text= row.merchName;
    

    NSString *url=row.merchPicID;
    if (url!=nil && ![url isKindOfClass:[NSNull class]])
    {
        [cell.productPicImageView setImageWithURL: [NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"productpic.png"]];
        
        NSString *state= row.merchSaleType;
        [self picstate:state imageView:cell.picSate];
    }
    
    //cancelX
     [cell.cancelXImageView  setImage:[UIImage imageNamed:@"uncancelx.png"] forState:UIControlStateNormal];
     [cell.cancelXImageView  setImage:[UIImage imageNamed:@"cancelx.png"] forState:UIControlStateSelected];
    
       objc_setAssociatedObject(cell.cancelXImageView, "NSIndexPath",indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
          [cell.cancelXImageView addTarget:self action:@selector(cancelXImageViewClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //shoppingCarCheck
    
    if ([row.merchSaleType isEqualToString:@"2"]||[row.merchSaleType isEqualToString:@"3"]) {//不在销售期 无货
        [ cell.shoppingCarCheckImageView setHidden:YES];
        [ cell.shoppingCarCheckImageViewCover setHidden:YES];
    }else
    {
        [ cell.shoppingCarCheckImageView setHidden:NO];
        [ cell.shoppingCarCheckImageViewCover setHidden:NO];
    }
    
     cell.shoppingCarCheckImageView.selected=row.isProductCheck;
    
    if (cell.shoppingCarCheckImageView.selected==true) {
        cell.shoppingCarCheckImageViewCover.selected=true;
    }else
    {
        cell.shoppingCarCheckImageViewCover.selected=false;
    }
     [cell.shoppingCarCheckImageViewCover  setBackgroundImage:[UIImage imageNamed:@"shoppingcar_uncheck.png"] forState:UIControlStateNormal];
     [cell.shoppingCarCheckImageViewCover  setBackgroundImage:[UIImage imageNamed:@"shoppingcar_check.png"] forState:UIControlStateSelected];
    
      objc_setAssociatedObject(cell.shoppingCarCheckImageView, "NSIndexPath",indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [cell.shoppingCarCheckImageView addTarget:self action:@selector(shoppingCarCheckImageViewClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
    
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;


}
-(void)oneNumEditTextTapHandle:(UITapGestureRecognizer *)sender

{
    
        CGPoint point = [sender locationInView:self.view];
    touchy=point.y+15;
    
    if(keyboardHeight>0)
    {
    if(touchy>keyboardHeight)
    {
        movelength=touchy-keyboardHeight;
        [self MoveView:(-movelength)];
    }else
    {
        movelength=0;
        [self MoveView:(-movelength)];
    }}

        NSLog(@"handleSingleTap!pointx:%f,y:%f",point.x,point.y);
    
    // [[[UIApplication sharedApplication] keyWindow] endEditing:NO];
}

-(void)clickimg:(NSIndexPath *)indexPath
{
    RespondParam0032 *row=((Section *)sections[indexPath.section]).sectionRows[indexPath.row];
    NSString* busino= row.busiNo;
    NSString* merchid= row.merchID;
    if ([busino isEqualToString:@"71"]) {
        NSString* merchnum=[NSString stringWithFormat:@"%d",row.buyNum];
        float price = row.buyPrice;
        GxhPostageViewController* gxhPostageView =[[GxhPostageViewController alloc]initWithNibName:@"GxhPostageViewController" bundle:nil];
        gxhPostageView.merchNum = merchnum;
        gxhPostageView.merchPrice=price;
        gxhPostageView.merchId=merchid;
        gxhPostageView.isModify=@"";
        gxhPostageView.fromflag=@"1";
        gxhPostageView.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:gxhPostageView animated:YES];
        
    }
    else
    {
        ProductdetailViewController* productDetailView = [[ProductdetailViewController alloc]init];
        ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
        productOrderForm.productNo =merchid;
        productOrderForm.businNo =busino;
        
        productDetailView.busiNo =busino;
        productDetailView.productId =merchid;
        productDetailView.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:productDetailView animated:YES];
    }
}



-(void)oneNumEditTextEditTextDidEnd:(UITextField *)textField{
    [self.view becomeFirstResponder];
  
    int nownum=[textField.text intValue];
    
    int i=textField.tag;
    
    NSIndexPath *indexPath = objc_getAssociatedObject(textField, "NSIndexPath");
    
    RespondParam0032 *row=((Section *)sections[indexPath.section]).sectionRows[indexPath.row];
    ProductType *pro=row.types[i];
    
    int caroneNum=pro.checkNum;
    int limitnum=pro.limitBuy;
  
    
    whichSection=indexPath.section;
    whichRow=indexPath.row;
    whichtype=i;
       oldCheckNum=caroneNum;
    
    if(nownum==caroneNum)
    {
        return;
    }
    
    if(nownum<1)
    {
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        msgReturn.errorCode=@"-100";//不能为空
        msgReturn.errorDesc=@"购买数量不能小于1";
        msgReturn.errorType=@"01";
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        textField.text=[NSString stringWithFormat:@"%d",caroneNum] ;
        return;
    }
    
    if (nownum>limitnum) {
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        msgReturn.errorCode=@"-100";//不能为空
        msgReturn.errorDesc=@"超过限购套数";
        msgReturn.errorType=@"01";
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
        textField.text=[NSString stringWithFormat:@"%d",caroneNum] ;
        return;
        
        
    }
    
    
    
 
    pro.checkNum=nownum;
    
   // [self countTotalPrice];
    
    //if (pro.isCheck)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self request0034:row productType:pro wantnum:nownum];
        });
        
    }


}

-(void)oneNumEditTextEditTextDidBegin:(UITextField *)textField
{

}




-(void)fourNumEditTextEditTextDidEndOnExit:(UITextField *)textField{
    
    [self.view becomeFirstResponder];
}


-(void)deleteAllImageViewhandTap
{
    
    NSMutableArray *rows=[[NSMutableArray alloc ] init];
    for (Section *section in sections ) {
        for ( RespondParam0032 *row in section.sectionRows)
        {
            
            if(row.isProductCheck)
            {
                [rows addObject:row];
            }
            
            
        }
        
    }
    
    if ([rows count]==0) {
        
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        msgReturn.errorCode=@"-0003";//长度超长
        msgReturn.errorPic=true;
        msgReturn.errorDesc=@"请选择产品";
        [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){}];
        
        return;
    }
   
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:9999 inSection:9999];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"确定删除所选的项？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
    objc_setAssociatedObject(alertView, "NSIndexPath",indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [alertView show];
    
}


 -(void)cancelXImageViewClicked:(UIButton *)btn{
    
          NSIndexPath *indexPath = objc_getAssociatedObject(btn, "NSIndexPath");
     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"确定删除？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
      objc_setAssociatedObject(alertView, "NSIndexPath",indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
     [alertView show];
     
     

     
 }

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSIndexPath *indexPath = objc_getAssociatedObject(alertView, "NSIndexPath");
    if (buttonIndex==1) {
   
        if (indexPath.row==9999) {
           //批量删除
            
            NSMutableArray *rows=[[NSMutableArray alloc ] init];
            for (Section *section in sections ) {
                for ( RespondParam0032 *row in section.sectionRows)
                {
                 
                    if(row.isProductCheck)
                    {
                        [rows addObject:row];
                    }
                    
                    
                }
                
            }
            
        
             [self request0035:rows];

        }else
        {
        RespondParam0032 *row=((Section *)sections[indexPath.section]).sectionRows[indexPath.row];
       
             NSMutableArray *rows=[[NSMutableArray alloc ] init];
            [rows addObject:row];
            
         
            
            [self request0035:rows];

        }
        
        
        
    }

}

-(void)shoppingCarCheckImageViewClicked:(UIButton *)btn{
    // btn.selected = !btn.selected ;
    
    NSIndexPath *indexPath = objc_getAssociatedObject(btn, "NSIndexPath");
    
    RespondParam0032 *row=((Section *)sections[indexPath.section]).sectionRows[indexPath.row];

    if ( row.isProductCheck!=true) {
        row.isProductCheck=true;
        for (ProductType *type in row.types ) {
            type.isCheck=true;
        }
    }else
    {
        row.isProductCheck=false;
        for (ProductType *type in row.types ) {
            type.isCheck=false;
        }
        
    }
    
    
  
    [self countTotalPrice];
    

    [tableView reloadData];
    //   [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:nil];
}

-(void) countTotalPrice
{
    float total=0;
    for (Section *section in sections)
    {
        NSMutableArray *rows= section.sectionRows;
        
     
        
        
        for (RespondParam0032 *row in rows) {
            
            if (row.isProductCheck) {
                
                for (ProductType  *productType in row.types)
                {
                    if (productType.isCheck) {
                        total+= productType.buyPrice*productType.checkNum;
                    }
                    
                }
            }
            
        }
        
        
        
    }
    
    totalValueTextView.text=[NSString stringWithFormat:@"¥%.2f",total];
}


//加加
     -(void)oneAddImageViewClicked:(UIButton *)btn{
         int i=btn.tag;
         
         id editText = objc_getAssociatedObject(btn, "edit");
         NSIndexPath *indexPath = objc_getAssociatedObject(btn, "NSIndexPath");
         
         RespondParam0032 *row=((Section *)sections[indexPath.section]).sectionRows[indexPath.row];
         ProductType *pro=row.types[i];
         

         
         int caroneNum=pro.checkNum;
         
         whichSection=indexPath.section;
         whichRow=indexPath.row;
         whichtype=i;
         oldCheckNum=caroneNum;
         
         
         if (caroneNum>=pro.limitBuy) {
             
             MsgReturn *msgReturn=[[MsgReturn alloc]init];
            
                 msgReturn.errorCode=@"-100";//不能为空
             msgReturn.errorDesc=@"超过限购套数";
             msgReturn.errorType=@"01";
                 [PromptError changeShowErrorMsg:msgReturn title:@""  viewController:self block:^(BOOL OKCancel){} ];
             return;
         }
         
         caroneNum++;
         
      
         ((UITextField*)editText).text=[NSString  stringWithFormat:@"%d",caroneNum];
         pro.checkNum=caroneNum;
         
         
          // [self countTotalPrice];
         //if (pro.isCheck)
         {
                dispatch_async(dispatch_get_main_queue(), ^{
             [self request0034:row productType:pro wantnum:caroneNum];
                });
         }
         
     }

//减减
     -(void)oneReduceImageViewClicked:(UIButton *)btn{
         
         int i=btn.tag;
         id editText = objc_getAssociatedObject(btn, "edit");
         
         NSIndexPath *indexPath = objc_getAssociatedObject(btn, "NSIndexPath");
         
         RespondParam0032 *row=((Section *)sections[indexPath.section]).sectionRows[indexPath.row];
         ProductType *pro=row.types[i];
         
         int caroneNum=pro.checkNum;
       
         whichSection=indexPath.section;
         whichRow=indexPath.row;
         whichtype=i;
         oldCheckNum=caroneNum;
         
         if (caroneNum>1) {
             caroneNum--;
         }else
         {
             caroneNum=1;
         }
         
         
         
         ((UITextField*)editText).text=[NSString  stringWithFormat:@"%d",caroneNum];
         
           pro.checkNum=caroneNum;
         
          // [self countTotalPrice];
         
       
         //if (pro.isCheck)
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                         [self request0034:row productType:pro wantnum:caroneNum];
             });
     
         }
         
     }
     
     
     
-(void)checkOneButtonClicked:(UIButton *)btn{
   
    
   // btn.selected = !btn.selected ;//用与button做checkBox
    
    int i=btn.tag;
    
    NSIndexPath *indexPath = objc_getAssociatedObject(btn, "NSIndexPath");
    
    RespondParam0032 *row=((Section *)sections[indexPath.section]).sectionRows[indexPath.row];
    ProductType *pro=row.types[i];
    
    
    if (pro.isCheck!=true) {
        pro.isCheck=true;
        
        row.isProductCheck=true;
        
    }else
    {
        pro.isCheck=false;
        
        
        bool allTypeUncheck=true;
        for ( ProductType *pro in row.types) {
            if(pro.isCheck)
            {
                allTypeUncheck=false;
            }
        }
        
        if (allTypeUncheck) {
            row.isProductCheck=false;
        }else
        {
            row.isProductCheck=true;
        }
        
    }
    
     [self countTotalPrice];
    

    [self.tableView reloadData];
     //[self.tableView reloadData];
   // [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:nil];
    

//    int index=0;
//    for (Section *section in sections ) {
//        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:nil];
//        index++;
//    }
}






//关键方法，获取复用的Cell后模拟赋值，然后取得Cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier = ShoppingCarIdentifier;
    ShoppingCarTableViewCell *cell= [self.cacheCells objectForKey:reuseIdentifier];
    if (!cell) {
        cell=[self.tableView dequeueReusableCellWithIdentifier:ShoppingCarIdentifier];
        [self.cacheCells setObject:cell forKey:reuseIdentifier];
    }

    

    RespondParam0032 *row=((Section *)sections[indexPath.section]).sectionRows[indexPath.row];

    
    

    
    
    int j=0;
    for (ProductType *producttype in row.types)
    {
        
        ShoppingCarStype2TableViewCell *shoppingCarStypeTableViewCell = [[[NSBundle mainBundle] loadNibNamed:@"ShoppingCarStype2TableViewCell" owner:self options:nil] lastObject];
        
        [shoppingCarStypeTableViewCell setFrame:CGRectMake(0, j*shoppingCarStypeTableViewCell.frame.size.height , cell.onePriceContainer.frame.size.width, shoppingCarStypeTableViewCell.frame.size.height)];
        
        [cell.onePriceContainer addSubview:shoppingCarStypeTableViewCell];
        [cell.onePriceContainer setFrame:CGRectMake(cell.onePriceContainer.frame.origin.x, cell.onePriceContainer.frame.origin.y, cell.onePriceContainer.frame.size.width, (j+1)*shoppingCarStypeTableViewCell.frame.size.height)];
        
        
        j++;
    }
    
    
    
    

    
    //[cell.productPicImageView  setFrame:CGRectMake(  cell.productPicImageView.frame.origin.x,   cell.productPicImageView.frame.origin.y,   cell.productPicImageView.frame.size.width,   cell.onePriceContainer.frame.size.width)];
    
    int y=0;
    if(cell.productPicImageView.frame.origin.y+cell.productPicImageView.frame.size.height>cell.onePriceContainer.frame.origin.y+cell.onePriceContainer.frame.size.height)
    {
        y=cell.productPicImageView.frame.origin.y+cell.productPicImageView.frame.size.height;
    }else
    {
        y= cell.onePriceContainer.frame.origin.y+cell.onePriceContainer.frame.size.height;
    }
    
    int i=0;
    for (ProductType *producttype in row.types)
    {
        
        
        
        ShoppingCarStypeTableViewCell *shoppingCarStypeTableViewCell = [[[NSBundle mainBundle] loadNibNamed:@"ShoppingCarStypeTableViewCell" owner:self options:nil] lastObject];
        
        [shoppingCarStypeTableViewCell setFrame:CGRectMake(0, i*shoppingCarStypeTableViewCell.frame.size.height , cell.oneContainer.frame.size.width, shoppingCarStypeTableViewCell.frame.size.height)];
        
        [cell.oneContainer addSubview:shoppingCarStypeTableViewCell];
        
        
       
        
        [cell.oneContainer setFrame:CGRectMake(cell.oneContainer.frame.origin.x,y, cell.oneContainer.frame.size.width, (i+1)*shoppingCarStypeTableViewCell.frame.size.height)];
        
        
        
        
        
        
        
        i++;
    }
    

    
    int height=cell.oneContainer.frame.origin.y+cell.oneContainer.frame.size.height;

    
    
    return height;
}




- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88;
}

//点击后，过段时间cell自动取消选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    //消除cell选择痕迹
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.05f];
}
- (void)deselect
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}
-(void) setUiValue{
    
    ////back
    //[backImageView setImage:[UIImage imageNamed:@"1.jpeg"]]
    //[backImageView setImageWithURL:[NSURL URLWithString:  placeholderImage:[UIImage imageNamed:@"default.jpg"]];
    ////购物车
    //[titleTextView setValue:]
    ////合计
    //[totalTitleTextView setValue:]
    ////¥22.00
    //[totalValueTextView setValue:]
}




/*购物车查询0032*/
NSString  *n0032=@"JY0032";
/*购物车查询0032*/
-(void) request0032{
    
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    
    if (_cstmMsg.cstmNo==nil) {
        return;
    }

    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 会员编号 备注:必填*/
    [businessparam setValue:_cstmMsg.cstmNo forKey:@"cstmNo"];
    /* 业务代号 备注:选填*/
    [businessparam setValue:@"" forKey:@"busiNo"];
    
  
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0032 business:businessparam delegate:self viewController:self];
}



/*拆单*/
NSString  *n0064=@"JY0064";

-(void) request0064:(NSMutableArray*)sections  {
    
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];

    
    
    /* 会员编号 备注:必填*/
    [businessparam setValue:_cstmMsg.cstmNo forKey:@"cstmNo"];
    
    
    
    int count=0;
    for (Section *section in sections)
    {
        NSMutableArray *rows= section.sectionRows;
        
        for (RespondParam0032 *row in rows) {
            
            if (row.isProductCheck) {
                
                
                
                count++;
                
                
            }}}
    
    [businessparam setValue:[NSString stringWithFormat:@"%d", count ] forKey:@"recordNum"];
    
    NSMutableArray *merchIDs=[[NSMutableArray alloc] init ];
     NSMutableArray *busiNos=[[NSMutableArray alloc] init ];
    for (Section *section in sections)
    {
        NSMutableArray *rows= section.sectionRows;
        
        for (RespondParam0032 *row in rows) {
            
            if (row.isProductCheck) {
                
                
                [merchIDs addObject:row.merchID];
                [busiNos addObject:row.busiNo];
                
                
            }}}


    
    
    /* 商品代号 备注:必填*/
    [businessparam setValue:merchIDs forKey:@"merchID"];
   
     [businessparam setValue:busiNos forKey:@"busiNo"];
   
 
    
    
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0064 business:businessparam delegate:self viewController:self];
}




/*购物车修改0034*/
NSString  *n0034=@"JY0034";
/*购物车修改0034*/
-(void) request0034:(RespondParam0032*) row  productType:(ProductType*) productType wantnum:(int)wantnum{
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];

    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 购物车代号 备注:必填*/
    [businessparam setValue:productType.shoppingCartID forKey:@"shoppingCartID"];
    /* 业务代号 备注:必填*/
    [businessparam setValue:row.busiNo forKey:@"busiNo"];
    /* 商品代号 备注:必填*/
    [businessparam setValue:row.merchID forKey:@"merchID"];
    /* 商品规格 备注:必填*/
    [businessparam setValue:productType.normsType forKey:@"normsType"];
    /* 会员编号 备注:必填*/
    [businessparam setValue:_cstmMsg.cstmNo forKey:@"cstmNo"];
    /* 购买数量 备注:必填*/
    [businessparam setValue:[NSString stringWithFormat:@"%d", wantnum]  forKey:@"buyNum"];
    
    
      SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0034 business:businessparam delegate:self viewController:self];
    }




/*购物车删除0035*/
NSString  *n0035=@"JY0035";
/*购物车删除0035*/
-(void) request0035:(NSMutableArray*) rows{
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    
    CstmMsg *cstmsg=[CstmMsg sharedInstance];
    
    /* 会员编号 备注:必填*/
    [businessparam setValue:cstmsg.cstmNo forKey:@"cstmNo"];
 
  
    
    
    int count=0;
  
    NSString *businno=@"";
   
    /* 购物车代号 备注:必填*/
    
    NSMutableArray *ids=[[NSMutableArray alloc] init];
      for (RespondParam0032 *row in rows) {
          businno=row.busiNo;
          for (ProductType *type in row.types) {
        if (type.isCheck) {
            count++;
           [ids addObject:type.shoppingCartID];
        }
 
    }
      }
    
       /* 业务代号 备注:必填*/
      [businessparam setValue:businno forKey:@"busiNo"];
    
    /* 规格数量 备注:必填*/
    [businessparam setValue:[NSString stringWithFormat:@"%d",count] forKey:@"recordNum"];
    
    [businessparam setValue:ids forKey:@"shoppingCartID"];
 
   

    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:n0035 business:businessparam delegate:self viewController:self];
}


/*收货地址查询0011*/
NSString  *nn0011=@"JY0011";
/*收货地址查询0011*/
-(void) request0011{
   
    
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 会员编号 备注:必填*/
    [businessparam setValue:_cstmMsg.cstmNo forKey:@"cstmNo"];
    /* 默认地址查询标志 备注:选填* 0全部  1默认  2非默认*/
     [businessparam setValue:@"1" forKey:@"isDefaultAddress"];
     /* 当前页码 备注:必填*/
    [businessparam setValue:@"1" forKey:@"pageCode"];
    /* 页码大小 备注:必填*/
    [businessparam setValue:@"100" forKey:@"pageNum"];
    
    
    
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:nn0011 business:businessparam delegate:self viewController:self];
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
        
         int tabH=[Device sharedInstance].tabHeight;
        //填白
           [self.whiteView setFrame:CGRectMake(0, guestViewstart, self.guestYouLikeView.frame.size.width, self.view.frame.size.height-self.headView.frame.size.height-tabH-guestViewstart)];
        
        
        [realGuestView setFrame:CGRectMake(0, self.hotTitleTextView.frame.size.height+5, self.guestYouLikeView.frame.size.width, realGuestView.frame.size.height)];
        
        [self.guestYouLikeView addSubview:realGuestView];
        
        
        
        
        
        [self.emptyScrollView setFrame:CGRectMake(0, self.headView.frame.size.height, self.headView.frame.size.width, self.view.frame.size.height-self.headView.frame.size.height-tabH)];
        
        self.emptyScrollView.contentSize=CGSizeMake(self.emptyScrollView.frame.size.width, self.guestYouLikeView.frame.origin.y+self.guestYouLikeView.frame.size.height) ;
        
        
        
    }
    
    
}





/*猜你喜欢0027*/
NSString  *nnn0027=@"JY0027";
/*猜你喜欢0027*/
-(void) request0027{
    
    
    NSMutableDictionary *businessparam=[[NSMutableDictionary alloc] init];
    /* 商品代号 备注:选填*/
    [businessparam setValue:[NSString stringWithFormat:@"%@",@""  ] forKey:@"merchID"];
    
    [businessparam setValue:@"" forKey:@"busiNo"];
    /* 当前页码 备注:必填*/
    [businessparam setValue:@"1" forKey:@"pageCode"];
    /* 页码大小 备注:必填*/
    [businessparam setValue:@"6" forKey:@"pageNum"];
    
    
    CstmMsg *_cstmMsg=[CstmMsg sharedInstance ];
    SysBaseInfo *_sysBaseInfo=[SysBaseInfo sharedInstance];
    
    StampTranCall *stampTranCall=[StampTranCall sharedInstance ];
    
    [stampTranCall jyTranCall:_sysBaseInfo cstmMsg:_cstmMsg formName:nnn0027 business:businessparam delegate:self viewController:self];
}




-(void) ReturnError:(MsgReturn*)msgReturn
{
    
    /*购物车修改0034*/
    if ([msgReturn.formName isEqualToString:n0034]){
            RespondParam0032 *row=((Section *)sections[whichSection]).sectionRows[whichRow];
            ProductType *pro=row.types[whichtype];
    
            pro.checkNum=oldCheckNum;
    
            [self countTotalPrice];
            [self.tableView reloadData];
    
            whichSection=0;
            whichRow=0;
            whichtype=0;
            oldCheckNum=0;
    }
  
}

-(void) ReturnData:(MsgReturn*)msgReturn
{
   
    
    /*购物车查询0032*/
    if ([msgReturn.formName isEqualToString:n0032]){
        
        listData=[[NSMutableDictionary alloc] init];
        sections=[[NSMutableArray alloc] init];
        
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        RespondParam0032 *commonItem1=[[RespondParam0032 alloc]init];
        /* 返回的记录数 备注:循环域开始*/
        commonItem1.recordNum=[[returnDataBody objectForKey:@"recordNum"] intValue];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
        
            self.tableView.backgroundColor = [UIColor whiteColor];
            if(commonItem1.recordNum<1)
            {
                
              [self request0027];
                [self.emptyScrollView setHidden:NO];
                [self.tableView setHidden:YES];
                [self.bottomView setHidden:YES];
            }else
            {
                  [self.emptyScrollView setHidden:YES];
               // [self.emptyView setHidden:YES];
                [self.tableView setHidden:NO];
                 [self.bottomView setHidden:NO];
            }

            
        });
        
        
        for(int i=0;i<commonItem1.recordNum;i++)
        {
            NSString *merchID=[returnDataBody objectForKey:@"merchID"][i];
            
            
            RespondParam0032 *commonItem;
            if (listData!=nil && [listData count]>0 && [listData objectForKey:merchID]!=nil ) {
                commonItem=[listData objectForKey:merchID];
            }else
            {
              commonItem=[[RespondParam0032 alloc]init];
            }
          
            
           
            
            
            /* 购物车代号 备注:*/
            commonItem.shoppingCartID=[returnDataBody objectForKey:@"shoppingCartID"][i];
            /* 业务代号 备注:*/
            commonItem.busiNo=[returnDataBody objectForKey:@"busiNo"][i];
            businNo=commonItem.busiNo;
            /* 商品代号 备注:*/
            commonItem.merchID=[returnDataBody objectForKey:@"merchID"][i];
            
            
            /* 图片URL 备注:*/
            commonItem.merchPicID=[returnDataBody objectForKey:@"merchPicID"][i];
            
            //销售属性 0预售 1销售 2不在销售期 3无货
            commonItem.merchSaleType=[returnDataBody objectForKey:@"merchSaleType"][i];
            
         
            //选中与否
            if ([commonItem.merchSaleType isEqualToString:@"2"]||[commonItem.merchSaleType isEqualToString:@"3"]) {//不在销售期 无货
               commonItem.isProductCheck=false;
            }else
            {
               commonItem.isProductCheck=true;
            }
                
            
            /* 商品名称 备注:*/
            commonItem.merchName=[returnDataBody objectForKey:@"merchName"][i];
            /* 所属机构 备注:店铺名称*/
            commonItem.brchNo=[returnDataBody objectForKey:@"brchNo"][i];
             commonItem.sellerName=[returnDataBody objectForKey:@"brchNo"][i];
            /* 商品规格 备注:20：单张
             30：四方连*/
            commonItem.normsType=[returnDataBody objectForKey:@"normsType"][i];
            
            commonItem.normsName=[returnDataBody objectForKey:@"normsName"][i];
            
            /* 购买价格 备注:*/
            commonItem.buyPrice=[([returnDataBody objectForKey:@"buyPrice"][i]) floatValue];
            
               commonItem.buyNum=[([returnDataBody objectForKey:@"buyNum"][i]) intValue];
              commonItem.limitBuy=[([returnDataBody objectForKey:@"limitBuy"][i]) intValue];
            
            /* 创建时间 备注:*/
            commonItem.gmtCreate=[returnDataBody objectForKey:@"gmtCreate"][i];
            /* 修改时间 备注:*/
            commonItem.gmtModify=[returnDataBody objectForKey:@"gmtModify"][i];
            /* 是否实名验证商品 备注:2015/6/30新增：
             0：需要
             1：不需要*/
            commonItem.needAutonym=[returnDataBody objectForKey:@"needAutonym"][i];
            /* 是否手机验证码商品 备注:2015/6/30新增：
             0：需要
             1：不需要*/
            commonItem.needVerification=[returnDataBody objectForKey:@"needVerification"][i];
            /* 是否支持寄递 备注:2015/6/30新增：
             0：支持
             1：不支持*/
            commonItem.canPost=[returnDataBody objectForKey:@"canPost"][i];
            
            
            
            ProductType *producttype=[[ProductType alloc] init];
            producttype.normsType=commonItem.normsType;
            producttype.normsName=commonItem.normsName;
            producttype.buyPrice=commonItem.buyPrice;
            producttype.checkNum=commonItem.buyNum;
            producttype.limitBuy=commonItem.limitBuy;
            
            //选中与否
            if ([commonItem.merchSaleType isEqualToString:@"2"]||[commonItem.merchSaleType isEqualToString:@"3"]) {//不在销售期 无货
                producttype.isCheck=false;
            }else
            {
              producttype.isCheck=true;
            }
           
            producttype.shoppingCartID=commonItem.shoppingCartID;
            if(commonItem.types==nil)
            {
                commonItem.types=[[NSMutableArray alloc] init];
            }
            [commonItem.types addObject:producttype];
            
    
            
            [listData setObject:commonItem forKey:commonItem.merchID];
           
        }
        
        
        
      
        Section *section=nil;
        [sections removeAllObjects];
        for(RespondParam0032 *obj in [listData allValues])
        {
        
           
                
                
                bool isIn=false;
                
                for (Section *msection in sections) {
                    
                    if([msection.sectionId isEqualToString:obj.sellerName])
                    {
                        isIn=true;
                        section=msection;
                        break;
                    }
                   // NSMutableArray *rows= section.sectionRows;
                }
                if (isIn==false) {
                     section=[[Section alloc ]init ];
                    section.sectionId=obj.sellerName;
                 
                    
                    section.sectionRows=[[NSMutableArray alloc] init];
                    
                    [section.sectionRows addObject:obj];
                    [sections addObject:section];
                }else
                {
                
                    section.sectionId=obj.sellerName;
                   
               
                    
                    [section.sectionRows addObject:obj];
                  
                }
               
                
                   
        }
        
        
        int count=0;
        for (Section *section in sections) {
               NSMutableArray *rows= section.sectionRows;
            count+=[rows count];
        }
        
     
        
        if (count>0) {
        
        
            //角标
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:count];
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            UITabBarItem *tabBarItem = [appDelegate.tabbar.tabBar.items objectAtIndex:1];
            
            [tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d",count]];
        }else
        {
          [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            UITabBarItem *tabBarItem = [appDelegate.tabbar.tabBar.items objectAtIndex:1];
            
            [tabBarItem setBadgeValue:nil];
        }
       
        
        
        [self countTotalPrice];
      
         [tableView reloadData];
        [tableView reloadData];
        
        
    }
    
    
    
    
   
    /*购物车修改0034*/
    if ([msgReturn.formName isEqualToString:n0034]){
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        RespondParam0034 *commonItem=[[RespondParam0034 alloc]init];
        /* 返回的记录数 备注:2015/7/2新增整个循环域内容：
         循环域开始*/
        commonItem.recordNum=[[returnDataBody objectForKey:@"recordNum"] intValue];
        
        

          [self countTotalPrice];
        
        dispatch_async(dispatch_get_main_queue(), ^{
       // [self request0032];
        });

    }
    
    
    
    /*拆单*/
    if ([msgReturn.formName isEqualToString:n0064]){
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        
        //0：需要拆合单提示
        //1：不需要拆合单提示
       int tipflag= [[returnDataBody objectForKey:@"tipFlag"] intValue];
       
        //mergeFlag	拆单标志	字符	1	0：拆单
        //1：合单
        
           mergeFlag= [[returnDataBody objectForKey:@"mergeFlag"] intValue];
       
      
        if (tipflag==0) {
            
       
        MsgReturn *msgReturn=[[MsgReturn alloc]init];
        
        msgReturn.errorCode=@"0073";//不能为空
        msgReturn.errorDesc=@"请选择商品结算方式";
        msgReturn.errorType=@"";
            
        [PromptError changeShowErrorMsg:msgReturn title:nil  viewController:self block:^(int  goOrnotgo){
            
          
            
            if (goOrnotgo==0) {
                return ;
               
            }else if(goOrnotgo==1)
            {
                mergeFlag=0;//拆单
                ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
                productOrderForm.mergeFlag=mergeFlag;
                [self commitShopping ];

                return;
            }
            
            else if(goOrnotgo==2)
            {
                
                mergeFlag=1;//合单
                
                ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
                productOrderForm.mergeFlag=mergeFlag;
                [self commitShopping ];

                return;
            }
            
            } okBtnName:@"取消" cancelBtnName:@"拆单结算" out:@"合并结算" ];
            
        }else
        {
            ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
            productOrderForm.mergeFlag=mergeFlag;
            [self commitShopping ];
        
        }
        
        
        
    }
    
    
    
    
    
    /*购物车删除0035*/
    if ([msgReturn.formName isEqualToString:n0035]){
        NSDictionary *returnData=[msgReturn.map objectForKey:@"returnData"];
        NSDictionary *returnHead=[returnData objectForKey:@"returnHead"];
        NSString *respDesc=[returnHead objectForKey:@"respDesc"];
        NSString *respCode=[returnHead objectForKey:@"respCode"];
        NSDictionary *returnDataBody=[returnData objectForKey:@"returnBody"];
        RespondParam0035 *commonItem=[[RespondParam0035 alloc]init];
        /* 返回的记录数 备注:2015/7/2新增整个循环域内容：
         循环域开始*/
        commonItem.recordNum=[[returnDataBody objectForKey:@"recordNum"] intValue];
        
        dispatch_async(dispatch_get_main_queue(), ^{
              [self request0032];
        });
      
        

    }
    
    
    /*收货地址查询0011*/
    if ([msgReturn.formName isEqualToString:nn0011]){
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
        
        RespondParam0011 *respondParam0011;
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
            /* 是否默认地址 备注:0：是
             其它：否*/
            commonItem.isDefaultAddress=[returnDataBody objectForKey:@"isDefaultAddress"][i];
            /* 本次返回的记录数 备注:循环域结束*/
            if([commonItem.isDefaultAddress isEqualToString:@"0"])
            respondParam0011=commonItem;
        }
        
        if (respondParam0011==nil) {
            ReceiverAddressManageViewController *receiverAddressManageViewController=[[ReceiverAddressManageViewController alloc ] initWithNibName:@"ReceiverAddressManageViewController" bundle:nil];
            
            receiverAddressManageViewController.whereCome=@"ShoppingCarViewController";
            
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:receiverAddressManageViewController animated:NO];
            self.hidesBottomBarWhenPushed=NO;

        }else
        {
        
            ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
            [productOrderForm.shoppingCar setObject:respondParam0011.addressID forKey:@"addressID"];
            
            [productOrderForm.shoppingCar setObject:respondParam0011.cityCode forKey:@"cityCode"];
            
            [productOrderForm.shoppingCar setObject:respondParam0011.countCode forKey:@"streemCode"];
            [productOrderForm.shoppingCar setObject:respondParam0011.provCode forKey:@"proCode"];
           
            
            
            [productOrderForm.shoppingCar setObject:respondParam0011.postCode forKey:@"postCode"];
            
            
            [productOrderForm.shoppingCar setObject:respondParam0011.recvName forKey:@"receiverName"];
            
            [productOrderForm.shoppingCar setObject:respondParam0011.mobileNo forKey:@"receiverPhone"];
            
            [productOrderForm.shoppingCar setObject:respondParam0011.detailAddress forKey:@"receiverAddress"];
            
          
            ConfirmOrderFormViewController *confirmOrderFormViewController=[[ConfirmOrderFormViewController alloc ] initWithNibName:@"ConfirmOrderFormViewController" bundle:nil];
            
            //    [self presentViewController:confirmOrderFormViewController animated:NO completion:^{
            //    
            //    }];
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:confirmOrderFormViewController animated:NO];
   self.hidesBottomBarWhenPushed=NO;
     
        }
    }
    
    
    
    
    /*猜你喜欢0027*/
    if ([msgReturn.formName isEqualToString:nnn0027]){
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
            rowChirld.merchSaleType=commonItem2.merchSaleType;
            rowChirld.picName=commonItem2.merchName;
            rowChirld.picPrice=[NSString stringWithFormat:@"%.2f",commonItem2.merchPrice] ;
            
            //chirld add
            [sectionRow.rowChirlds addObject:rowChirld];
            
            
        }
        
        [self ui:listdata];
        
        
        
    }
    

    

    

}





#pragma mark- 点击textField,根据键盘上移视图
-(void)MoveView:(int)h{
   // if (isUp) {
    
    if (h<0) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationBeginsFromCurrentState: YES];
        self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y + h, self.tableView.frame.size.width, self.tableView.frame.size.height);
        [UIView commitAnimations];
    }else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationBeginsFromCurrentState: YES];
        self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.headView.frame.size.height , self.tableView.frame.size.width, self.tableView.frame.size.height);
        [UIView commitAnimations];
    }
    
    
//    }else{
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:0.3];
//        [UIView setAnimationBeginsFromCurrentState: YES];
//        self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y - h, self.tableView.frame.size.width, self.tableView.frame.size.height);
//        [UIView commitAnimations];
//        isUp = true;
//        
   // }
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












