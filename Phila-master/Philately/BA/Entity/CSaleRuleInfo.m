//
//  CSaleRuleInfo.m
//  Philately
//
//  Created by gdpost on 15/8/27.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "CSaleRuleInfo.h"

@implementation CSaleRuleInfo

@synthesize strDefMerchID;
@synthesize strReqMerchID;
@synthesize bIsLessSelOne;


-(void)getSaleRuleInfo:(NSMutableArray*)merchID withGxhBiaozhi:(NSMutableArray*)gxhBiaozhi withSaleRule:(NSString*)gxhSaleRule
{

    strDefMerchID =[NSMutableArray array];
    strReqMerchID =[NSMutableArray array];
    
    if (merchID==nil || merchID.count==0) {
        bIsLessSelOne =false;
        return;
    }
    
    
    bIsLessSelOne =true;
    
    bool isall1=true;
    for (int i =0; i<gxhSaleRule.length; i++) {
        NSString* tmpstr = [gxhSaleRule substringWithRange:NSMakeRange(i, 1)];
        if ([tmpstr isEqual:@"0"]) {
            isall1=NO;
            break;
        }
    }
    
    if ([gxhSaleRule isEqual:@""]||isall1) {
        bIsLessSelOne =false;
    }
    
    
    for (int i =0; i<gxhBiaozhi.count; i++) {
        int index =[gxhBiaozhi[i] intValue]-1;
        NSString* tmpstr = [gxhSaleRule substringWithRange:NSMakeRange(index, 1)];
        if ([tmpstr isEqual:@"0"]) {
            [strDefMerchID addObject: merchID[i]];
            [strReqMerchID addObject: merchID[i]];
        }
    }
    
    if (strDefMerchID.count==0) {
        [strDefMerchID addObject:merchID[0]];
    }
    
}
@end
