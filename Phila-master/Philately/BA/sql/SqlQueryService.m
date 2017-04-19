//
//  SqlQueryService.m
//  Philately
//
//  Created by Mirror on 15/7/7.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "SqlQueryService.h"

@implementation SqlQueryService
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



-(ServiceEntity*) queryServiceWithKey:(NSString*) key withcode:(NSString*)code{
    
    [self openDB];
    NSString *sqlQuery;

    sqlQuery = [NSString stringWithFormat:
                          @"SELECT distinct servicekey,servicecode, servicename,servicename_backup1,servicename_backup2,servicename_backup3 FROM %@ where servicekey ='%@' and servicecode ='%@'  ",@"PM_ARRAYSERVICE",key ,code];
    
    NSLog(@"sqlQuery:%@",sqlQuery);
    sqlite3_stmt * statement;
   
    ServiceEntity *ety= [[ServiceEntity alloc] init ];
    
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值,注意这里的列值
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            //            cityEntity *r=[[cityEntity alloc] init ];
            
            
            char *servicekeyCHAR = (char*)sqlite3_column_text(statement, 0);
            NSString *servicekeyStr = [[NSString alloc]initWithUTF8String:servicekeyCHAR];
            ety.serviceKey = servicekeyStr;
            
            char *servicecodechar = (char*)sqlite3_column_text(statement, 1);
            NSString *servicecodestring = [[NSString alloc]initWithUTF8String:servicecodechar];
            ety.serviceCode = servicecodestring;
            
            char *servicenamechar = (char*)sqlite3_column_text(statement, 2);
            NSString *servicenamestring = [[NSString alloc]initWithUTF8String:servicenamechar];
            ety.serviceName =servicenamestring;
            
            char *servicename_backup1char = (char*)sqlite3_column_text(statement, 2);
            NSString *servicename_backup1string = [[NSString alloc]initWithUTF8String:servicename_backup1char];
            ety.serviceName =servicename_backup1string;
            
            char *servicename_backup2char = (char*)sqlite3_column_text(statement, 2);
            NSString *servicename_backup2string = [[NSString alloc]initWithUTF8String:servicename_backup2char];
            ety.serviceName =servicename_backup2string;
            
            char *servicename_backup3char = (char*)sqlite3_column_text(statement, 2);
            NSString *servicename_backup3string = [[NSString alloc]initWithUTF8String:servicename_backup3char];
            ety.serviceName =servicename_backup3string;

        }
    }else{
        NSLog(@"select error:%@",sqlQuery);
        
    }
    sqlite3_close(db);
    return ety;
}

-(NSMutableArray*) queryServiceWithKey:(NSString*) key{
    
    [self openDB];
    NSString *sqlQuery = [NSString stringWithFormat:
                    @"SELECT distinct servicekey,servicecode, servicename,servicename_backup1,servicename_backup2,servicename_backup3 FROM %@ where servicekey ='%@' ",@"PM_ARRAYSERVICE",key];
    
    NSLog(@"sqlQuery:%@",sqlQuery);
    sqlite3_stmt * statement;
    
    NSMutableArray* array =[NSMutableArray array];
    ServiceEntity *ety;
    
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值,注意这里的列值
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            //            cityEntity *r=[[cityEntity alloc] init ];
            
            ety= [[ServiceEntity alloc] init ];
            char *servicekeyCHAR = (char*)sqlite3_column_text(statement, 0);
            NSString *servicekeyStr = [[NSString alloc]initWithUTF8String:servicekeyCHAR];
            ety.serviceKey = servicekeyStr;
            
            char *servicecodechar = (char*)sqlite3_column_text(statement, 1);
            NSString *servicecodestring = [[NSString alloc]initWithUTF8String:servicecodechar];
            ety.serviceCode = servicecodestring;
            
            char *servicenamechar = (char*)sqlite3_column_text(statement, 2);
            NSString *servicenamestring = [[NSString alloc]initWithUTF8String:servicenamechar];
            ety.serviceName =servicenamestring;
            
            char *servicename_backup1char = (char*)sqlite3_column_text(statement, 2);
            NSString *servicename_backup1string = [[NSString alloc]initWithUTF8String:servicename_backup1char];
            ety.serviceName =servicename_backup1string;
            
            char *servicename_backup2char = (char*)sqlite3_column_text(statement, 2);
            NSString *servicename_backup2string = [[NSString alloc]initWithUTF8String:servicename_backup2char];
            ety.serviceName =servicename_backup2string;
            
            char *servicename_backup3char = (char*)sqlite3_column_text(statement, 2);
            NSString *servicename_backup3string = [[NSString alloc]initWithUTF8String:servicename_backup3char];
            ety.serviceName =servicename_backup3string;
            
            [array addObject:ety];
        }
    }else{
        NSLog(@"select error:%@",sqlQuery);
        
    }
    sqlite3_close(db);
    return array;
}

@end
