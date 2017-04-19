//
//  DropDownViewController.m
//  Philately
//
//  Created by apple on 15/7/16.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "DropDownViewController.h"
#import <objc/runtime.h>



@implementation DropDownViewController

@synthesize tableArray;
@synthesize code;


UIButton *button2;//文本输入框
UILabel *label;//文本输入框

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    
    self.tv.delegate = self;
    
    self.tv.dataSource = self;
    
   
    UITapGestureRecognizer *viewtab = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewhandTap)];
    
    [self.backgroundview addGestureRecognizer:viewtab];
    
  
    
   
}

-(void)viewhandTap
{
   // self.view.hidden=YES;
}

-(void) setParentView:(UIButton*)btn name:(NSString*)name  delegate:(id<DropDownDelegate>) delegate
{
    button2=btn;
    
    self.name=name;
    self.delegate=delegate;
    
}



-(void) setUiValue:(NSMutableArray*) arr
{
    tableArray=arr;
    [self.tv reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return [tableArray count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    static NSString *CellIdentifier = @"Cell";
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    NSString *msg=((DropDownRow*)tableArray[indexPath.row]).rowMsg;
    NSString *price=((DropDownRow*)tableArray[indexPath.row]).price;
    
    if(price==nil)
        price=@"";
    
    cell.textLabel.text =[NSString stringWithFormat:@"%@      %@",msg,price];
    cell.textLabel.tag=[((DropDownRow*)[tableArray objectAtIndex:[indexPath row]]).rowId integerValue];
    
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 35;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{

    

    
    
     code=((DropDownRow*)tableArray[indexPath.row]).rowId;
    NSString *msg=((DropDownRow*)tableArray[indexPath.row]).rowMsg;
    NSString *price=((DropDownRow*)tableArray[indexPath.row]).price;
    if(price==nil)
        price=@"";
    [button2 setTitle:[NSString stringWithFormat:@"%@",msg]  forState:UIControlStateNormal] ;
    [button2 setTitle:[NSString stringWithFormat:@"%@",msg] forState:UIControlStateSelected] ;

  

    
   
    
    [self.delegate dropDownCallBack:code  name:self.name selectWhich:indexPath.row];
    
    self.view.hidden=YES;
    
    
    
    
}

@end



@implementation DropDownRow

@synthesize  rowId;
@synthesize  rowMsg;
@synthesize  rowMsg2;
@synthesize  price;
@synthesize check;
@end