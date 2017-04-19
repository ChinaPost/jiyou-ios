//
//  memberNewsTableCell.m
//  Philately
//
//  Created by Mirror on 15/6/27.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "memberNewsTableCell.h"

@implementation memberNewsTableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)initcell:(NewsEntity*)Ety
{
    if (Ety==nil) {
        return;
    }
    
    self.lbtitle.text = Ety.infoTitle;
    
//    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[Ety.infoContent dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//    self.lbcontent.attributedText = attributedString;
    
    NSString *createDate =([Ety.gmtCreate isKindOfClass:[NSNull class]])?@"":Ety.gmtCreate;
    
    self.lbdate.text =createDate;
    
//    if ([createDate isEqual:@""]) {
//        self.lbdate.text =@"";
//    }
//    else
//    {
//        if (createDate.length>=10) {
//            
//            
//            NSString *year = [createDate substringToIndex:4];
//            NSString *mon = [createDate substringWithRange:NSMakeRange(5, 2)];
//            NSString *day = [createDate substringWithRange:NSMakeRange(8, 2)];
//            NSString *date = [NSString stringWithFormat:@"%@-%@-%@",year,mon,day];
//            self.lbdate.text =date;
//            
//        }
//        else
//        {
//            self.lbdate.text =@"";
//        }
//        
//    }
}

@end
