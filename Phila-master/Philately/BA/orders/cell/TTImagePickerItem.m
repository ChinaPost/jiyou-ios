//
//  TTImagePickerItem.m
//  MultiImagePickerDemo
//
//  Created by Jason Lee on 12-11-2.
//  Copyright (c) 2012年 Jason Lee. All rights reserved.
//

#import "TTImagePickerItem.h"
#import "PromptError.h"

@implementation TTImagePickerItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithTTAsset:(UIImage *)img frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _thumbnailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 65)];
        [self addSubview:_thumbnailImageView];
        [_thumbnailImageView setContentMode:UIViewContentModeScaleToFill];
        [_thumbnailImageView setImage:img];
        
        _roundCornerMask = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 65)];
        [self addSubview:_roundCornerMask];
        [_roundCornerMask setContentMode:UIViewContentModeScaleToFill];
        [_roundCornerMask setImage:[UIImage imageNamed:@"TTImagePickerBar_RoundCornerMask"]];
        
        UIImage *deleteBtnBgImage = [UIImage imageNamed:@"TTImagePickerBar_DeleteBtnBg"];
        self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.deleteBtn.frame = (CGRect){-5, -5, deleteBtnBgImage.size};
        [self.deleteBtn setImage:deleteBtnBgImage forState:UIControlStateNormal];
        [self addSubview:self.deleteBtn];
        [self.deleteBtn addTarget:self action:@selector(deleteBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        self.img = img;
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteBtnDidClick:)] ];
    }
    return self;
}


#pragma mark - 

- (void)deleteBtnDidClick:(id)sender
{
    MsgReturn *msgReturn=[[MsgReturn alloc]init];
    
    msgReturn.errorCode=@"0045";//是否确认删除
    [PromptError changeShowErrorMsg:msgReturn title:@"收货地址"  viewController:self block:^(BOOL OKCancel)
     {
         if (OKCancel) {
             if (self.delegate) {
                 [self.delegate goDeleteImg:self.img];    }
         }else
         {
             
         }
         return ;
     }
     ];
    
}

@end
