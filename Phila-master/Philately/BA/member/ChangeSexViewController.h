//
//  changeSexViewController.h
//  Philately
//
//  Created by Mirror on 15/6/25.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeSexViewController : UIViewController
{
    NSString* sexFlag;
    NSArray* imgarr;
}

- (IBAction)goback:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbtitle;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img0;

@property (nonatomic) NSString* sexFlag;

@property(nonatomic,strong)void(^doSelectSex)(NSString* sexFlag);

@end
