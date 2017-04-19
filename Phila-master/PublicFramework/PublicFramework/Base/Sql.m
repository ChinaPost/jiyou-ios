//
//  Sql.m
//  Philately
//
//  Created by gdpost on 15/6/25.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import "Sql.h"
#import "ErrorObject.h"
@implementation Sql



-(BOOL) openDB{
   
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    
    path = [path stringByAppendingPathComponent:@"securedDirectory/POST_JY.db"];
    
  
    
    
      NSString *database_path =[[NSBundle mainBundle] pathForResource:path ofType:@"db"];
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
        return NO;
        NSLog(@"数据库打开失败");
        sqlite3_close(db);
    }
}



-(ErrorObject*) selectPM_CODEERRORMSG:(NSString*) code{
    

    
    [self openDB];
    NSString *sqlQuery = [NSString stringWithFormat:
                          @"SELECT * FROM %@ where ERRORCODE='%@'",@"PM_CODEERRORMSG",code];
    sqlite3_stmt * statement;
    
    NSMutableArray *rows=[[NSMutableArray alloc] init ];
    NSString *servicename=@"";
   ErrorObject *errorObject=nil;
    
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值,注意这里的列值
       
        while (sqlite3_step(statement) == SQLITE_ROW) {
             row *r=[[row alloc] init ];
           
            
            char *SERVICEIDchar = (char*)sqlite3_column_text(statement, 0);
            NSString *SERVICEIDstring = [[NSString alloc]initWithUTF8String:SERVICEIDchar];
            r.ERRORCODE=SERVICEIDstring;
            
            char *SERVICEKEYchar = (char*)sqlite3_column_text(statement, 1);
            NSString *SERVICEKEYstring = [[NSString alloc]initWithUTF8String:SERVICEKEYchar];
           r.ERRORDESC=SERVICEKEYstring;
            servicename= SERVICEKEYstring;
            
            char *SERVICECODEchar = (char*)sqlite3_column_text(statement, 2);
            NSString *SERVICECODEstring = [[NSString alloc]initWithUTF8String:SERVICECODEchar];
            r.ERRORTYPE=SERVICECODEstring;
            
            
          
            errorObject=[[ErrorObject alloc ]init ];
            
            errorObject.errorCode=  r.ERRORCODE;
            errorObject.errorDesc=r.ERRORDESC;
            errorObject.errorType=r.ERRORTYPE;
            
            
            [rows addObject:r];
            //NSLog(@"name:%@  age:%d  address:%@",nsNameStr,age, nsAddressStr);
        }
    }else{
        NSLog(@"select error:%@",sqlQuery);
        
    }
    sqlite3_close(db);
    return errorObject;
}


-(ErrorObject*) selectPM_DESCERRORMSG:(ErrorObject*) error1{
    
  
    
    [self openDB];
    NSString *sqlQuery = [NSString stringWithFormat:
                          @"SELECT * FROM %@ where ERRORDESC='%@'",@"PM_DESCERRORMSG",error1.errorDesc];
    sqlite3_stmt * statement;
    
    NSMutableArray *rows=[[NSMutableArray alloc] init ];
    NSString *servicename=@"";
    ErrorObject *errorObject=error1;
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值,注意这里的列值
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            row *r=[[row alloc] init ];
            
            
            char *SERVICEIDchar = (char*)sqlite3_column_text(statement, 0);
            NSString *SERVICEIDstring = [[NSString alloc]initWithUTF8String:SERVICEIDchar];
            r.ERRORDESC=SERVICEIDstring;
            
            char *SERVICEKEYchar = (char*)sqlite3_column_text(statement, 1);
            NSString *SERVICEKEYstring = [[NSString alloc]initWithUTF8String:SERVICEKEYchar];
            r.CHANGEDESC=SERVICEKEYstring;
            servicename=SERVICEKEYstring;
            
            
            
            errorObject.errorDesc=  r.CHANGEDESC;
 
            
            [rows addObject:r];
            //NSLog(@"name:%@  age:%d  address:%@",nsNameStr,age, nsAddressStr);
        }
    }else{
        NSLog(@"select error:%@",sqlQuery);
        
    }
    sqlite3_close(db);
    return errorObject;
}


//配置文件版本
-(NSString*) selectPM_SIGNSERVICE_CONFIGVERSION{
    
    
    
    [self openDB];
    NSString *sqlQuery = [NSString stringWithFormat:
                          @"SELECT * FROM %@ where SERVICEKEY='%@'",@"PM_SIGNSERVICE",@"CONFIGVERSION"];
    sqlite3_stmt * statement;
    
   
    NSString *confiFileVersion=@"";
    
    
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值,注意这里的列值
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            row *r=[[row alloc] init ];
            
         
            
            char *SERVICEVALUEchar = (char*)sqlite3_column_text(statement, 1);
            NSString *SERVICEVALUEString = [[NSString alloc]initWithUTF8String:SERVICEVALUEchar];
            r.ERRORDESC=SERVICEVALUEString;
            confiFileVersion=SERVICEVALUEString;
            
        
        }
    }else{
        NSLog(@"select error:%@",sqlQuery);
        
    }
    sqlite3_close(db);
    return confiFileVersion;
}



@end



@implementation row
@synthesize  SERVICEID;
@synthesize  SERVICEKEY;
@synthesize  SERVICECODE;
@synthesize  SERVICENAME;
@synthesize  SERVICENAME_BACKUP1;
@synthesize  SERVICENAME_BACKUP2;
@synthesize  SERVICENAME_BACKUP3;

@synthesize ERRORCODE;
@synthesize ERRORDESC;
@synthesize ERRORTYPE;



@synthesize CHANGEDESC;
@end

