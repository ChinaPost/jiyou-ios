//
//  memNewsDetailViewController.m
//  Philately
//
//  Created by Mirror on 15/6/27.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "MemNewsDetailViewController.h"

@interface MemNewsDetailViewController ()

@end

@implementation MemNewsDetailViewController

@synthesize newsEty;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbtitle.text=@"我的消息";
    
    [self initData:newsEty];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData:(NewsEntity*)Ety
{
    if (Ety==nil) {
        return;
    }
    
    self.tfcontent.editable = NO;
    self.lbtitle.text = Ety.infoTitle;
//    self.tfcontent.text =Ety.infoContent;
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[Ety.infoContent dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.tfcontent.attributedText = attributedString;
    
    NSString *createDate =([Ety.gmtCreate isKindOfClass:[NSNull class]])?@"":Ety.gmtCreate;
    if ([createDate isEqual:@""]) {
        self.lbdate.text =@"";
    }
    else
    {
        NSString *year = [createDate substringToIndex:4];
        NSString *mon = [createDate substringWithRange:NSMakeRange(5, 2)];
        NSString *day = [createDate substringWithRange:NSMakeRange(8, 2)];
        NSString *date = [NSString stringWithFormat:@"%@-%@-%@",year,mon,day];
        self.lbdate.text =date;
    }

}

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
