//
//  SectionRowChirld.h
//  Philately
//
//  Created by apple on 15/7/6.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SectionRowChirld : NSObject



@end



@interface Section : NSObject

@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *sectionId;
@property (strong,nonatomic) NSMutableArray *sectionRows;

@end




@interface Row : NSObject


@property (strong,nonatomic) NSMutableArray *rowChirlds;

@end





@interface Chirld : NSObject

@property (strong,nonatomic) NSString *pic;
@property (strong,nonatomic) NSString *picName;
@property (strong,nonatomic) NSString *picPrice;
@property (strong,nonatomic) NSString *productId;
@property (strong,nonatomic) NSString *businNo;

@property (strong,nonatomic) NSString *merchSaleType;

@end
