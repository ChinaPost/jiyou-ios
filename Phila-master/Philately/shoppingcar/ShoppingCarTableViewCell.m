#import <Foundation/Foundation.h>
#import "ShoppingCarTableViewCell.h"
@implementation ShoppingCarTableViewCell
//shoppingCarCheck
@synthesize shoppingCarCheckImageView;
//cancelX
@synthesize cancelXImageView;
//productPic
@synthesize productPicImageView;
//产品名字
@synthesize productNameTextView;


@synthesize oneContainer;
@synthesize onePriceContainer;



@synthesize row;
@synthesize section;


@synthesize indexPath;

-(void)setImgEventClick:(NSIndexPath*)RowindexPath
{
    self.productPicImageView.userInteractionEnabled=YES;
    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
    [self.productPicImageView addGestureRecognizer:tap];
    indexPath = RowindexPath;
}
-(void)click
{
    if (self.clickimg) {
        self.clickimg(indexPath);
    }
}

@end

