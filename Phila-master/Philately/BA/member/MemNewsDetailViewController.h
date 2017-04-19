//
//  memNewsDetailViewController.h
//  Philately
//
//  Created by Mirror on 15/6/27.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsEntity.h"

@interface MemNewsDetailViewController : UIViewController
{
    NewsEntity * newsEty;
}

@property (weak, nonatomic) IBOutlet UILabel *lbtitle;
@property (weak, nonatomic) IBOutlet UILabel *lbdate;
@property (weak, nonatomic) IBOutlet UITextView *tfcontent;

@property (nonatomic)NewsEntity * newsEty;

-(void)initData:(NewsEntity*)Ety;
- (IBAction)goback:(id)sender;

@end
