//
//  AddressListCellViewController.m
//  Philately
//
//  Created by Mirror on 15/7/1.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "AddressListCellViewController.h"
#import "SqlQueryCity.h"

@interface AddressListCellViewController ()


@end

@implementation AddressListCellViewController

@synthesize shipaddr;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initdata:shipaddr];

    
    UITapGestureRecognizer *viewTapGuest=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapHandle)];

    [ self.addrView  addGestureRecognizer:viewTapGuest];

}

-(void)initdata:(ShipAddressEntity*)shipaddress
{
    //设置 选择图片
    if ([shipaddress.isDefaultAddr isEqualToString:@"0"]) {
        isSelected =YES;
    }
    else
    {
        isSelected =NO;
    }
    imgarr = @[[UIImage imageNamed:@"check1.png"],[UIImage imageNamed:@"uncheck1.png"]];
    self.img.image = isSelected?imgarr[0]:imgarr[1];
    if (isSelected) {
        [self.chechview setHidden:NO];
    }
    else
    {
        [self.chechview setHidden:YES];
    }
    
    //设置收货人地址信息
    self.lbname.text = [NSString stringWithFormat:@"%@   %@",shipaddress.recvName,shipaddress.mobileNo];
    
    SqlQueryCity * sqlCity = [[SqlQueryCity alloc]init];
    
    NSString* provName = [sqlCity queryCityNameWithRegionid:shipaddress.provCode];
     NSString* cityName = [sqlCity queryCityNameWithRegionid:shipaddress.cityCode];
     NSString* countName = [sqlCity queryCityNameWithRegionid:shipaddress.countCode];
    
    NSString* strprov=[NSString stringWithFormat:@"%@%@%@%@",provName,cityName,countName,shipaddress.detailAddress];
    self.lbprov.text =strprov;
    self.lbaddr.text = [NSString stringWithFormat:@"%@",shipaddress.postCode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 删除地址
- (IBAction)godelete:(id)sender {
    if (self.delegate) {
        [self.delegate godeleteAddr : shipaddr];
    }
}

-(void)viewTapHandle
{
    if (self.delegate) {
        [self.delegate goAddressDetail: shipaddr];
    }
}
@end
