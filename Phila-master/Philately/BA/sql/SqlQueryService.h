//
//  SqlQueryService.h
//  Philately
//
//  Created by Mirror on 15/7/7.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "ServiceEntity.h"

@interface SqlQueryService : NSObject
{
    sqlite3 *db;
}

-(BOOL) openDB;
-(ServiceEntity*) queryServiceWithKey:(NSString*) key withcode:(NSString*)code;
-(NSMutableArray*) queryServiceWithKey:(NSString*) key;
@end
