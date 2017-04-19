//
//  AsynImageView.m
//  AsynImage
//
//  Created by administrator on 13-3-5.
//  Copyright (c) 2013年 enuola. All rights reserved.
//

#import "AsynImageView.h"
#import <QuartzCore/QuartzCore.h>
#import <CommonCrypto/CommonDigest.h>

@implementation AsynImageView

@synthesize imageURL1 = _imageURL1;
@synthesize imageURL2 = _imageURL2;
@synthesize placeholderImage = _placeholderImage;

@synthesize fileName = _fileName;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.layer.borderWidth = 2.0;
        self.backgroundColor = [UIColor grayColor];
        
        
        
        
        
    }
    return self;
}

//重写placeholderImage的Setter方法
-(void)setPlaceholderImage:(UIImage *)placeholderImage
{
    if(placeholderImage != _placeholderImage)
    {
        _placeholderImage = placeholderImage;
        self.image = _placeholderImage;    //指定默认图片
    }
}

//重写imageURL的Setter方法
-(void)setImageURL:(NSString *)imageURL1 andImageURL2:(NSString *)imageURL2
{
    
    self.image = _placeholderImage;    //指定默认图片
    _imageURL1 = imageURL1 ;
    _imageURL2 = imageURL2 ;
    
    if(self.imageURL1!=nil && ![self.imageURL1 isEqual:@""])
    {
        [self requestImg:self.imageURL1];
    }
    else
    {
        if(self.imageURL2!=nil && ![self.imageURL2 isEqual:@""])
        {
            [self requestImg:self.imageURL2];
        }
    }
}

-(void)requestImg:(NSString *)imageURL
{
    if(imageURL)
    {
        //确定图片的缓存地址
//        NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
//        NSString *docDir=[path objectAtIndex:0];
//        NSString *tmpPath=[docDir stringByAppendingPathComponent:@"AsynImage"];
//        
//        NSFileManager *fm = [NSFileManager defaultManager];
//        if(![fm fileExistsAtPath:tmpPath])
//        {
//            [fm createDirectoryAtPath:tmpPath withIntermediateDirectories:YES attributes:nil error:nil];
//        }
//        NSArray *lineArray = [imageURL componentsSeparatedByString:@"/"];
//        self.fileName = [NSString stringWithFormat:@"%@/%@", tmpPath, [lineArray objectAtIndex:[lineArray count] - 1]];
        
        self.fileName =[self cachePathForKey:imageURL];
        
        
        //判断图片是否已经下载过，如果已经下载到本地缓存，则不用重新下载。如果没有，请求网络进行下载。
        if(![[NSFileManager defaultManager] fileExistsAtPath:_fileName])
        {
            //下载图片，保存到本地缓存中
            [self loadImage:imageURL];
        }
        else
        {
            //本地缓存中已经存在，直接指定请求的网络图片
            self.image = [UIImage imageWithContentsOfFile:_fileName];
            if (self.setImg) {
                self.setImg(self.image);
            }
        }
    }
}


//网络请求图片，缓存到本地沙河中
-(void)loadImage:(NSString *)imageURL
{
    //对路径进行编码
    @try {
        //请求图片的下载路径
        //定义一个缓存cache
        NSURLCache *urlCache = [NSURLCache sharedURLCache];
        /*设置缓存大小为2M*/
        [urlCache setMemoryCapacity:2*124*1024];
        
        //设子请求超时时间为30s
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:imageURL] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0];
        
        //从请求中获取缓存输出
        NSCachedURLResponse *response = [urlCache cachedResponseForRequest:request];
        if(response != nil)
        {
            //            NSLog(@"如果又缓存输出，从缓存中获取数据");
            [request setCachePolicy:NSURLRequestReturnCacheDataDontLoad];
        }
        
        /*创建NSURLConnection*/
        if(!connection)
            connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
        //开启一个runloop，使它始终处于运行状态
        
        UIApplication *app = [UIApplication sharedApplication];
        app.networkActivityIndicatorVisible = YES;

        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        
    }
    @catch (NSException *exception) {
             NSLog(@"没有相关资源或者网络异常");
    }
    @finally {
        ;//.....
    }
}

#pragma mark - NSURLConnection Delegate Methods
//请求成功，且接收数据(每接收一次调用一次函数)
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(loadData==nil)
    {
        loadData=[[NSMutableData alloc]initWithCapacity:2048];
    }
    [loadData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
}

-(NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    return cachedResponse;
      NSLog(@"将缓存输出");
}

-(NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
{
      NSLog(@"即将发送请求");
    return request;
}
//下载完成，将文件保存到沙河里面
-(void)connectionDidFinishLoading:(NSURLConnection *)theConnection
{
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
    
    //图片已经成功下载到本地缓存，指定图片
    if([loadData writeToFile:_fileName atomically:YES])
    {
        self.image = [UIImage imageWithContentsOfFile:_fileName];
    }

    connection = nil;
    loadData = nil;
    NSLog(@"请求图片加载成功");
    if (self.setImg) {
        self.setImg(self.image);
    }
    
}
//网络连接错误或者请求成功但是加载数据异常
-(void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error
{
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
    
    //如果发生错误，则重新加载
    connection = nil;
    loadData = nil;
//    [self loadImage:self.imageURL1];
    

    NSLog(@"%@",error);
    NSString* picurl=[error.userInfo objectForKey:@"NSErrorFailingURLStringKey"];
    NSLog(@"请求图片加载异常picurl[%@]",picurl);
    if ([picurl isEqual:self.imageURL2]) {
        return;
    }
    
    
    if(self.imageURL2!=nil && ![self.imageURL2 isEqual:@""])
    {
        [self requestImg:self.imageURL2];
    }
    else
    {
        [self requestImg:self.imageURL1];
    }
    
}

/*
 *创建指定图片key的路径
 */
- (NSString *)cachePathForKey:(NSString *)key
{
    const char *str = [key UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    
    //确定图片的缓存地址
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *docDir=[path objectAtIndex:0];
    NSString *tmpPath=[docDir stringByAppendingPathComponent:@"AsynImage"];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if(![fm fileExistsAtPath:tmpPath])
    {
        [fm createDirectoryAtPath:tmpPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return [tmpPath stringByAppendingPathComponent:filename];
}

@end
