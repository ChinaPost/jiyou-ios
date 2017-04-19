//
//  SqlQuerySignService.m
//  Philately
//
//  Created by Mirror on 15/7/11.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "SqlQuerySignService.h"

@implementation SqlQuerySignService

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



-(SignServiceEntity*) querySignServiceWithKey:(NSString*) key
{
    [self openDB];
    NSString *sqlQuery = [NSString stringWithFormat:
                          @"SELECT distinct servicekey,servicevalue, remark FROM %@ where servicekey ='%@'  ",@"PM_SIGNSERVICE",key ];
    
    NSLog(@"sqlQuery:%@",sqlQuery);
    sqlite3_stmt * statement;
    
    SignServiceEntity *ety= [[SignServiceEntity alloc] init ];
    
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值,注意这里的列值
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            //            cityEntity *r=[[cityEntity alloc] init ];
            
            
            char *servicekeyCHAR = (char*)sqlite3_column_text(statement, 0);
            NSString *servicekeyStr = [[NSString alloc]initWithUTF8String:servicekeyCHAR];
            ety.serviceKey = servicekeyStr;
            
            char *servicevaluechar = (char*)sqlite3_column_text(statement, 1);
            NSString *servicevaluestring = [[NSString alloc]initWithUTF8String:servicevaluechar];
            ety.serviceValue = servicevaluestring;
            
            char *remarkchar = (char*)sqlite3_column_text(statement, 2);
            NSString *remarkstring = [[NSString alloc]initWithUTF8String:remarkchar];
            ety.remark =remarkstring;            
            
        }
    }else{
        NSLog(@"select error:%@",sqlQuery);
        
    }
    sqlite3_close(db);
    return ety;
}


@end
