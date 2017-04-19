//
//  PicScrollViewPageControl.h
//  IosCompoment
//
//  Created by apple on 15/6/13.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#ifndef IosCompoment_PicScrollViewPageControl_h
#define IosCompoment_PicScrollViewPageControl_h


#import <UIKit/UIKit.h>
@interface PicScrollViewPageControl : UIView <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *ddd;

@property (strong, nonatomic) IBOutlet UIView *uiview;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIPageControl *pagecontrol;

@end

#endif
