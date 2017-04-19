#import <UIKit/UIKit.h>
@interface ShoppingCarTableViewCell :UITableViewCell
{
    NSIndexPath*indexPath;
}

//shoppingCarCheck
@property (weak, nonatomic) IBOutlet UIButton *shoppingCarCheckImageView;
@property (weak, nonatomic) IBOutlet UIButton *shoppingCarCheckImageViewCover;
//cancelX
@property (weak, nonatomic) IBOutlet UIButton *cancelXImageView;
//productPic
@property (weak, nonatomic) IBOutlet UIImageView *productPicImageView;
//产品名字
@property (weak, nonatomic) IBOutlet UILabel *productNameTextView;

@property (weak, nonatomic) IBOutlet UIView *oneContainer;

@property (weak, nonatomic) IBOutlet UIView *onePriceContainer;
@property (weak, nonatomic) IBOutlet UIImageView *picSate;

@property(nonatomic,retain)NSIndexPath*indexPath;




@property ( nonatomic) int row;
@property ( nonatomic) int section;



@property(nonatomic,strong)void(^clickimg)(NSIndexPath*indexPath);

-(void)setImgEventClick:(NSIndexPath*)RowindexPath;

@end

