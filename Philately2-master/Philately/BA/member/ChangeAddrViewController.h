//
//  ChangeAddrViewController.h
//  Philately
//
//  Created by Mirror on 15/6/26.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeAddrViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tfAddr;
@property (weak, nonatomic) IBOutlet UILabel *lbtitle;

@property(nonatomic,strong)void(^doChangeAddr)(NSString* content);

- (IBAction)goback:(id)sender;
- (IBAction)goSave:(id)sender;
-(id)initWithTag:(NSInteger)tag;
@end
