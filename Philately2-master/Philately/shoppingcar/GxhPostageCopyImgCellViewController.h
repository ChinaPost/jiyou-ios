//
//  GxhPostageCopyImgCellViewController.h
//  Philately
//
//  Created by gdpost on 15/9/17.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GxhPostageViewController.h"

@interface GxhPostageCopyImgCellViewController : UIViewController
{
    NSArray* imgarr;
    NSString* contentid;
    
}

@property (weak, nonatomic) IBOutlet UIImageView *bigimgview;
@property (weak, nonatomic) IBOutlet UIImageView *smallImgview;
@property (weak, nonatomic) IBOutlet UILabel *lbtitle;
@property (weak, nonatomic) IBOutlet UIView *basicview;


@property(nonatomic,strong)void(^clickimg)(NSString* contentid);

@property(nonatomic)NSString* contentid;


-(void)initdata:(ContentClass*)ety;
-(void)setSelected:(bool)selected;
@end
