//
//  DropDown1.h
//  Philately
//
//  Created by gdpost on 15/7/6.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DropDown1 : UIView <UITableViewDelegate,UITableViewDataSource> {
    
    UITableView *tv;//下拉列表
    
    NSArray *tableArray;//下拉列表数据
    
    UIButton *textField;//文本输入框
    
    BOOL showList;//是否弹出下拉列表
    
    CGFloat tabheight;//table下拉列表的高度
    
    CGFloat frameHeight;//frame的高度
    
   
    
}

@property (nonatomic) BOOL isOpen;
@property (nonatomic,retain) UITableView *tv;

@property (nonatomic,retain) NSArray *tableArray;


-(void) setParentView:(UIButton*)btn;
-(void) close;

@end


@interface DropDownRow : NSObject

@property (strong,nonatomic) NSString  *rowId;
@property (strong,nonatomic) NSString  *rowMsg;

@end