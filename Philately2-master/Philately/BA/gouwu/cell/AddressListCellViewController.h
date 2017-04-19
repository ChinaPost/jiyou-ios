//
//  AddressListCellViewController.h
//  Philately
//
//  Created by Mirror on 15/7/1.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShipAddressEntity.h"

@protocol AddressListCellDelegate <NSObject>

@required
-(void)godeleteAddr:(ShipAddressEntity *)shipaddress;

@optional
-(void)goAddressDetail:(ShipAddressEntity *)shipaddress;
@end

@interface AddressListCellViewController : UIViewController
{
    bool isSelected;
    NSArray* imgarr;
    ShipAddressEntity *shipaddr;
}
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lbname;
@property (weak, nonatomic) IBOutlet UILabel *lbaddr;
@property (nonatomic) ShipAddressEntity *shipaddr;
@property (weak, nonatomic) IBOutlet UILabel *lbprov;
@property (weak, nonatomic) IBOutlet UIView *chechview;

@property (weak, nonatomic) IBOutlet UIView *addrView;

@property (nonatomic,retain)id<AddressListCellDelegate>delegate;


- (IBAction)godelete:(id)sender;

@end
