//
//  ProductDetailStypeTableViewCell.h
//  Philately
//
//  Created by gdpost on 15/7/28.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailStypeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *oneCheckButton;
//单套
@property (weak, nonatomic) IBOutlet UILabel *oneCheckTitleTextView;
//oneCheckReduce
@property (weak, nonatomic) IBOutlet UIButton *oneCheckReduceButton;
//oneCheckNum
@property (weak, nonatomic) IBOutlet UITextField *oneCheckNumEditText;
//oneCheckAdd
@property (weak, nonatomic) IBOutlet UIButton *oneCheckAddButton;
//单套限购
@property (weak, nonatomic) IBOutlet UILabel *oneCheckLimiteTextView;
@end
