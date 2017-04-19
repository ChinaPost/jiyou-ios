//
//  cityEntity.h
//  Philately
//
//  Created by Mirror on 15/7/2.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityEntity : NSObject
{
    
    NSArray *superiorid;
    NSArray *regionid;
    NSArray *regionname;
}

@property (nonatomic)NSArray *superiorid;
@property (nonatomic)NSArray *regionid;
@property (nonatomic)NSArray *regionname;

@end
