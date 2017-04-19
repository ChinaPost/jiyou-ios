//
//  TTImagePickerItem.h
//  MultiImagePickerDemo
//
//  Created by Jason Lee on 12-11-2.
//  Copyright (c) 2012年 Jason Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TTImagePickerItemDelegate <NSObject>

-(void)goDeleteImg:(UIImage*)image;

@end

@interface TTImagePickerItem : UIView

@property (strong, nonatomic) UIButton *deleteBtn;
@property (strong, nonatomic) UIImageView *thumbnailImageView;
@property (strong, nonatomic) UIImageView *roundCornerMask;
@property (strong, nonatomic) UIImage *img;
@property(nonatomic,retain)id<TTImagePickerItemDelegate>delegate;

- (id)initWithTTAsset:(UIImage *)img frame:(CGRect)frame;

@end
