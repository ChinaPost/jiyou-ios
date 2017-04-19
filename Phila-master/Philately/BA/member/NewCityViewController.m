//
//  NewCityViewController.m
//  Philately
//
//  Created by gdpost on 15/10/20.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "NewCityViewController.h"
#import "CityEntity.h"

#import "SqlApp.h"
#import "ErrorObject.h"
#import "CityViewController.h"

@interface NewCityViewController ()

@end

@implementation NewCityViewController
@synthesize countcode;
@synthesize citycode;
@synthesize provcode;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.picker.delegate = self;
    self.picker.dataSource =self;
    
    prolist = [[NSArray alloc]init];
    citylist = [[NSArray array]init];
    countlist = [[NSArray array]init];
    
}

-(void)initdata
{
    
    provEty =[[CityEntity alloc] init];
    SqlQueryCity * queryProv = [[SqlQueryCity alloc]init];
    provEty = [queryProv queryCityMSG:@"000000" withLevel:@"2"];
    
    if ([provcode isEqual:@""]||provcode==nil) {
        provcode = provEty.regionid[0];
    }
    cityEty =[[CityEntity alloc] init];
    cityEty = [queryProv queryCityMSG:provcode withLevel:@"3"];
    
    if ([citycode isEqual:@""]||citycode ==nil) {
        citycode = cityEty.regionid[0];        
    }
    
    countEty =[[CityEntity alloc] init];
    countEty = [queryProv queryCityMSG:citycode withLevel:@"4"];
    
    prolist = provEty.regionname;
    citylist = cityEty.regionname;
    countlist = countEty.regionname;
    
    [self initSelectedProv];
}

-(void)initSelectedProv
{
    if (![provcode isEqual: @""]&& provcode!=nil) {
        for(int i =0;i<prolist.count;i++)
        {
            if ([provEty.regionid[i] isEqualToString:provcode]) {
                [self.picker selectRow:i inComponent:0 animated:YES];
            }
        }
    }
    
    if (![citycode  isEqual: @""]&& citycode!=nil) {
        for(int i =0;i<citylist.count;i++)
        {
            if ([cityEty.regionid[i] isEqualToString:citycode]) {
                [self.picker selectRow:i inComponent:1 animated:YES];
            }
        }
    }
    if (![countcode isEqual: @""]&& countcode!=nil) {
        for(int i =0;i<countlist.count;i++)
        {
            if ([countEty.regionid[i] isEqualToString:countcode]) {
                [self.picker selectRow:i inComponent:2 animated:YES];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger count=0;
    if (component==0) {
        count = prolist.count;
    }
    else if (component==1) {
        count= citylist.count;
    }
    else if (component==2) {
        count= countlist.count;
    }
    return count;
    
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (component==0) {
        return [prolist objectAtIndex:row];
    }
    else if (component==1) {
        return [citylist objectAtIndex:row];
    }
    else {
        return [countlist objectAtIndex:row];
    }
    
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component==0) {
        NSInteger proindex = [pickerView selectedRowInComponent:0];
        provcode = provEty.regionid[proindex];
        provname = provEty.regionname[proindex];
        
        SqlQueryCity * queryProv = [[SqlQueryCity alloc]init];
        
        cityEty = [queryProv queryCityMSG:provcode withLevel:@"3"];
        citylist = cityEty.regionname;
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        NSInteger cityindex = [pickerView selectedRowInComponent:1];
        citycode = cityEty.regionid[cityindex];
        cityname = cityEty.regionname[cityindex];
        
        
        countEty = [queryProv queryCityMSG:citycode withLevel:@"4"];
        countlist = countEty.regionname;
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
        
    }
    else if (component==1) {
        SqlQueryCity * queryProv = [[SqlQueryCity alloc]init];
        
        citycode = cityEty.regionid[row];
        cityname = cityEty.regionname[row];
        
        countEty = [queryProv queryCityMSG:citycode withLevel:@"4"];
        countlist = countEty.regionname;
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
        
    }
    
    
    
}

#pragma mark - 取消事件，确定事件
- (IBAction)docancel:(id)sender {

    if (self.cancleClick) {
        self.cancleClick();
    }
    
}

- (IBAction)dosure:(id)sender {
    
    NSInteger proindex = [self.picker selectedRowInComponent:0];
    provcode = provEty.regionid[proindex];
    provname = provEty.regionname[proindex];
    
    NSInteger cityindex = [self.picker selectedRowInComponent:1];
    citycode = cityEty.regionid[cityindex];
    cityname = cityEty.regionname[cityindex];
    
    NSInteger countindex = [self.picker selectedRowInComponent:2];
    if (countindex==-1) {
        countcode =@"";
        countname =@"";
    }
    else
    {
        countcode = countEty.regionid[countindex];
        countname = countEty.regionname[countindex];
    }
    
    
    if (self.sureClick) {
        self.sureClick(provcode,provname,citycode,cityname,countcode,countname);
    }    
}
@end
