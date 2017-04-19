//
//  ConfirmOderFormAddressTableViewCell.m
//  Philately
//
//  Created by gdpost on 15/8/7.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "ConfirmOderFormAddressTableViewCell.h"

@implementation ConfirmOderFormAddressTableViewCell


//addressPoint
@synthesize addressPointImageView;
//配送地址
@synthesize addressTitleTextView;
//收件人
@synthesize receiverTitleTextView;
//张三
@synthesize receiverValueTextView;
//13339489
@synthesize receiverPhoneTextView;
//广东省什么
@synthesize receiverAddressTextView;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
