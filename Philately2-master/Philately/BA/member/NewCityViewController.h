//
//  NewCityViewController.h
//  Philately
//
//  Created by gdpost on 15/10/20.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CityEntity.h"

@interface NewCityViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSArray* prolist;
    NSArray* citylist;
    NSArray* countlist;
    
    CityEntity *provEty;
    CityEntity *cityEty;
    CityEntity *countEty;
    
    NSString* provcode;
    NSString* citycode;
    NSString* countcode;
    NSString* provname;
    NSString* cityname;
    NSString* countname;
    

}

@property(nonatomic)NSString* provcode;
@property(nonatomic)NSString* citycode;
@property(nonatomic)NSString* countcode;
@property(nonatomic,strong)void(^cancleClick)();
@property(nonatomic,strong)void(^sureClick)(NSString*provcode,NSString*provname,NSString* citycode , NSString*cityname,NSString*countcode,NSString*countname);



- (IBAction)docancel:(id)sender;
- (IBAction)dosure:(id)sender;

@property (weak, nonatomic) IBOutlet UIPickerView *picker;

-(void)initdata;


@end
