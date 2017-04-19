//
//  ReplaceOrderApplicationCellViewController.h
//  Philately
//
//  Created by Mirror on 15/6/30.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Productitem.h"

@protocol ReplaceOrderApplicationCellDelegate <NSObject>

-(void)upNum:(ProductItem*)Ety;
-(void)downNum:(ProductItem*)Ety;
@end

@interface ReplaceOrderApplicationCellViewController : UIViewController
{
    BOOL isSelected;
    NSArray *imgarr;
    int number;//商品购买数量
    ProductItem* productItem;
}
@property (weak, nonatomic) IBOutlet UILabel *lbname;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UITextField *tfnum;
@property (weak, nonatomic) IBOutlet UIButton *btnadd;
@property (weak, nonatomic) IBOutlet UIButton *btncut;

@property(nonatomic,retain)id<ReplaceOrderApplicationCellDelegate>delegate;

@property(nonatomic,strong)void(^addReplaceProduct)(ProductItem*Ety);
@property(nonatomic,strong)void(^upNum)(ProductItem*Ety);
@property(nonatomic,strong)void(^cutNum)(ProductItem*Ety);

-(void)initData:(ProductItem*)Ety;

- (IBAction)addNum:(id)sender;
- (IBAction)cutNum:(id)sender;

@end
