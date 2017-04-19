//
//  SqlQueryCity.m
//  Philately
//
//  Created by Mirror on 15/7/2.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "SqlQueryCity.h"

@implementation SqlQueryCity


-(BOOL) openDB{
    
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];   
    path = [path stringByAppendingPathComponent:@"securedDirectory/POST_JY.db"];
    
//    NSString *path =[[NSBundle mainBundle] pathForResource:@"POST_JY" ofType:@"db"];
    
    //获取数据库路径
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    NSString *documents = [paths objectAtIndex:0];
    //    NSString *database_path = [documents stringByAppendingPathComponent:DBNAME];
    
    //如果数据库存在，则用sqlite3_open直接打开（不要担心，如果数据库不存在sqlite3_open会自动创建）
    //打开数据库，这里的[path UTF8String]是将NSString转换为C字符串，因为SQLite3是采用可移植的C(而不是
    //Objective-C)编写的，它不知道什么是NSString.
    if (sqlite3_open([path UTF8String], &db) == SQLITE_OK) {
        return YES;
    }else{
        NSLog(@"数据库打开失败");
        sqlite3_close(db);
        return NO;
    }
}



-(CityEntity*) queryCityMSG:(NSString*) code withLevel:(NSString*)level{
    
    [self openDB];
    NSString *sqlQuery = [NSString stringWithFormat:
                    @"SELECT distinct superiorid,regionid, regionname FROM %@ where SUPERIORID ='%@' and REGIONCLASS ='%@'  order by regionid asc ",@"PM_REGION",code,level];
    
    NSLog(@"sqlQuery:%@",sqlQuery);
    sqlite3_stmt * statement;
    
    NSMutableArray *superioridarr=[NSMutableArray array];
    NSMutableArray *regionidarr=[NSMutableArray array];
    NSMutableArray *regionnamearr=[NSMutableArray array];
    
    CityEntity *ety= [[CityEntity alloc] init ];
    
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值,注意这里的列值
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
//            cityEntity *r=[[cityEntity alloc] init ];
            
            
            char *superioridCHAR = (char*)sqlite3_column_text(statement, 0);
            NSString *strsuperiorid = [[NSString alloc]initWithUTF8String:superioridCHAR];
            [superioridarr addObject:strsuperiorid];
            
            char *regionidchar = (char*)sqlite3_column_text(statement, 1);
            NSString *regionidstring = [[NSString alloc]initWithUTF8String:regionidchar];
            [regionidarr addObject:regionidstring];

            
            char *regionnamechar = (char*)sqlite3_column_text(statement, 2);
            NSString *regionnamestring = [[NSString alloc]initWithUTF8String:regionnamechar];
            [regionnamearr addObject:regionnamestring];
            
            //NSLog(@"name:%@  age:%d  address:%@",nsNameStr,age, nsAddressStr);
        }
    }else{
        NSLog(@"select error:%@",sqlQuery);
        
    }
    sqlite3_close(db);
    if (superioridarr.count>0) {
        ety.superiorid = superioridarr;
        ety.regionid =regionidarr;
        ety.regionname =regionnamearr;
    }
    else
    {
        ety =nil;
    }
    return ety;
}

-(NSString*) queryCityNameWithRegionid:(NSString*) code{
    
    [self openDB];
    NSString *sqlQuery = [NSString stringWithFormat:
                          @"SELECT distinct regionname FROM %@ where regionid ='%@' ",@"PM_REGION",code];
    
    NSLog(@"sqlQuery:%@",sqlQuery);
    sqlite3_stmt * statement;
    
    NSString * cityName=@"";
    
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值,注意这里的列值
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            //            cityEntity *r=[[cityEntity alloc] init ];
            
            
            
            char *regionnamechar = (char*)sqlite3_column_text(statement, 0);
            NSString *regionnamestring = [[NSString alloc]initWithUTF8String:regionnamechar];
            cityName = regionnamestring;

        }
    }else{
        NSLog(@"select error:%@",sqlQuery);
        
    }
    sqlite3_close(db);

    return cityName;
}

@end



