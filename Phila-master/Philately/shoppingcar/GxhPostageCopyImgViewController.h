//
//  GxhPostageCopyImgViewController.h
//  Philately
//
//  Created by gdpost on 15/9/17.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GxhPostageViewController.h"
#import "GxhPostageCopyImgCellViewController.h"



@interface GxhPostageCopyImgViewController : UIViewController
{
    NSMutableArray* contentList;
    NSMutableArray* mutarr;
    NSString* selectedContentid;
}


@property(nonatomic,retain) NSMutableArray* contentList;


@property (weak, nonatomic) IBOutlet UIScrollView *scorllview;
@property (weak, nonatomic) IBOutlet UIView *basicview;

@property(nonatomic,strong)void(^copyImgWithContentId)(NSString*contentid);
- (IBAction)docancel:(id)sender;
- (IBAction)dosure:(id)sender;

@end
