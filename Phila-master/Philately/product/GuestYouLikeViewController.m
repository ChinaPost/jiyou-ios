


#import "GuestYouLikeViewController.h"
#import "UIImageView+WebCache.h"
#import <Foundation/Foundation.h>
#import <PublicFramework/JSONKit.h>
#import <objc/runtime.h>
#import "GuestYouLikeTableViewCell.h"
#import "RespondParam0027.h"
#import "SectionRowChirld.h"
#import "ProductOrderForm.h"
#import "ProductdetailViewController.h"
#import "OrderFormPayViewController.h"
#import "UIButton+WebCache.h"
//注入table功能
 NSString *GuestYouLikeCellIdentifier = @"GuestYouLikeTableViewCell";
 NSString *GuestYouLikeCellHeadIdentifier = @"GuestYouLikeTableViewCellHead";
@implementation GuestYouLikeViewController
@synthesize cacheCells;
//猜你喜欢
@synthesize titleTextView;
//lineyellow
@synthesize lineyellowImageView;
//list
@synthesize tableView;

@synthesize parent;
- (void)viewDidLoad
{
    [super viewDidLoad];

  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handTap)];
    //[self.modifyPwdTextView addGestureRecognizer:tap];
}

//-(void)handTap{
//    [self presentViewController:updatePwdViewController animated:NO completion:^{}];
//[self dismissViewControllerAnimated:NO completion:^(){}]; 
//};
-(void) viewWillAppear:(BOOL)animated{
//table
//[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}


-(void)viewDidLayoutSubviews
{//table被挡住时用
    // int viewHeight=self.view.frame.size.height;
    //[tableView setFrame:CGRectMake(0, 20, 320 ,100)];
    
}




-(UIView*) setUiValue:(NSMutableArray*)mdata type:(NSString*)mtype delegate:(id<GuestYouLikeChirldViewCallBackDelegate>)parent{//RespondParam0027


    
    self.chirldViewCallBackDelegate=parent;
    self.parent=parent;
    UIView *view=[[UIView alloc] init];
    
    int cellTotalHeight=0;
    int x=0;
    int y=0;
    int width=0;
    
    int count=0;
    if(mdata!=nil && [mdata count]>6)
    {
        count=6;
    }else
    {
        count=[mdata count];
    }
    
    for (int i=0; i<count; i++) {
        
        GuestYouLikeTableViewCell  *cell = [[[NSBundle mainBundle] loadNibNamed:@"GuestYouLikeTableViewCell" owner:self options:nil] lastObject];
    
        
      
            Row *row=[mdata objectAtIndex:i];
            NSArray *chirlds=row.rowChirlds;
        
        [cell.p1View setHidden:NO];
        [cell.p2View setHidden:NO];
        
        [cell.p3View setHidden:NO];
     
        
        int y1=0;
        if ([chirlds count]>0) {
            
            //product1Pic
            NSString *url=((Chirld*)chirlds[0]).pic;
            {
                [cell.product1PicButton setImageWithURL: [NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"productpic.png"]];
            }
            
            [self picstate:((Chirld*)chirlds[0]).merchSaleType imageView:cell.pic1state];
            
            NSString *productId=((Chirld*)chirlds[0]).productId;
            NSString *busiNo=((Chirld*)chirlds[0]).businNo;
            objc_setAssociatedObject(cell.product1PicButton, "busiNo", busiNo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//控件与数据绑定
            objc_setAssociatedObject(cell.product1PicButton, "productId", productId, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//控件与数据绑定
            
            
            [cell.product1PicButton addTarget:self action:@selector(product1PicButtonclicked:) forControlEvents:UIControlEventTouchUpInside];
            
            y1=cell.product1PicButton.frame.origin.y+cell.product1PicButton.frame.size.height;
            
            //product1Name
            cell.product1NameTextView.text= ((Chirld*)chirlds[0]).picName;
            y1=[self labelFrame:y1  label:cell.product1NameTextView];
            
            float price1= [((Chirld*)chirlds[0]).picPrice floatValue];
            cell.product1PriceTextView.text=[NSString stringWithFormat:@"¥%.2f",price1] ;
            
            y1=[self labelFrame:y1  label:cell.product1PriceTextView];
            
            
        }else
        {
            [cell.p1View setHidden:YES];
            [cell.p2View setHidden:YES];
            
            [cell.p3View setHidden:YES];

        }

        
        int y2=0;
        
            if ([chirlds count]>1) {
        
               
        
                //product2Pic
                NSString *url=((Chirld*)chirlds[1]).pic;
                if (url!=nil && ![url isKindOfClass:[NSNull class]])
                {
                [cell.product2PicButton setImageWithURL: [NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"productpic.png"]];
                }
                
                 [self picstate:((Chirld*)chirlds[1]).merchSaleType imageView:cell.pic2state];
                NSString *productId=((Chirld*)chirlds[1]).productId;
                
                NSString *busiNo=((Chirld*)chirlds[1]).businNo;
                objc_setAssociatedObject(cell.product2PicButton, "busiNo", busiNo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//控件与数据绑定
                
                objc_setAssociatedObject(cell.product2PicButton, "productId", productId, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//控件与数据绑定
                
                [cell.product2PicButton addTarget:self action:@selector(product2PicButtonclicked:) forControlEvents:UIControlEventTouchUpInside];
                
                 y2=cell.product2PicButton.frame.origin.y+cell.product2PicButton.frame.size.height;
                
                //product2Name
                cell.product2NameTextView.text= ((Chirld*)chirlds[1]).picName;
                y2=[self labelFrame:y2  label:cell.product2NameTextView];

                
                float price2= [((Chirld*)chirlds[1]).picPrice floatValue];
                cell.product2PriceTextView.text=[NSString stringWithFormat:@"¥%.2f",price2] ;
                y2=[self labelFrame:y2  label:cell.product2PriceTextView];

            }else
            {
              
                [cell.p2View setHidden:YES];
                
                [cell.p3View setHidden:YES];
}
        
        
        int y3=0;
        if ([chirlds count]>2) {
            //product3Pic
            NSString *url=((Chirld*)chirlds[2]).pic;
            
            [self picstate:((Chirld*)chirlds[2]).merchSaleType imageView:cell.pic3state];
            
            
            if (url!=nil && ![url isKindOfClass:[NSNull class]])
            {
                [cell.product3PicButton setImageWithURL: [NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"productpic.png"]];
            }
            
            NSString *productId=((Chirld*)chirlds[2]).productId;
            objc_setAssociatedObject(cell.product3PicButton, "productId", productId, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//控件与数据绑定
            
            NSString *busiNo=((Chirld*)chirlds[2]).businNo;
            objc_setAssociatedObject(cell.product3PicButton, "busiNo", busiNo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//控件与数据绑定
            
            [cell.product3PicButton addTarget:self action:@selector(product3PicButtonclicked:) forControlEvents:UIControlEventTouchUpInside];
            
            y3=cell.product3PicButton.frame.origin.y+cell.product3PicButton.frame.size.height;
            
            //product3Name
            cell.product3NameTextView.text= ((Chirld*)chirlds[2]).picName;
            
            y3=[self labelFrame:y3  label:cell.product3NameTextView];
            
            
            //product3Price
            float price3= [((Chirld*)chirlds[2]).picPrice floatValue];
            cell.product3PriceTextView.text=[NSString stringWithFormat:@"¥%.2f",price3] ;
            
            y3=[self labelFrame:y3  label:cell.product3PriceTextView];
            
        }else
        {
          
            
             [cell.p3View setHidden:YES];
        }
        
        
        [self viewFrame:0 height:[self maxY:y1 y2:y2 y3:y3] view:cell.p3View];
       [self viewFrame:0 height:[self maxY:y1 y2:y2 y3:y3] view:cell.p1View];
         [self viewFrame:0 height:[self maxY:y1 y2:y2 y3:y3] view:cell.p2View];
        
        [cell setFrame:CGRectMake(0, cellTotalHeight, cell.frame.size.width, [self maxY:y1 y2:y2 y3:y3])];
        
        int h= cell.frame.size.height;
        width=cell.frame.size.width;
        
        cellTotalHeight+=h;
        
        [view addSubview:cell];
        
        
        
    }
    
    [view  setFrame:CGRectMake(x
                                    , y
                                    , width, cellTotalHeight)];
    

    
   
    
    
    return view;
}

-(int) maxY:(int)y1 y2:(int)y2 y3:(int)y3
{

    if (y1>y2) {
        if (y1>y3) {
            return y1;
        }else
        {
            return y3;
        }
    }else
    {
        if (y2>y3) {
            return y2;
        }else
        {
            return y3;
        }
    }
}

-(void) viewFrame:(int)y height:(int)height view:(UIView*)view
{
    [view setFrame:CGRectMake(view.frame.origin.x
                               , y
                               , view.frame.size.width
                               ,height)];
}

-(int)labelFrame:(int)y label:(UILabel*)label
{

   // [label setNumberOfLines:1];
   //label.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGSize size = [label sizeThatFits:CGSizeMake(label.frame.size.width, MAXFLOAT)];
    
//    
//    [label setFrame:CGRectMake(label.frame.origin.x
//                                                   , y
//                                                   , label.frame.size.width
//                                                   ,size.height)];
//
//    return y+size.height+2;
        [label setFrame:CGRectMake(label.frame.origin.x
                                                       , y
                                                       , label.frame.size.width
                                                       ,label.frame.size.height)];
    
        return y+label.frame.size.height+2;


}


-(void)product3PicButtonclicked:(UIButton *)btn{
    //objc_setAssociatedObject(btn, "productId", productId, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//控件与数据绑定
    id productId = objc_getAssociatedObject(btn, "productId");
   
    id busiNo = objc_getAssociatedObject(btn, "busiNo");
    ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
     productOrderForm.businNo=busiNo;
    productOrderForm.productNo=productId;
    
    if ([parent isKindOfClass:[ProductdetailViewController class]]) {
        
        
//        for (UIViewController* view in self.navigationController.viewControllers) {
//            if ([view isKindOfClass:[ProductdetailViewController class]]) {
//                [((ProductdetailViewController*)view) viewDidLoad];
//               // [self.navigationController popToViewController:view animated:YES];
//            }
//        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadView" object:nil];
    }else
    {
        
        ProductdetailViewController *productdetailViewController=[[ProductdetailViewController alloc ] initWithNibName:@"ProductdetailViewController" bundle:nil];
        parent.hidesBottomBarWhenPushed=YES;
        [parent.navigationController pushViewController:productdetailViewController animated:NO];
        parent.hidesBottomBarWhenPushed=NO;
      
    }

       NSLog(@"productid%@",productId);

}

-(void)product2PicButtonclicked:(UIButton *)btn{
    //objc_setAssociatedObject(btn, "productId", productId, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//控件与数据绑定
    id productId = objc_getAssociatedObject(btn, "productId");
      id busiNo = objc_getAssociatedObject(btn, "busiNo");
    
    ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
     productOrderForm.businNo=busiNo;
    productOrderForm.productNo=productId;
    
    if ([parent isKindOfClass:[ProductdetailViewController class]]) {
//        for (UIViewController* view in self.navigationController.viewControllers) {
//            if ([view isKindOfClass:[ProductdetailViewController class]]) {
//                [((ProductdetailViewController*)view) viewDidLoad];
//                //[self.navigationController popToViewController:view animated:YES];
//            }
//        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadView" object:nil];
    }else
    {
        ProductdetailViewController *productdetailViewController=[[ProductdetailViewController alloc ] initWithNibName:@"ProductdetailViewController" bundle:nil];
         parent.hidesBottomBarWhenPushed=YES;
        [parent.navigationController pushViewController:productdetailViewController animated:NO];
          parent.hidesBottomBarWhenPushed=NO;
        
    }
      NSLog(@"productid%@",productId);
}

-(void)product1PicButtonclicked:(UIButton *)btn{
    //objc_setAssociatedObject(btn, "productId", productId, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//控件与数据绑定
    id productId = objc_getAssociatedObject(btn, "productId");
      id busiNo = objc_getAssociatedObject(btn, "busiNo");
    
    ProductOrderForm *productOrderForm=[ProductOrderForm sharedInstance];
    productOrderForm.businNo=busiNo;
    productOrderForm.productNo=productId;
    
    
    if ([parent isKindOfClass:[ProductdetailViewController class]]) {
        
//        for (UIViewController* view in self.navigationController.viewControllers) {
//            if ([view isKindOfClass:[ProductdetailViewController class]]) {
//                [((ProductdetailViewController*)view) viewDidLoad];
//                //[self.navigationController popToViewController:view animated:YES];
//            }
//        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadView" object:nil];
    }else
    {
        
        
        
        ProductdetailViewController *productdetailViewController=[[ProductdetailViewController alloc ] initWithNibName:@"ProductdetailViewController" bundle:nil];
         parent.hidesBottomBarWhenPushed=YES;
        [parent.navigationController pushViewController:productdetailViewController animated:NO];
          parent.hidesBottomBarWhenPushed=NO;
        
    }
      NSLog(@"productid%@",productId);
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


