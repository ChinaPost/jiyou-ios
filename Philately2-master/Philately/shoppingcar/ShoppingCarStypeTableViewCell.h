//
//  ShoppingCarStypeTableViewCell.h
//  Philately
//
//  Created by apple on 15/8/13.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCarStypeTableViewCell : UITableViewCell


//check
@property (weak, nonatomic) IBOutlet UIButton *checkOneButton;
@property (weak, nonatomic) IBOutlet UIButton *checkOneButtonCover;
//单套
@property (weak, nonatomic) IBOutlet UILabel *checkOneTitleTextView;
//减少

@property (weak, nonatomic) IBOutlet UIButton *reduceImageView;
//单套数量
@property (weak, nonatomic) IBOutlet UITextField *oneNumEditText;

//加
@property (weak, nonatomic) IBOutlet UIButton *oneAddImageView;
//限购五套
@property (weak, nonatomic) IBOutlet UILabel *oneLimitTextView;
@end


