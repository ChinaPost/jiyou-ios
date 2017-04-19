//
//  GxhPostageFuTuViewController.h
//  Philately
//
//  Created by Mirror on 15/7/24.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GxhPostageViewController.h"

@interface GxhPostageFuTuViewController : UIViewController
{
    NSString* contentid;
    CGRect* cgrect;
    ContentClass* contentEty;
}

@property (weak, nonatomic) IBOutlet UILabel *lbtitle;
@property (weak, nonatomic) IBOutlet UIView *basicview;

@property(nonatomic,strong)void(^selectImg)(ContentClass* ety);

//-(void)initDatawith:(NSString*)title withimg:(UIImage*)img withRect:(CGRect*) rect withcontentId:(NSString*)contentId;
-(void)initDatawith:(ContentClass*)ety  withRect:(CGRect*) rect ;
@end
