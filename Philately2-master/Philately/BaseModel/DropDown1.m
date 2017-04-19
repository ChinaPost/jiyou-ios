//
//  DropDown1.m
//  Philately
//
//  Created by gdpost on 15/7/6.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "DropDown1.h"
#import "SqlApp.h"

@implementation DropDown1


@synthesize tv,tableArray;


- (void)dealloc

{
    

    
}


-(id)initWithFrame:(CGRect)frame

{
    
    //if (frame.size.height<200) {
        
      //  frameHeight = 200;
        
    //}else{
        
        frameHeight = frame.size.height;
        
    //}
    
    tabheight = frameHeight;
    
    
    
    frame.size.height = 30.0f;
    
    
    
    self=[super initWithFrame:frame];
    
    
    if(self){
        
        showList = NO; //默认不显示下拉框
        
        
        
        tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 0)];
        
        tv.delegate = self;
        
        tv.dataSource = self;
        
        tv.backgroundColor = [UIColor grayColor];
        
        tv.separatorColor = [UIColor lightGrayColor];
        
        tv.hidden = YES;
        
        [self addSubview:tv];
        
        
//        textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 30)];
//        
//        textField.borderStyle=UITextBorderStyleRoundedRect;//设置文本框的边框风格
//        
//        [textField addTarget:self action:@selector(dropdown) forControlEvents:UIControlEventAllTouchEvents];
//        
//        [self addSubview:textField];
        
        
        
    }
    
    return self;
    
}

-(void) setParentView:(UIButton*)btn
{
    textField=btn;
    [self dropdown];
}

-(void)dropdown{
    
    [textField resignFirstResponder];
    
    if (showList) {//如果下拉框已显示，什么都不做
        
        return;
        
    }else {//如果下拉框尚未显示，则进行显示
        
        
        
        CGRect sf = self.frame;
        
        sf.size.height = frameHeight;
        
        
        
        //把dropdownList放到前面，防止下拉框被别的控件遮住
        
        [self.superview bringSubviewToFront:self];
        
        tv.hidden = NO;
        
        showList = YES;//显示下拉框
        
        
        
        CGRect frame = tv.frame;
        
        frame.size.height = 0;
        
        tv.frame = frame;
        
        frame.size.height = tabheight;
        
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        
        self.frame = sf;
        
        tv.frame = frame;
        
        [UIView commitAnimations];
        
    }
    
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
    
    
    
    cell.textLabel.text = ((DropDownRow*)[tableArray objectAtIndex:[indexPath row]]).rowMsg;
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
    
    NSString *title=((DropDownRow*)[tableArray objectAtIndex:[indexPath row]]).rowMsg ;
    
    [textField setTitle:title forState:UIControlStateNormal] ;
    [textField setTag:((DropDownRow*)tableArray[indexPath.row]).rowId];
    
//    showList = NO;
//    
//    tv.hidden = YES;
    
    
    
    CGRect sf = self.frame;
    sf.size.height = 0;
    self.frame = sf;
    
    CGRect frame = tv.frame;
    frame.size.height = 0;
    tv.frame = frame;
    
    
}

-(void) close
{
    CGRect sf = self.frame;
    sf.size.height = 0;
    self.frame = sf;
    
    CGRect frame = tv.frame;
    frame.size.height = 0;
    tv.frame = frame;

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation

{
    
    // Return YES for supported orientations
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    
}


@end




@implementation DropDownRow

@synthesize  rowId;
@synthesize  rowMsg;

@end
