//
//  SqlQueryCity.h
//  Philately
//
//  Created by Mirror on 15/7/2.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

#import "CityEntity.h"

@interface SqlQueryCity : NSObject
{
    
    sqlite3 *db;
}

-(BOOL) openDB;
-(CityEntity*) queryCityMSG:(NSString*) code withLevel:(NSString*)level;
-(NSString*) queryCityNameWithRegionid:(NSString*) code;
@end

