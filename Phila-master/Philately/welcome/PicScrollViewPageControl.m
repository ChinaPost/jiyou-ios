//
//  PicScrollViewPageControl.m
//  IosCompoment
//
//  Created by apple on 15/6/13.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PicScrollViewPageControl.h"

@implementation PicScrollViewPageControl

int kDeviceWidth=0;
int kDeviceHeight=0;
NSArray * imageArr;//图片路径字符串数组

-(id) initWithCoder:(NSCoder *)aDecoder
{

    self=[super initWithCoder:aDecoder];
    if(self)
    {
        [[NSBundle mainBundle] loadNibNamed:@"PicScrollViewPageControl" owner:self options:nil];
        
       kDeviceWidth=[UIScreen mainScreen].bounds.size.width;
        kDeviceHeight=[UIScreen mainScreen].bounds.size.height;
        [self initImgArr];
        [self initScrollView];
        [self initPageControl];
       [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(handleSchedule) userInfo:nil repeats:YES];
        
           self.scrollview.showsHorizontalScrollIndicator=NO;
        
           self.pagecontrol.pageIndicatorTintColor = [UIColor blackColor];//设置点的默认颜色，非选中的点
        
            self.pagecontrol.currentPageIndicatorTintColor = [UIColor redColor];;//设置点的选中颜色
        
        
        [self addSubview:self.uiview];
    }
    
    
    
    return self;
}



//    kDeviceWidth=[UIScreen mainScreen].bounds.size.width;
//    kDeviceHeight=[UIScreen mainScreen].bounds.size.height;
//
//    [self initImgArr];
//
//
//    [self initScrollView];
//    [self initPageControl];
//        [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(handleSchedule) userInfo:nil repeats:YES];
//
//    self.scrollview.showsHorizontalScrollIndicator=NO;
//
//   self.pagecontrol.pageIndicatorTintColor = [UIColor blackColor];//设置点的默认颜色，非选中的点
//
//    self.pagecontrol.currentPageIndicatorTintColor = [UIColor redColor];;//设置点的选中颜色

//UIScrollView + UIPageControl +NSTimer 做循环动态播放UIView

//1 实现手动滚动效果：

-(void)initScrollView{
    
    // scrollView=[[UIScrollViewalloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth,kDeviceHeight/3*2)];
    
    self.scrollview.contentSize=CGSizeMake(kDeviceWidth*imageArr.count,kDeviceHeight/3*2);
    
    self.scrollview.delegate=self;
    
    self.scrollview.scrollEnabled=YES;
    
    for(int i=0;i<imageArr.count;i++){
        
        UIImageView * firstImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[imageArr objectAtIndex:i]]];
        
        firstImg.frame=CGRectMake(kDeviceWidth*i, 0, kDeviceWidth, kDeviceHeight/3*2);
        
        [ self.scrollview addSubview:firstImg];
        
    }
    
}

-(void)initImgArr{
    
    imageArr=@[@"11.jpg",@"22.jpg"];
    
}

// 2 加UIPageControl，做翻页效果，即产生白点
//方法实现如下：

-(void)initPageControl{
    
    // self.pagecontrol=[[UIPageControlalloc]initWithFrame:CGRectMake(kDeviceWidth/2-10, kDeviceHeight/3*2-20, 20, 20)];
    
    self.pagecontrol.numberOfPages=imageArr.count;
    
    self.pagecontrol.currentPage=0;
    
    [self.pagecontrol addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
}

//可以不要下面这个方法，此方法是手动点击白点的时候跳转相应页面视图

//点击page控件时，即白点
-(void)changePage:(id)sender{
    int page=self.pagecontrol.currentPage;
    [self.scrollview setContentOffset:CGPointMake(kDeviceWidth*page, 0) animated:YES];
}

//并且记得在手动滚动的时候更改pageControl的页码

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int page=scrollView.contentOffset.x/kDeviceWidth;
    
    self.pagecontrol.currentPage=page;
    
}


bool Tend=YES;

//3 定时任务方法调用：（注意计算好最后一页循环滚动）

-(void)handleSchedule{
    
    ++self.pagecontrol.currentPage;
    
    if(Tend){
        
        [self.scrollview setContentOffset:CGPointMake(0, 0) animated:YES];
        
        self.pagecontrol.currentPage=0;
        
    }else{
        
        [self.scrollview setContentOffset:CGPointMake(self.pagecontrol.currentPage*kDeviceWidth, 0) animated:YES];
        
    }
    
    if (self.pagecontrol.currentPage==self.pagecontrol.numberOfPages-1) {
        
        Tend=YES;
        
    }else{
        
        Tend=NO;
        
    }
}

@end