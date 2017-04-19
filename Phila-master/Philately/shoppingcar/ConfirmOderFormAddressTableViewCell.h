//
//  ConfirmOderFormAddressTableViewCell.h
//  Philately
//
//  Created by gdpost on 15/8/7.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmOderFormAddressTableViewCell : UITableViewCell


//addressPoint
@property (weak, nonatomic) IBOutlet UIImageView *addressPointImageView;
//配送地址
@property (weak, nonatomic) IBOutlet UILabel *addressTitleTextView;
//收件人
@property (weak, nonatomic) IBOutlet UILabel *receiverTitleTextView;
//张三
@property (weak, nonatomic) IBOutlet UILabel *receiverValueTextView;
//13339489
@property (weak, nonatomic) IBOutlet UILabel *receiverPhoneTextView;
//广东省什么
@property (weak, nonatomic) IBOutlet UILabel *receiverAddressTextView;
@property (weak, nonatomic) IBOutlet UIView *head2;
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;

@end
