//
//  touSuCellViewController.h
//  Philately
//
//  Created by Mirror on 15/6/27.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComplaintOrderEntity.h"

@protocol TouSuCellDelegate <NSObject>

-(void)goTouSuDetail:(ComplaintOrderEntity*)Ety;

@end



@interface TouSuCellViewController : UIViewController
{
    ComplaintOrderEntity* complaintOrderEty;
}
@property (weak, nonatomic) IBOutlet UILabel *lbcomplaintNo;
@property (weak, nonatomic) IBOutlet UILabel *lbcomplaintContent;
@property (weak, nonatomic) IBOutlet UILabel *lbstatus;
@property (weak, nonatomic) IBOutlet UILabel *lblinkOrderNo;
@property (weak, nonatomic) IBOutlet UILabel *lbtouSuDate;

@property(nonatomic,retain) ComplaintOrderEntity *complaintOrderEty;
@property(nonatomic,retain)id<TouSuCellDelegate>delegate;

-(void)initcell:(ComplaintOrderEntity*)Ety;

@end
