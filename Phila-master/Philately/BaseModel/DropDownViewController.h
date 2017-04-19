//
//  DropDownViewController.h
//  Philately
//
//  Created by apple on 15/7/16.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DropDownDelegate;

@interface DropDownViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

{


NSArray *tableArray;//下拉列表数据



BOOL showList;//是否弹出下拉列表

CGFloat tabheight;//table下拉列表的高度

CGFloat frameHeight;//frame的高度

}

@property (weak, nonatomic) IBOutlet UITableView *tv;
@property (nonatomic,retain) NSArray *tableArray;
@property (strong,nonatomic) NSString *code;
@property (strong,nonatomic) id<DropDownDelegate> delegate;
@property (strong,nonatomic) NSString *name;
@property (weak, nonatomic) IBOutlet UIView *backgroundview;

-(void) setParentView:(UIButton*)btn name:(NSString*)name  delegate:(id<DropDownDelegate>) delegate;

-(void) setUiValue:(NSMutableArray*) arr;

@end


@protocol DropDownDelegate <NSObject>


-(void) dropDownCallBack:(NSString *)code  name:(NSString *)name selectWhich:(int)selectWhich;
@end

@interface DropDownRow : NSObject

@property (strong,nonatomic) NSString  *rowId;
@property (strong,nonatomic) NSString  *rowMsg;
@property (strong,nonatomic) NSString  *rowMsg2;
@property (strong,nonatomic) NSString  *price;

@property (nonatomic) bool check;

@end
