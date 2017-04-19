//
//  SqlQuerySignService.h
//  Philately
//
//  Created by Mirror on 15/7/11.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SignServiceEntity.h"
#import "sqlite3.h"

@interface SqlQuerySignService : NSObject
{
    sqlite3 *db;
}
    
-(BOOL) openDB;
-(SignServiceEntity*) querySignServiceWithKey:(NSString*) key;
@end
