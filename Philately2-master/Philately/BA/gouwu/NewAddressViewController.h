//
//  NewAddressViewController.h
//  Philately
//
//  Created by Mirror on 15/6/26.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CountyViewController.h"
#import "StampTranCall.h"
#import "ShipAddressEntity.h"
#import "DateConvert.h"
@interface NewAddressViewController : UIViewController<UITextFieldDelegate,StampTranCallDelegate>
{
    bool isSelected;
    NSArray* imgarr;
    bool isUp;
    ShipAddressEntity* shipaddr;
    
    bool isModifyAddress;//新增 false   修改true
}

@property (nonatomic) bool isModifyAddress;
@property (weak, nonatomic) IBOutlet UILabel *lbtitle;

@property (weak, nonatomic) IBOutlet UIButton *goback;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UITextField *tfname;
@property (weak, nonatomic) IBOutlet UITextField *tfmobile;
@property (weak, nonatomic) IBOutlet UILabel *lbprov;
@property (weak, nonatomic) IBOutlet UILabel *lbcity;
@property (weak, nonatomic) IBOutlet UILabel *lbcounty;
@property (weak, nonatomic) IBOutlet UITextField *tfaddr;

@property (weak, nonatomic) IBOutlet UITextField *tfpostcode;
@property (weak, nonatomic) IBOutlet UIControl *cityView;

@property (nonatomic) NSString* flag;
@property (nonatomic,retain) NSDictionary *dicProv;
@property (nonatomic)ShipAddressEntity *shipaddr;
@property (weak, nonatomic) IBOutlet UIView *basicView;


- (IBAction)save:(id)sender;
- (IBAction)goback:(id)sender;

- (IBAction)gotoProvView:(id)sender;

-(void)refreshAreaInfo:(ShipAddressEntity*)shipaddress;

@end
