//
//  AsynImageView.h
//  AsynImage
//
//  Created by administrator on 13-3-5.
//  Copyright (c) 2013年 enuola. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface AsynImageView : UIImageView
{
    NSURLConnection *connection;
    NSMutableData *loadData;
}
//图片对应的缓存在沙河中的路径
@property (nonatomic, retain) NSString *fileName;

//指定默认未加载时，显示的默认图片
@property (nonatomic, retain) UIImage *placeholderImage;
//请求网络图片的URL1
@property (nonatomic, retain) NSString *imageURL1;
//请求网络图片的URL2
@property (nonatomic, retain) NSString *imageURL2;

@property(nonatomic,copy)void(^setImg)(UIImage*img);

-(void)setImageURL:(NSString *)imageURL1 andImageURL2:(NSString *)imageURL2;
@end
